import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../shared/widgets/app_widgets.dart';
import 'profile_controller.dart';
import 'widgets/profile_widgets.dart';
import 'digital_id_card_screen.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(profileControllerProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: profileAsync.when(
        data: (profile) => RefreshIndicator(
          onRefresh: () => ref.read(profileControllerProvider.notifier).refreshProfile(),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: ProfileHeroHeader(
                  profile: profile,
                  onEditPhoto: () => ref.read(profileControllerProvider.notifier).pickCropAndUploadProfilePhoto(ImageSource.gallery),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.m, vertical: AppSpacing.l),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    // ── Quick Actions Grid ────────────────────────────────
                    FadeInAnimation(
                      delay: const Duration(milliseconds: 100),
                      child: GridView.count(
                        crossAxisCount: 3,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        mainAxisSpacing: AppSpacing.m,
                        crossAxisSpacing: AppSpacing.m,
                        children: [
                          ActionGridItem(
                            icon: Icons.edit_outlined,
                            label: 'Edit Profile',
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const EditProfileScreen()),
                            ),
                          ),
                          ActionGridItem(
                            icon: Icons.qr_code_scanner,
                            label: 'Scan QR',
                            onTap: () {},
                          ),
                          ActionGridItem(
                            icon: Icons.badge_outlined,
                            label: 'Digital ID',
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const DigitalIDCardScreen()),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.l),

                    // ── Digital ID Preview Card ──────────────────────────
                    FadeInAnimation(
                      delay: const Duration(milliseconds: 200),
                      child: DigitalIDCardPreview(
                        profile: profile,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const DigitalIDCardScreen()),
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.l),

                    // ── Organizational Information ────────────────────────
                    FadeInAnimation(
                      delay: const Duration(milliseconds: 300),
                      child: InfoSectionCard(
                        title: 'Organizational Info',
                        icon: Icons.account_balance_outlined,
                        children: [
                          ProfileInfoTile(
                            icon: Icons.workspace_premium_outlined,
                            label: 'Current Designation',
                            value: profile.primaryPosition,
                          ),
                          ProfileInfoTile(
                            icon: Icons.groups_outlined,
                            label: 'Assigned Committee',
                            value: profile.primaryCommittee,
                          ),
                          ProfileInfoTile(
                            icon: Icons.layers_outlined,
                            label: 'Committee Level',
                            value: profile.committeeLevel,
                          ),
                          ProfileInfoTile(
                            icon: Icons.event_available_outlined,
                            label: 'Joining Date',
                            value: profile.joiningDate,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.m),

                    // ── Personal Information ──────────────────────────────
                    FadeInAnimation(
                      delay: const Duration(milliseconds: 400),
                      child: InfoSectionCard(
                        title: 'Personal Details',
                        icon: Icons.person_outline,
                        children: [
                          ProfileInfoTile(
                            icon: Icons.person_2_outlined,
                            label: 'Full Name',
                            value: profile.fullName,
                          ),
                          ProfileInfoTile(
                            icon: Icons.family_restroom_outlined,
                            label: "Father's Name",
                            value: profile.fatherName ?? '-',
                          ),
                          ProfileInfoTile(
                            icon: Icons.calendar_today_outlined,
                            label: 'Date of Birth',
                            value: profile.dob ?? '-',
                          ),
                          ProfileInfoTile(
                            icon: Icons.water_drop_outlined,
                            label: 'Blood Group',
                            value: profile.bloodGroup ?? '-',
                            iconColor: AppColors.error,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.m),

                    // ── Academic Information ──────────────────────────────
                    FadeInAnimation(
                      delay: const Duration(milliseconds: 500),
                      child: InfoSectionCard(
                        title: 'Academic Details',
                        icon: Icons.school_outlined,
                        children: [
                          ProfileInfoTile(
                            icon: Icons.apartment,
                            label: 'Institution',
                            value: profile.institution ?? '-',
                          ),
                          ProfileInfoTile(
                            icon: Icons.book_outlined,
                            label: 'Department',
                            value: profile.department ?? '-',
                          ),
                          ProfileInfoTile(
                            icon: Icons.date_range_outlined,
                            label: 'Session',
                            value: profile.academicSession ?? '-',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.m),

                    // ── Contact & Address ────────────────────────────────
                    FadeInAnimation(
                      delay: const Duration(milliseconds: 600),
                      child: InfoSectionCard(
                        title: 'Contact & Address',
                        icon: Icons.contact_page_outlined,
                        children: [
                          ProfileInfoTile(
                            icon: Icons.phone_android_outlined,
                            label: 'Primary Mobile',
                            value: profile.phone,
                          ),
                          ProfileInfoTile(
                            icon: Icons.alternate_email_outlined,
                            label: 'Email Address',
                            value: profile.email,
                          ),
                          ProfileInfoTile(
                            icon: Icons.push_pin_outlined,
                            label: 'Present Address',
                            value: '${profile.villageArea}, ${profile.thana}, ${profile.district}',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xxl),

                    // ── Bottom Actions ──────────────────────────────────
                    FadeInAnimation(
                      delay: const Duration(milliseconds: 700),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.m),
                        child: OutlinedButton.icon(
                          onPressed: () => ref.read(profileControllerProvider.notifier).logout(),
                          icon: const Icon(Icons.logout, color: AppColors.error),
                          label: const Text('Logout Account', style: TextStyle(color: AppColors.error)),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: AppColors.error),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xxl),
                  ]),
                ),
              ),
            ],
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator(color: AppColors.primary)),
        error: (e, _) => AppErrorState(message: e.toString(), onRetry: () => ref.read(profileControllerProvider.notifier).refreshProfile()),
      ),
    );
  }
}
