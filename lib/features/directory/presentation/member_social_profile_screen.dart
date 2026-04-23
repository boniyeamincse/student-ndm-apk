import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../shared/widgets/app_widgets.dart';
import '../../shared/data/mock_member_data.dart';

class MemberSocialProfileScreen extends ConsumerWidget {
  final int id;
  const MemberSocialProfileScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // In real app, filter from directory list or fetch by ID
    final member = MockMemberData.directoryMembers.firstWhere(
      (m) => m.id == id, 
      orElse: () => MockMemberData.directoryMembers.first
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 280,
            pinned: true,
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [AppColors.primary, AppColors.primary.withOpacity(0.8)],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),
                    AvatarWidget(imageUrl: member.avatar, fallback: member.fullName, size: 100),
                    const SizedBox(height: 16),
                    Text(
                      member.fullName,
                      style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w900),
                    ),
                    Text(
                      'Member NO: ${member.memberNo}',
                      style: const TextStyle(color: Colors.white70, fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.l),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _StatItem(label: 'Level', value: member.committeeLevel),
                      _StatItem(label: 'Tier', value: member.membershipTier),
                      _StatItem(label: 'Joined', value: member.joiningDate.split('-')[0]),
                    ],
                  ),
                  const SizedBox(height: 32),
                  
                  const Text(
                    'POSITION & COMMITTEE',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900, color: AppColors.textLow, letterSpacing: 1.5),
                  ),
                  const SizedBox(height: 12),
                  PremiumCard(
                    padding: const EdgeInsets.all(AppSpacing.l),
                    child: Row(
                      children: [
                        const Icon(Icons.account_tree_outlined, color: AppColors.primary, size: 24),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(member.primaryPosition, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16)),
                              Text(member.primaryCommittee, style: const TextStyle(color: AppColors.textMedium, fontSize: 13)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 32),
                  const Text(
                    'MEMBER BIO',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900, color: AppColors.textLow, letterSpacing: 1.5),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    member.bio,
                    style: const TextStyle(fontSize: 15, color: AppColors.textMedium, height: 1.6),
                  ),
                  
                  const SizedBox(height: 100),
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
        child: Row(
          children: [
            _SocialAction(icon: Icons.phone, color: AppColors.primary, label: 'Call'),
            const SizedBox(width: 12),
            _SocialAction(icon: Icons.chat_bubble_outline, color: const Color(0xFF25D366), label: 'WhatsApp'),
            const SizedBox(width: 12),
            Expanded(
              child: PrimaryButton(
                text: 'EMAIL MEMBER',
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  const _StatItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(value, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: AppColors.primary)),
          Text(label.toUpperCase(), style: const TextStyle(color: AppColors.textLow, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1)),
        ],
      ),
    );
  }
}

class _SocialAction extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;
  const _SocialAction({required this.icon, required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.2)),
        ),
        child: Row(
          children: [
            Icon(icon, color: color, size: 18),
            // const SizedBox(width: 8),
            // Text(label, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
