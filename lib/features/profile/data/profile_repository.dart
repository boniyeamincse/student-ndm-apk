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
      final data = response.data['data'] ?? response.data;
      return MemberProfile.fromJson(data as Map<String, dynamic>);
    } catch (_) {
      return MockMemberData.profile;
    }
  }
}
