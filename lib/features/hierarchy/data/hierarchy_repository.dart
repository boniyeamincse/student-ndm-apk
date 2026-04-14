import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_constants.dart';
import '../../../core/network/dio_client.dart';
import '../../shared/data/mock_member_data.dart';
import '../../shared/domain/member_models.dart';

final hierarchyRepositoryProvider = Provider<HierarchyRepository>((ref) {
  return HierarchyRepository(ref.read(dioProvider));
});

class HierarchyRepository {
  final Dio _dio;

  HierarchyRepository(this._dio);

  Future<LeaderInfo?> getLeader() async {
    try {
      final response = await _dio.get(ApiConstants.leader);
      return LeaderInfo.fromJson(response.data['data'] as Map<String, dynamic>);
    } catch (_) {
      return MockMemberData.leader;
    }
  }

  Future<List<SubordinateInfo>> getSubordinates() async {
    try {
      final response = await _dio.get(ApiConstants.subordinates);
      final list = (response.data['data'] as List<dynamic>? ?? const []);
      return list
          .map((e) => SubordinateInfo.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (_) {
      return MockMemberData.subordinates;
    }
  }
}
