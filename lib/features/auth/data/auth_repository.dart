import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network/api_constants.dart';
import '../../../core/network/dio_client.dart';
import '../../../core/storage/secure_storage_service.dart';
import '../../../core/errors/exceptions.dart';
import '../domain/user_model.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(ref.read(dioProvider), ref.read(secureStorageProvider));
});

class AuthRepository {
  final Dio _dio;
  final SecureStorageService _storage;

  AuthRepository(this._dio, this._storage);

  Future<UserModel> login({
    required String login,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        ApiConstants.login,
        data: {
          'login': login, // could be email or phone based on backend support
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        final data = response.data;
        // Assuming backend returns something like:
        // { "token": "...", "user": { ... } }
        final token = data['token'] ?? data['data']?['token'];
        if (token != null && token is String) {
          await _storage.saveToken(token);
        }

        final userData = data['user'] ?? data['data']?['user'] ?? data['data'];
        return UserModel.fromJson(userData);
      } else {
        throw ServerException(message: 'Login failed: Invalid response format');
      }
    } on DioException catch (e) {
      final message =
          e.response?.data?['message'] ??
          'Unable to login. Please check your credentials.';
      throw ServerException(
        message: message,
        statusCode: e.response?.statusCode,
      );
    }
  }

  Future<void> logout() async {
    try {
      // Optional: notify backend of logout
      await _dio.post(ApiConstants.logout);
    } catch (_) {
      // Ignore errors on logout as we are deleting local tokens anyway
    } finally {
      await _storage.deleteToken();
    }
  }

  Future<UserModel> fetchMe() async {
    try {
      final response = await _dio.get(ApiConstants.me);
      final userData =
          response.data['user'] ??
          response.data['data']?['user'] ??
          response.data['data'];
      return UserModel.fromJson(userData);
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        await _storage.deleteToken();
        throw UnauthorizedException();
      }
      throw ServerException(message: 'Failed to fetch user profile');
    }
  }

  Future<void> forgotPassword(String login) async {
    try {
      await _dio.post(ApiConstants.forgotPassword, data: {'login': login});
    } on DioException catch (e) {
      final message =
          e.response?.data?['message'] ??
          'Failed to send reset link. Please try again later.';
      throw ServerException(
        message: message,
        statusCode: e.response?.statusCode,
      );
    }
  }
}
