import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../shared/widgets/app_widgets.dart';
import '../../shared/data/mock_member_data.dart';

class NewsDetailScreen extends ConsumerWidget {
  final int id;
  const NewsDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // In a real app, this would be a provider filtering by ID
    final item = MockMemberData.posts.firstWhere((e) => e.id == id, orElse: () => MockMemberData.posts.first);

    return Scaffold(
      backgroundColor: AppColors.surface,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              background: item.imageUrl != null 
                ? Image.network(item.imageUrl!, fit: BoxFit.cover) 
                : Container(color: AppColors.primary),
            ),
            actions: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.share_outlined)),
              IconButton(onPressed: () {}, icon: const Icon(Icons.bookmark_border)),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.l),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      StatusBadge(
                        text: item.type.toUpperCase(),
                        color: item.type == 'statement' ? AppColors.accent : AppColors.primary,
                      ),
                      Text(
                        item.publishedAt,
                        style: const TextStyle(color: AppColors.textLow, fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text(
                    item.title,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w900,
                      color: AppColors.textHigh,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Divider(),
                  const SizedBox(height: 24),
                  Text(
                    item.excerpt,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textMedium,
                      fontStyle: FontStyle.italic,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'The Student Movement - National Democratic Movement (NDM) today released a comprehensive vision document as part of our ongoing commitment to fundamental citizen rights and democratic reforms. This comes at a critical time when our organization is expanding its reach into nearly every major educational institution in the country.\n\nOur teams on the ground have reported overwhelming support for the "Freedom of Expression" initiative, with thousands of new volunteers joining the cause daily. We remain dedicated to ensuring every student voice is heard and every right is protected.\n\nMore updates will follow as we prepare for the National Youth Policy Symposium scheduled for June 2026.',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.textHigh,
                      height: 1.8,
                    ),
                  ),
                  const SizedBox(height: 48),
                  
                  // Related Section
                  const Text(
                    'SHARE STATEMENT',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900, color: AppColors.textLow, letterSpacing: 1.5),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      _SocialIcon(icon: Icons.facebook, color: const Color(0xFF1877F2)),
                      _SocialIcon(icon: Icons.chat_bubble_outline, color: const Color(0xFF25D366)),
                      _SocialIcon(icon: Icons.alternate_email, color: AppColors.textMedium),
                    ],
                  ),
                  const SizedBox(height: 60),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SocialIcon extends StatelessWidget {
  final IconData icon;
  final Color color;
  const _SocialIcon({required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        shape: BoxShape.circle,
        border: Border.all(color: color.withOpacity(0.1)),
      ),
      child: Icon(icon, color: color, size: 24),
    );
  }
}
