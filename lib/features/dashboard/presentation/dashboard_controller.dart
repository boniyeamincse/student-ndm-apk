import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/dashboard_repository.dart';
import '../../shared/domain/member_models.dart';

final dashboardControllerProvider = AsyncNotifierProvider<DashboardController, MemberDashboardData>(() {
  return DashboardController();
});

class DashboardController extends AsyncNotifier<MemberDashboardData> {
  late DashboardRepository _repository;

  @override
  FutureOr<MemberDashboardData> build() async {
    _repository = ref.read(dashboardRepositoryProvider);
    return _fetchDashboard();
  }

  Future<MemberDashboardData> _fetchDashboard() async {
    return await _repository.getDashboard();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _fetchDashboard());
  }
}
