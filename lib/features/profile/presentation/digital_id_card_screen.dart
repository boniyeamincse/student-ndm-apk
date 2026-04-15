import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../shared/domain/member_models.dart';
import '../../shared/widgets/app_widgets.dart';
import 'profile_controller.dart';

class DigitalIDCardScreen extends ConsumerStatefulWidget {
  const DigitalIDCardScreen({super.key});

  @override
  ConsumerState<DigitalIDCardScreen> createState() => _DigitalIDCardScreenState();
}

class _DigitalIDCardScreenState extends ConsumerState<DigitalIDCardScreen> {
  bool _showQrView = false;

  @override
  Widget build(BuildContext context) {
    final profileAsync = ref.watch(profileControllerProvider);

    return Scaffold(
      backgroundColor: AppColors.secondary,
      appBar: AppBar(
        title: const Text('Verified Member ID'),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: profileAsync.when(
        data: (profile) => Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.l),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  padding: const EdgeInsets.all(4),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _ViewChip(
                        label: 'Card View',
                        selected: !_showQrView,
                        onTap: () => setState(() => _showQrView = false),
                      ),
                      _ViewChip(
                        label: 'QR View',
                        selected: _showQrView,
                        onTap: () => setState(() => _showQrView = true),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.l),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 220),
                  child: _showQrView
                      ? _QrOnlyView(
                          key: const ValueKey('qr-view'),
                          fullName: profile.fullName,
                          memberNo: profile.memberNo,
                        )
                      : _BrandedCardView(
                          key: const ValueKey('card-view'),
                          profile: profile,
                        ),
                ),
                const SizedBox(height: 40),
                PrimaryButton(
                  text: _showQrView ? 'Save QR to Gallery' : 'Save Card to Gallery',
                  onPressed: () {},
                ),
                const SizedBox(height: 16),
                SecondaryButton(
                  text: _showQrView ? 'Share QR Code' : 'Share ID Card',
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator(color: Colors.white)),
        error: (e, _) => AppErrorState(message: e.toString()),
      ),
    );
  }
}

class _ViewChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _ViewChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? AppColors.textHigh : Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class _BrandedCardView extends StatelessWidget {
  final MemberProfile profile;

  const _BrandedCardView({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    final qrPayload = 'member_no:${profile.memberNo}|name:${profile.fullName}|status:${profile.status}';

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(AppSpacing.m),
            decoration: const BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.diversity_3, color: Colors.white, size: 24),
                SizedBox(width: 8),
                Text(
                  'STUDENT MOVEMENT - NDM',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.5,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                AvatarWidget(
                  imageUrl: profile.avatar,
                  fallback: profile.fullName,
                  size: 120,
                ),
                const SizedBox(height: 16),
                Text(
                  profile.fullName.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    color: AppColors.textHigh,
                  ),
                ),
                Text(
                  profile.primaryPosition,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 24),
                const Divider(),
                const SizedBox(height: 16),
                LabeledValueRow(label: 'Member ID', value: profile.memberNo),
                LabeledValueRow(label: 'Blood Group', value: profile.bloodGroup ?? '-'),
                LabeledValueRow(label: 'Valid Thru', value: '2026-12-31'),
                const SizedBox(height: 26),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.border),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: QrImageView(
                    data: qrPayload,
                    version: QrVersions.auto,
                    size: 100,
                    backgroundColor: Colors.white,
                    eyeStyle: const QrEyeStyle(
                      eyeShape: QrEyeShape.square,
                      color: AppColors.textHigh,
                    ),
                    dataModuleStyle: const QrDataModuleStyle(
                      dataModuleShape: QrDataModuleShape.square,
                      color: AppColors.textHigh,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'SCAN TO VERIFY',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textLow,
                    letterSpacing: 2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _QrOnlyView extends StatelessWidget {
  final String fullName;
  final String memberNo;

  const _QrOnlyView({
    super.key,
    required this.fullName,
    required this.memberNo,
  });

  @override
  Widget build(BuildContext context) {
    final qrPayload = 'member_no:$memberNo|name:$fullName';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          const Icon(Icons.verified_user, color: AppColors.primary, size: 36),
          const SizedBox(height: 10),
          const Text(
            'MEMBER VERIFICATION QR',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 13,
              letterSpacing: 1.2,
              color: AppColors.textHigh,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            memberNo,
            style: const TextStyle(
              color: AppColors.textMedium,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 20),
          QrImageView(
            data: qrPayload,
            version: QrVersions.auto,
            size: 240,
            backgroundColor: Colors.white,
            eyeStyle: const QrEyeStyle(
              eyeShape: QrEyeShape.square,
              color: AppColors.textHigh,
            ),
            dataModuleStyle: const QrDataModuleStyle(
              dataModuleShape: QrDataModuleShape.square,
              color: AppColors.textHigh,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Present this code for instant member validation',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.textLow),
          ),
        ],
      ),
    );
  }
}
