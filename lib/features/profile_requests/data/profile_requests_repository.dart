import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_constants.dart';
import '../../../core/network/dio_client.dart';
import '../../shared/data/mock_member_data.dart';
import '../../shared/domain/member_models.dart';

final profileRequestsRepositoryProvider =
    Provider<ProfileRequestsRepository>((ref) {
  return ProfileRequestsRepository(ref.read(dioProvider));
});

class ProfileRequestsRepository {
  final Dio _dio;

  ProfileRequestsRepository(this._dio);

  Future<List<ProfileRequestItem>> getRequests() async {
    try {
      final response = await _dio.get(ApiConstants.profileUpdateRequests);
      final list = (response.data['data'] as List<dynamic>? ?? const []);
      return list
          .map((e) => ProfileRequestItem.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (_) {
      return MockMemberData.requests;
    }
  }

  Future<void> createRequest({
    required String type,
    required String changes,
    required String note,
  }) async {
    await _dio.post(ApiConstants.profileUpdateRequests, data: {
      'request_type': type,
      'requested_changes': changes,
      'note': note,
    });
  }
}
