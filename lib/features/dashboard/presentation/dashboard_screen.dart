import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../shared/widgets/app_widgets.dart';
import 'dashboard_controller.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardAsync = ref.watch(dashboardControllerProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: dashboardAsync.when(
        data: (data) => RefreshIndicator(
          onRefresh: () => ref.read(dashboardControllerProvider.notifier).refresh(),
          color: AppColors.primary,
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              // ── Sovereign Top Navigation ────────────────────────────────
              SliverToBoxAdapter(
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.m, vertical: AppSpacing.s),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AvatarWidget(
                          imageUrl: data.profile.avatar,
                          fallback: data.profile.fullName,
                          size: 40,
                        ),
                        const Text(
                          'NDM Sovereign',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w900,
                            fontSize: 18,
                            letterSpacing: -0.5,
                          ),
                        ),
                        IconButton(
                          onPressed: () => context.push('/notifications'),
                          icon: const Icon(Icons.notifications, color: AppColors.primary),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // ── Greetings Header ────────────────────────────────────────
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(AppSpacing.m, AppSpacing.m, AppSpacing.m, AppSpacing.l),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'GREETINGS',
                        style: TextStyle(
                          color: AppColors.textLow,
                          fontWeight: FontWeight.w800,
                          fontSize: 12,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Good Morning, ${data.profile.fullName.split(' ').first}',
                        style: const TextStyle(
                          color: AppColors.textHigh,
                          fontSize: 28,
                          fontWeight: FontWeight.w900,
                          letterSpacing: -1,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // ── Sovereign ID Card ───────────────────────────────────────
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.m),
                sliver: SliverToBoxAdapter(
                  child: FadeInAnimation(
                    delay: const Duration(milliseconds: 100),
                    child: SovereignMemberCard(
                      fullName: data.profile.fullName,
                      position: data.profile.primaryPosition,
                      memberNo: data.profile.memberNo,
                      avatar: data.profile.avatar,
                      tier: data.profile.membershipTier,
                      status: data.profile.status,
                    ),
                  ),
                ),
              ),

              // ── Core Actions Grid (3x2) ──────────────────────────────────
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(AppSpacing.m, AppSpacing.xl, AppSpacing.m, 0),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'CORE ACTIONS',
                        style: TextStyle(color: AppColors.textLow, fontWeight: FontWeight.w800, fontSize: 12, letterSpacing: 1.2),
                      ),
                      const SizedBox(height: AppSpacing.m),
                      GridView.count(
                        crossAxisCount: 3,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        mainAxisSpacing: AppSpacing.m,
                        crossAxisSpacing: AppSpacing.m,
                        childAspectRatio: 1.0,
                        children: const [
                          QuickActionCard(title: 'My Profile', icon: Icons.person_outline, route: '/profile'),
                          QuickActionCard(title: 'Digital Card', icon: Icons.badge_outlined, route: '/member_card'),
                          QuickActionCard(title: 'Committee', icon: Icons.groups_outlined, route: '/committee'),
                          QuickActionCard(title: 'Notices', icon: Icons.notifications_outlined, route: '/notices'),
                          QuickActionCard(title: 'Events', icon: Icons.event_outlined, route: '/events'),
                          QuickActionCard(title: 'Settings', icon: Icons.settings_outlined, route: '/settings'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // ── Interactive Notice Carousel ────────────────────────────────
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(0, AppSpacing.xl, 0, 0),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.m),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'LATEST NOTICES',
                              style: TextStyle(color: AppColors.textLow, fontWeight: FontWeight.w800, fontSize: 12, letterSpacing: 1.2),
                            ),
                            TextButton(
                              onPressed: () => context.push('/notices'),
                              child: const Text('VIEW ALL', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w900, fontSize: 11)),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: AppSpacing.s),
                      SizedBox(
                        height: 160,
                        child: PageView.builder(
                          controller: PageController(viewportFraction: 0.9),
                          itemCount: data.latestNotices.isNotEmpty ? data.latestNotices.length : 1,
                          itemBuilder: (context, index) {
                            if (data.latestNotices.isEmpty) {
                              return const Padding(
                                padding: EdgeInsets.symmetric(horizontal: AppSpacing.xs),
                                child: AppEmptyState(title: 'No Notices', subtitle: 'You are all caught up.'),
                              );
                            }
                            final notice = data.latestNotices[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
                              child: PremiumCard(
                                padding: const EdgeInsets.all(AppSpacing.m),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          notice.isPinned ? Icons.push_pin : Icons.notifications_active,
                                          color: notice.isPinned ? AppColors.error : AppColors.primary,
                                          size: 16,
                                        ),
                                        const SizedBox(width: AppSpacing.xs),
                                        Text(notice.priority.toUpperCase(), style: TextStyle(color: notice.priority == 'high' || notice.priority == 'urgent' ? AppColors.error : AppColors.primary, fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 1.0)),
                                        const Spacer(),
                                        Text(notice.publishedAt.split(' ').first, style: const TextStyle(color: AppColors.textLow, fontSize: 10, fontWeight: FontWeight.w600)),
                                      ],
                                    ),
                                    const SizedBox(height: AppSpacing.s),
                                    Text(notice.title, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.textHigh)),
                                    const SizedBox(height: AppSpacing.xs),
                                    Text(notice.summary, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 13, color: AppColors.textMedium)),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // ── Events Preview ───────────────────────────────────────
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(AppSpacing.m, AppSpacing.xl, AppSpacing.m, 40),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'UPCOMING EVENTS',
                            style: TextStyle(color: AppColors.textLow, fontWeight: FontWeight.w800, fontSize: 12, letterSpacing: 1.2),
                          ),
                          TextButton(
                            onPressed: () => context.push('/events'),
                            child: const Text('VIEW ALL', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w900, fontSize: 11)),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.m),
                      if (data.latestPosts.isEmpty)
                        const AppEmptyState(title: 'No Events', subtitle: 'There are no upcoming events.'),
                      ...data.latestPosts.take(3).map((post) {
                        final dateStr = post.publishedAt.isNotEmpty ? post.publishedAt : '2026-01-01';
                        final date = DateTime.tryParse(dateStr) ?? DateTime.now();
                        final monthNames = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
                        return ScheduleItem(
                          date: date.day.toString().padLeft(2, '0'),
                          month: monthNames[date.month - 1],
                          title: post.title,
                          time: 'TBA',
                          location: 'TBA',
                          color: AppColors.primary,
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator(color: AppColors.primary)),
        error: (e, stack) => AppErrorState(message: e.toString()),
      ),
    );
  }
}
