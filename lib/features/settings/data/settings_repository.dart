import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_constants.dart';
import '../../../core/network/dio_client.dart';
import '../../shared/data/mock_member_data.dart';
import '../../shared/domain/member_models.dart';

final settingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  return SettingsRepository(ref.read(dioProvider));
});

class SettingsRepository {
  final Dio _dio;

  SettingsRepository(this._dio);

  Future<AccountSettings> getSettings() async {
    try {
      final response = await _dio.get(ApiConstants.accountSettings);
      return AccountSettings.fromJson(response.data['data'] as Map<String, dynamic>);
    } catch (_) {
      return MockMemberData.settings;
    }
  }

  Future<void> updateSettings(AccountSettings settings) async {
    await _dio.put(ApiConstants.accountSettings, data: settings.toJson());
  }
}
