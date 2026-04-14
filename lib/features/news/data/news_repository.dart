import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_constants.dart';
import '../../../core/network/dio_client.dart';
import '../../shared/data/mock_member_data.dart';
import '../../shared/domain/member_models.dart';

final newsRepositoryProvider = Provider<NewsRepository>((ref) {
  return NewsRepository(ref.read(dioProvider));
});

class NewsRepository {
  final Dio _dio;

  NewsRepository(this._dio);

  Future<List<PostItem>> getPosts() async {
    try {
      final response = await _dio.get(ApiConstants.posts);
      final list = (response.data['data'] as List<dynamic>? ?? const []);
      return list.map((e) => PostItem.fromJson(e as Map<String, dynamic>)).toList();
    } catch (_) {
      return MockMemberData.posts;
    }
  }
}
