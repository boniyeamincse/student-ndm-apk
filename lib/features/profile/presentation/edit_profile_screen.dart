import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../shared/domain/member_models.dart';
import '../../shared/widgets/app_widgets.dart';
import '../data/profile_repository.dart';
import 'profile_controller.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key});

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _fatherNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _institutionController = TextEditingController();
  final _departmentController = TextEditingController();
  final _villageAreaController = TextEditingController();
  final _thanaController = TextEditingController();
  final _districtController = TextEditingController();

  bool _seededFromProfile = false;
  bool _isSaving = false;
  bool _isUploadingPhoto = false;

  @override
  void dispose() {
    _nameController.dispose();
    _fatherNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _institutionController.dispose();
    _departmentController.dispose();
    _villageAreaController.dispose();
    _thanaController.dispose();
    _districtController.dispose();
    super.dispose();
  }

  void _seedFields(MemberProfile profile) {
    if (_seededFromProfile) {
      return;
    }
    _nameController.text = profile.fullName;
    _fatherNameController.text = profile.fatherName ?? '';
    _emailController.text = profile.email;
    _phoneController.text = profile.phone;
    _institutionController.text = profile.institution ?? '';
    _departmentController.text = profile.department ?? '';
    _villageAreaController.text = profile.villageArea;
    _thanaController.text = profile.thana;
    _districtController.text = profile.district;
    _seededFromProfile = true;
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isSaving = true);
    try {
      await ref.read(profileControllerProvider.notifier).updateProfile(
            ProfileUpdatePayload(
              fullName: _nameController.text,
              fatherName: _fatherNameController.text,
              email: _emailController.text,
              phone: _phoneController.text,
              institution: _institutionController.text,
              department: _departmentController.text,
              villageArea: _villageAreaController.text,
              thana: _thanaController.text,
              district: _districtController.text,
            ),
          );

      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully.')),
      );
      Navigator.of(context).pop();
    } catch (_) {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to update profile. Please try again.')),
      );
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  Future<void> _pickAndUploadPhoto() async {
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library_outlined),
                title: const Text('Choose from gallery'),
                onTap: () => Navigator.of(context).pop(ImageSource.gallery),
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera_outlined),
                title: const Text('Take a photo'),
                onTap: () => Navigator.of(context).pop(ImageSource.camera),
              ),
            ],
          ),
        );
      },
    );

    if (source == null) {
      return;
    }

    setState(() => _isUploadingPhoto = true);
    try {
      await ref.read(profileControllerProvider.notifier).pickCropAndUploadProfilePhoto(source);
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile photo updated successfully.')),
      );
    } catch (_) {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to update profile photo. Please try again.')),
      );
    } finally {
      if (mounted) {
        setState(() => _isUploadingPhoto = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final profileAsync = ref.watch(profileControllerProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const PrimaryAppBar(title: 'Edit Member Profile'),
      body: profileAsync.when(
        data: (profile) {
          _seedFields(profile);
          return SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.l),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SectionHeader(title: 'Profile Photo'),
                  const SizedBox(height: AppSpacing.m),
                  PremiumCard(
                    child: Row(
                      children: [
                        AvatarWidget(
                          imageUrl: profile.avatar,
                          fallback: _nameController.text.isEmpty ? profile.fullName : _nameController.text,
                          size: 72,
                        ),
                        const SizedBox(width: AppSpacing.m),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Update your profile photo',
                                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                'Square crop is applied for consistent profile display.',
                                style: TextStyle(color: AppColors.textMedium),
                              ),
                              const SizedBox(height: AppSpacing.s),
                              OutlinedButton.icon(
                                onPressed: _isUploadingPhoto ? null : _pickAndUploadPhoto,
                                icon: _isUploadingPhoto
                                    ? const SizedBox(
                                        width: 16,
                                        height: 16,
                                        child: CircularProgressIndicator(strokeWidth: 2),
                                      )
                                    : const Icon(Icons.camera_alt_outlined),
                                label: Text(_isUploadingPhoto ? 'Uploading...' : 'Change Photo'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.l),
                  const SectionHeader(title: 'Personal Information'),
                  const SizedBox(height: AppSpacing.m),
                  PremiumCard(
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            labelText: 'Full Name',
                            prefixIcon: Icon(Icons.person_outline),
                          ),
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            final text = value?.trim() ?? '';
                            if (text.isEmpty) {
                              return 'Full name is required';
                            }
                            if (text.length < 3) {
                              return 'Full name must be at least 3 characters';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: AppSpacing.m),
                        TextFormField(
                          controller: _fatherNameController,
                          decoration: const InputDecoration(
                            labelText: "Father's Name",
                            prefixIcon: Icon(Icons.family_restroom_outlined),
                          ),
                          textInputAction: TextInputAction.next,
                        ),
                        const SizedBox(height: AppSpacing.m),
                        TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                            labelText: 'Email Address',
                            prefixIcon: Icon(Icons.alternate_email_outlined),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            final text = value?.trim() ?? '';
                            if (text.isEmpty) {
                              return 'Email is required';
                            }
                            if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(text)) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: AppSpacing.m),
                        TextFormField(
                          controller: _phoneController,
                          decoration: const InputDecoration(
                            labelText: 'Mobile Number',
                            prefixIcon: Icon(Icons.phone_android_outlined),
                          ),
                          keyboardType: TextInputType.phone,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            final text = value?.trim() ?? '';
                            if (text.isEmpty) {
                              return 'Mobile number is required';
                            }
                            if (text.length < 10) {
                              return 'Please enter a valid mobile number';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.l),
                  const SectionHeader(title: 'Academic Details'),
                  const SizedBox(height: AppSpacing.m),
                  PremiumCard(
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _institutionController,
                          decoration: const InputDecoration(
                            labelText: 'Institution',
                            prefixIcon: Icon(Icons.apartment_outlined),
                          ),
                          textInputAction: TextInputAction.next,
                        ),
                        const SizedBox(height: AppSpacing.m),
                        TextFormField(
                          controller: _departmentController,
                          decoration: const InputDecoration(
                            labelText: 'Department',
                            prefixIcon: Icon(Icons.book_outlined),
                          ),
                          textInputAction: TextInputAction.next,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.l),
                  const SectionHeader(title: 'Address'),
                  const SizedBox(height: AppSpacing.m),
                  PremiumCard(
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _villageAreaController,
                          decoration: const InputDecoration(
                            labelText: 'Village / Area',
                            prefixIcon: Icon(Icons.place_outlined),
                          ),
                          textInputAction: TextInputAction.next,
                        ),
                        const SizedBox(height: AppSpacing.m),
                        TextFormField(
                          controller: _thanaController,
                          decoration: const InputDecoration(
                            labelText: 'Thana',
                            prefixIcon: Icon(Icons.map_outlined),
                          ),
                          textInputAction: TextInputAction.next,
                        ),
                        const SizedBox(height: AppSpacing.m),
                        TextFormField(
                          controller: _districtController,
                          decoration: const InputDecoration(
                            labelText: 'District',
                            prefixIcon: Icon(Icons.location_city_outlined),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 48),
                  PrimaryButton(
                    text: 'Save Membership Records',
                    loading: _isSaving,
                    onPressed: _isSaving ? null : _saveProfile,
                  ),
                  const SizedBox(height: 16),
                  SecondaryButton(
                    text: 'Cancel Changes',
                    onPressed: _isSaving ? null : () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator(color: AppColors.primary)),
        error: (e, _) => AppErrorState(message: e.toString()),
      ),
    );
  }
}
