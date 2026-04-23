import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../shared/widgets/app_widgets.dart';
import '../../shared/data/mock_member_data.dart';

class NoticeListScreen extends ConsumerWidget {
  const NoticeListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notices = MockMemberData.notices;

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
                'Official Notices',
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
                  final notice = notices[index];
                  final isHighPriority = notice.priority == 'high' || notice.priority == 'urgent';

                  return Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.m),
                    child: FadeInAnimation(
                      delay: Duration(milliseconds: index * 100),
                      child: PremiumCard(
                        color: isHighPriority ? AppColors.primary.withOpacity(0.05) : AppColors.surface,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    if (notice.isPinned)
                                      const Padding(
                                        padding: EdgeInsets.only(right: 8.0),
                                        child: Icon(Icons.push_pin, size: 14, color: AppColors.primary),
                                      ),
                                    StatusBadge(
                                      text: notice.priority.toUpperCase(),
                                      color: isHighPriority ? AppColors.accent : AppColors.textLow,
                                    ),
                                  ],
                                ),
                                Text(
                                  notice.publishedAt,
                                  style: const TextStyle(color: AppColors.textLow, fontSize: 11),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text(
                              notice.title,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w900,
                                color: AppColors.textHigh,
                                height: 1.3,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              notice.summary,
                              style: const TextStyle(
                                fontSize: 13,
                                color: AppColors.textMedium,
                                height: 1.5,
                              ),
                            ),
                            const SizedBox(height: 16),
                            InkWell(
                              onTap: () {},
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Mark as Read',
                                    style: TextStyle(
                                      color: AppColors.textLow,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 11,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  const Icon(Icons.check_circle_outline, size: 14, color: AppColors.textLow),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                childCount: notices.length,
              ),
            ),
          ),
          const SliverPadding(padding: EdgeInsets.only(bottom: 40)),
        ],
      ),
    );
  }
}
