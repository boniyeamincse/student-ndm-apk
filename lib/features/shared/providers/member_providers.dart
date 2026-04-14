import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../committee/data/committee_repository.dart';
import '../../dashboard/data/dashboard_repository.dart';
import '../../hierarchy/data/hierarchy_repository.dart';
import '../../news/data/news_repository.dart';
import '../../notices/data/notices_repository.dart';
import '../../profile/data/profile_repository.dart';
import '../../profile_requests/data/profile_requests_repository.dart';
import '../../settings/data/settings_repository.dart';
import '../domain/member_models.dart';

final dashboardProvider =
    AsyncNotifierProvider<DashboardNotifier, MemberDashboardData>(
  DashboardNotifier.new,
);

class DashboardNotifier extends AsyncNotifier<MemberDashboardData> {
  @override
  Future<MemberDashboardData> build() {
    return ref.read(dashboardRepositoryProvider).getDashboard();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return ref.read(dashboardRepositoryProvider).getDashboard();
    });
  }
}

final profileProvider = AsyncNotifierProvider<ProfileNotifier, MemberProfile>(
  ProfileNotifier.new,
);

class ProfileNotifier extends AsyncNotifier<MemberProfile> {
  @override
  Future<MemberProfile> build() {
    return ref.read(profileRepositoryProvider).getProfile();
  }
}

final assignmentsProvider =
    AsyncNotifierProvider<AssignmentsNotifier, List<CommitteeAssignment>>(
  AssignmentsNotifier.new,
);

class AssignmentsNotifier extends AsyncNotifier<List<CommitteeAssignment>> {
  @override
  Future<List<CommitteeAssignment>> build() {
    return ref.read(committeeRepositoryProvider).getAssignments();
  }
}

final leaderProvider = AsyncNotifierProvider<LeaderNotifier, LeaderInfo?>(
  LeaderNotifier.new,
);

class LeaderNotifier extends AsyncNotifier<LeaderInfo?> {
  @override
  Future<LeaderInfo?> build() {
    return ref.read(hierarchyRepositoryProvider).getLeader();
  }
}

final subordinatesProvider =
    AsyncNotifierProvider<SubordinatesNotifier, List<SubordinateInfo>>(
  SubordinatesNotifier.new,
);

class SubordinatesNotifier extends AsyncNotifier<List<SubordinateInfo>> {
  @override
  Future<List<SubordinateInfo>> build() {
    return ref.read(hierarchyRepositoryProvider).getSubordinates();
  }
}

final noticesProvider = AsyncNotifierProvider<NoticesNotifier, List<NoticeItem>>(
  NoticesNotifier.new,
);

class NoticesNotifier extends AsyncNotifier<List<NoticeItem>> {
  @override
  Future<List<NoticeItem>> build() {
    return ref.read(noticesRepositoryProvider).getNotices();
  }
}

final postsProvider = AsyncNotifierProvider<PostsNotifier, List<PostItem>>(
  PostsNotifier.new,
);

class PostsNotifier extends AsyncNotifier<List<PostItem>> {
  @override
  Future<List<PostItem>> build() {
    return ref.read(newsRepositoryProvider).getPosts();
  }
}

final requestsProvider =
    AsyncNotifierProvider<RequestsNotifier, List<ProfileRequestItem>>(
  RequestsNotifier.new,
);

class RequestsNotifier extends AsyncNotifier<List<ProfileRequestItem>> {
  @override
  Future<List<ProfileRequestItem>> build() {
    return ref.read(profileRequestsRepositoryProvider).getRequests();
  }

  Future<void> create({
    required String type,
    required String changes,
    required String note,
  }) async {
    await ref.read(profileRequestsRepositoryProvider).createRequest(
          type: type,
          changes: changes,
          note: note,
        );
    state = await AsyncValue.guard(() async {
      return ref.read(profileRequestsRepositoryProvider).getRequests();
    });
  }
}

final settingsProvider =
    AsyncNotifierProvider<SettingsNotifier, AccountSettings>(
  SettingsNotifier.new,
);

class SettingsNotifier extends AsyncNotifier<AccountSettings> {
  @override
  Future<AccountSettings> build() {
    return ref.read(settingsRepositoryProvider).getSettings();
  }

  Future<void> update(AccountSettings next) async {
    await ref.read(settingsRepositoryProvider).updateSettings(next);
    state = AsyncData(next);
  }
}
