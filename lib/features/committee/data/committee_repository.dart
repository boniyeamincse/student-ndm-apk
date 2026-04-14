import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_constants.dart';
import '../../../core/network/dio_client.dart';
import '../../shared/data/mock_member_data.dart';
import '../../shared/domain/member_models.dart';

final committeeRepositoryProvider = Provider<CommitteeRepository>((ref) {
  return CommitteeRepository(ref.read(dioProvider));
});

class CommitteeRepository {
  final Dio _dio;

  CommitteeRepository(this._dio);

  Future<List<CommitteeAssignment>> getAssignments() async {
    try {
      final response = await _dio.get(ApiConstants.committeeAssignments);
      final list = (response.data['data'] as List<dynamic>? ?? const []);
      return list
          .map((e) => CommitteeAssignment.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (_) {
      return MockMemberData.assignments;
    }
  }
}
