import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../shared/widgets/app_widgets.dart';
import '../../shared/data/mock_member_data.dart';
import 'event_registration_success.dart';

class EventDetailScreen extends ConsumerWidget {
  final int id;
  const EventDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final event = MockMemberData.events.firstWhere((e) => e.id == id, orElse: () => MockMemberData.events.first);
    final DateTime dt = DateTime.parse(event.dateTime);
    final String fullDate = DateFormat('EEEE, MMMM d, y').format(dt);
    final String time = DateFormat('hh:mm a').format(dt);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              background: event.imageUrl != null 
                ? Image.network(event.imageUrl!, fit: BoxFit.cover) 
                : Container(color: AppColors.primary),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.l),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StatusBadge(
                    text: event.type.toUpperCase(),
                    color: event.type == 'Rally' ? AppColors.accent : AppColors.primary,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    event.title,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: AppColors.textHigh),
                  ),
                  const SizedBox(height: 24),
                  
                  // Date & Time
                  _InfoRow(
                    icon: Icons.calendar_today_outlined,
                    title: 'Date',
                    subtitle: fullDate,
                  ),
                  _InfoRow(
                    icon: Icons.access_time,
                    title: 'Time',
                    subtitle: time,
                  ),
                  _InfoRow(
                    icon: Icons.location_on_outlined,
                    title: 'Location',
                    subtitle: event.location,
                  ),
                  
                  const SizedBox(height: 24),
                  const Divider(),
                  const SizedBox(height: 24),
                  
                  const Text(
                    'ABOUT THE EVENT',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900, color: AppColors.textLow, letterSpacing: 1.2),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    event.description,
                    style: const TextStyle(fontSize: 15, color: AppColors.textMedium, height: 1.6),
                  ),
                  const SizedBox(height: 32),
                  
                  const Text(
                    'MODERATORS / SPEAKERS',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900, color: AppColors.textLow, letterSpacing: 1.2),
                  ),
                  const SizedBox(height: 16),
                  const Row(
                    children: [
                      AvatarWidget(imageUrl: null, fallback: 'Farzana', size: 40),
                      SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Farzana Islam', style: TextStyle(fontWeight: FontWeight.bold)),
                          Text('Member Secretary', style: TextStyle(color: AppColors.textLow, fontSize: 12)),
                        ],
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 100), // Spacing for fab
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(AppSpacing.l),
        decoration: BoxDecoration(
          color: AppColors.surface,
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -5))],
        ),
        child: PrimaryButton(
          text: event.status == 'registered' ? 'DOWNLOAD ENTRY PASS' : 'REGISTER FOR EVENT',
          onPressed: () {
            if (event.status != 'registered') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EventRegistrationSuccessScreen(event: event)),
              );
            }
          },
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _InfoRow({required this.icon, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.08), borderRadius: BorderRadius.circular(12)),
            child: Icon(icon, size: 20, color: AppColors.primary),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(color: AppColors.textLow, fontSize: 11, fontWeight: FontWeight.w600)),
              Text(subtitle, style: const TextStyle(color: AppColors.textHigh, fontWeight: FontWeight.w800, fontSize: 14)),
            ],
          ),
        ],
      ),
    );
  }
}
