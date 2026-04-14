import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_constants.dart';
import '../../../core/network/dio_client.dart';
import '../../shared/data/mock_member_data.dart';
import '../../shared/domain/member_models.dart';

final noticesRepositoryProvider = Provider<NoticesRepository>((ref) {
  return NoticesRepository(ref.read(dioProvider));
});

class NoticesRepository {
  final Dio _dio;

  NoticesRepository(this._dio);

  Future<List<NoticeItem>> getNotices() async {
    try {
      final response = await _dio.get(ApiConstants.notices);
      final list = (response.data['data'] as List<dynamic>? ?? const []);
      return list
          .map((e) => NoticeItem.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (_) {
      return MockMemberData.notices;
    }
  }
}
