import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../shared/widgets/app_widgets.dart';
import '../../shared/data/mock_member_data.dart';
import '../../shared/domain/member_models.dart';

class EventsListScreen extends ConsumerWidget {
  const EventsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final events = MockMemberData.events;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 120,
            backgroundColor: AppColors.surface,
            surfaceTintColor: Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                'Organization Calendar',
                style: TextStyle(color: AppColors.textHigh, fontWeight: FontWeight.w900, fontSize: 18),
              ),
              centerTitle: false,
              titlePadding: const EdgeInsets.only(left: 56, bottom: 16),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(AppSpacing.m),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final event = events[index];
                  final DateTime dt = DateTime.parse(event.dateTime);
                  final String month = DateFormat('MMM').format(dt);
                  final String day = dt.day.toString();

                  return Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.m),
                    child: FadeInAnimation(
                      delay: Duration(milliseconds: index * 100),
                      child: GestureDetector(
                        onTap: () => context.push('/events/${event.id}'),
                        child: PremiumCard(
                          padding: EdgeInsets.zero,
                          child: IntrinsicHeight(
                            child: Row(
                              children: [
                                // Date Badge
                                Container(
                                  width: 80,
                                  decoration: BoxDecoration(
                                    color: event.status == 'registered' ? AppColors.primary : AppColors.surfaceVariant.withOpacity(0.5),
                                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(24), bottomLeft: Radius.circular(24)),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        month.toUpperCase(),
                                        style: TextStyle(
                                          color: event.status == 'registered' ? Colors.white70 : AppColors.textLow,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w800,
                                          letterSpacing: 1.2,
                                        ),
                                      ),
                                      Text(
                                        day,
                                        style: TextStyle(
                                          color: event.status == 'registered' ? Colors.white : AppColors.primary,
                                          fontSize: 28,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                
                                // Event Details
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(AppSpacing.l),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            StatusBadge(
                                              text: event.type.toUpperCase(),
                                              color: event.type == 'Rally' ? AppColors.accent : AppColors.primary,
                                            ),
                                            if (event.status == 'registered')
                                              const Icon(Icons.check_circle, color: AppColors.primary, size: 16),
                                          ],
                                        ),
                                        const SizedBox(height: 12),
                                        Text(
                                          event.title,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w900,
                                            color: AppColors.textHigh,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Row(
                                          children: [
                                            const Icon(Icons.location_on_outlined, size: 14, color: AppColors.textLow),
                                            const SizedBox(width: 4),
                                            Expanded(
                                              child: Text(
                                                event.location,
                                                style: const TextStyle(color: AppColors.textLow, fontSize: 12),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
                childCount: events.length,
              ),
            ),
          ),
          const SliverPadding(padding: EdgeInsets.only(bottom: 40)),
        ],
      ),
    );
  }
}
