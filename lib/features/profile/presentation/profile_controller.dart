import 'dart:async';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/profile_repository.dart';
import '../../shared/domain/member_models.dart';
import '../../auth/presentation/auth_controller.dart';

final profileControllerProvider = AsyncNotifierProvider<ProfileController, MemberProfile>(() {
  return ProfileController();
});

class ProfileController extends AsyncNotifier<MemberProfile> {
  late ProfileRepository _repository;
  final ImagePicker _imagePicker = ImagePicker();

  @override
  FutureOr<MemberProfile> build() async {
    _repository = ref.read(profileRepositoryProvider);
    return _fetchProfile();
  }

  Future<MemberProfile> _fetchProfile() async {
    return await _repository.getProfile();
  }

  Future<void> refreshProfile() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _fetchProfile());
  }

  Future<void> updateProfile(ProfileUpdatePayload payload) async {
    final currentProfile = state.asData?.value;
    try {
      final updatedProfile = await _repository.updateProfile(payload);
      state = AsyncValue.data(updatedProfile);
    } catch (error, stackTrace) {
      if (currentProfile != null) {
        state = AsyncValue.data(currentProfile);
      } else {
        state = AsyncValue.error(error, stackTrace);
      }
      rethrow;
    }
  }

  Future<void> pickCropAndUploadProfilePhoto(ImageSource source) async {
    final currentProfile = state.asData?.value;
    try {
      final picked = await _imagePicker.pickImage(
        source: source,
        maxWidth: 2048,
        maxHeight: 2048,
        imageQuality: 90,
      );
      if (picked == null) {
        return;
      }

      final cropped = await ImageCropper().cropImage(
        sourcePath: picked.path,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 90,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Crop Profile Photo',
            lockAspectRatio: true,
            hideBottomControls: false,
            cropStyle: CropStyle.circle,
          ),
          IOSUiSettings(
            title: 'Crop Profile Photo',
            aspectRatioLockEnabled: true,
            aspectRatioPickerButtonHidden: true,
            resetAspectRatioEnabled: false,
            cropStyle: CropStyle.circle,
          ),
        ],
      );

      if (cropped == null) {
        return;
      }

      final updatedProfile = await _repository.uploadProfilePhoto(cropped.path);
      state = AsyncValue.data(updatedProfile);
    } catch (error, stackTrace) {
      if (currentProfile != null) {
        state = AsyncValue.data(currentProfile);
      } else {
        state = AsyncValue.error(error, stackTrace);
      }
      rethrow;
    }
  }

  Future<void> logout() async {
    await ref.read(authControllerProvider.notifier).logout();
  }
}
