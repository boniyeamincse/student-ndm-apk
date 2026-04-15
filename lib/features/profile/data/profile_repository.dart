import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_constants.dart';
import '../../../core/network/dio_client.dart';
import '../../shared/data/mock_member_data.dart';
import '../../shared/domain/member_models.dart';

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  return ProfileRepository(ref.read(dioProvider));
});

class ProfileRepository {
  final Dio _dio;

  ProfileRepository(this._dio);

  Future<MemberProfile> getProfile() async {
    try {
      final response = await _dio.get(ApiConstants.profile);
      return _extractProfileFromResponse(response.data);
    } catch (_) {
      return MockMemberData.profile;
    }
  }

  Future<MemberProfile> updateProfile(ProfileUpdatePayload payload) async {
    try {
      final response = await _dio.put(
        ApiConstants.profile,
        data: payload.toJson(),
      );
      final updatedProfile = _extractProfileFromResponse(response.data);
      MockMemberData.profile = updatedProfile;
      return updatedProfile;
    } catch (error) {
      throw Exception('Failed to update profile: $error');
    }
  }

  Future<MemberProfile> uploadProfilePhoto(String imagePath) async {
    try {
      final formData = FormData.fromMap({
        'photo': await MultipartFile.fromFile(
          imagePath,
          filename: imagePath.split('/').last,
        ),
      });
      final response = await _dio.post(
        ApiConstants.updatePhoto,
        data: formData,
      );
      final updatedProfile = _extractProfileFromResponse(response.data);
      MockMemberData.profile = updatedProfile;
      return updatedProfile;
    } catch (error) {
      throw Exception('Failed to upload profile photo: $error');
    }
  }

  MemberProfile _extractProfileFromResponse(dynamic data) {
    if (data is Map<String, dynamic>) {
      final payload = data['data'];
      if (payload is Map<String, dynamic>) {
        final profile = payload['profile'];
        if (profile is Map<String, dynamic>) {
          return MemberProfile.fromJson(profile);
        }
        return MemberProfile.fromJson(payload);
      }
      final profile = data['profile'];
      if (profile is Map<String, dynamic>) {
        return MemberProfile.fromJson(profile);
      }
      return MemberProfile.fromJson(data);
    }
    throw const FormatException('Invalid profile response format');
  }
}

class ProfileUpdatePayload {
  final String fullName;
  final String email;
  final String phone;
  final String? fatherName;
  final String? institution;
  final String? department;
  final String? villageArea;
  final String? thana;
  final String? district;

  const ProfileUpdatePayload({
    required this.fullName,
    required this.email,
    required this.phone,
    this.fatherName,
    this.institution,
    this.department,
    this.villageArea,
    this.thana,
    this.district,
  });

  Map<String, dynamic> toJson() => {
        'name': fullName.trim(),
        'email': email.trim(),
        'phone': phone.trim(),
        'father_name': _toNullable(fatherName),
        'institution': _toNullable(institution),
        'department': _toNullable(department),
        'village_area': _toNullable(villageArea),
        'thana': _toNullable(thana),
        'district': _toNullable(district),
      };

  String? _toNullable(String? value) {
    if (value == null) {
      return null;
    }
    final trimmed = value.trim();
    return trimmed.isEmpty ? null : trimmed;
  }
}
