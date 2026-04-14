import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/auth_repository.dart';
import '../domain/user_model.dart';
import '../../../core/storage/secure_storage_service.dart';

final authControllerProvider = AsyncNotifierProvider<AuthController, UserModel?>(() {
  return AuthController();
});

class AuthController extends AsyncNotifier<UserModel?> {
  late AuthRepository _repository;
  late SecureStorageService _storage;

  @override
  FutureOr<UserModel?> build() async {
    _repository = ref.read(authRepositoryProvider);
    _storage = ref.read(secureStorageProvider);
    return _checkAuth();
  }

  Future<UserModel?> _checkAuth() async {
    try {
      final token = await _storage.getToken();
      if (token != null && token.isNotEmpty) {
        return await _repository.fetchMe();
      }
      return null;
    } catch (e) {
      await _storage.deleteToken();
      return null;
    }
  }

  Future<void> checkAuth() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _checkAuth());
  }

  Future<void> login(String login, String password) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return await _repository.login(login: login, password: password);
    });
  }

  Future<void> logout() async {
    state = const AsyncValue.loading();
    await _repository.logout();
    state = const AsyncValue.data(null);
  }
}
