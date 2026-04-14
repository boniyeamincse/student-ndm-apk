import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../shared/providers/member_providers.dart';
import '../../shared/widgets/app_widgets.dart';

class MemberCardScreen extends ConsumerWidget {
  const MemberCardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(profileProvider);

    return Scaffold(
      appBar: const PrimaryAppBar(title: 'Digital Member Card'),
      body: AppScaffoldPadding(
        child: profileAsync.when(
          data: (profile) => Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppSpacing.l),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.primary, AppColors.primaryDark],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Student Movement - NDM',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    const SizedBox(height: 18),
                    Row(
                      children: [
                        AvatarWidget(
                          imageUrl: profile.avatar,
                          fallback: profile.fullName,
                          size: 64,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                profile.fullName,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                profile.memberNo,
                                style: const TextStyle(color: Colors.white70),
                              ),
                              Text(
                                '${profile.primaryPosition} • ${profile.primaryCommittee}',
                                style: const TextStyle(color: Colors.white70),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 16),
                    StatusBadge(text: profile.status.toUpperCase(), color: Colors.white),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              const ContentCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('QR verification placeholder'),
                    SizedBox(height: 8),
                    Text('Card verification QR will be available in next version.'),
                  ],
                ),
              ),
            ],
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => AppErrorState(message: e.toString()),
        ),
      ),
    );
  }
}
