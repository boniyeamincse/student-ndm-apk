import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_constants.dart';
import '../../../core/network/dio_client.dart';
import '../../shared/data/mock_member_data.dart';
import '../../shared/domain/member_models.dart';

final dashboardRepositoryProvider = Provider<DashboardRepository>((ref) {
  return DashboardRepository(ref.read(dioProvider));
});

class DashboardRepository {
  final Dio _dio;

  DashboardRepository(this._dio);

  Future<MemberDashboardData> getDashboard() async {
    try {
      final response = await _dio.get(ApiConstants.dashboard);
      final data = response.data['data'] as Map<String, dynamic>;
      final profile = MemberProfile.fromJson(data['profile_summary'] ?? {});

      final assignmentsJson = (data['assignments'] as List<dynamic>? ?? const []);
      final noticesJson = (data['latest_notices'] as List<dynamic>? ?? const []);
      final postsJson = (data['latest_posts'] as List<dynamic>? ?? const []);
      final subsJson = (data['subordinates_preview'] as List<dynamic>? ?? const []);

      return MemberDashboardData(
        profile: profile,
        quickStats: [
          QuickStat(label: 'Assignments', value: '${assignmentsJson.length}'),
          QuickStat(label: 'Subordinates', value: '${subsJson.length}'),
          QuickStat(label: 'Pending Requests', value: '${data['pending_requests'] ?? 0}'),
        ],
        assignments: assignmentsJson
            .map((e) => CommitteeAssignment.fromJson(e as Map<String, dynamic>))
            .toList(),
        leader: data['leader'] != null
            ? LeaderInfo.fromJson(data['leader'] as Map<String, dynamic>)
            : null,
        subordinates: subsJson
            .map((e) => SubordinateInfo.fromJson(e as Map<String, dynamic>))
            .toList(),
        latestNotices: noticesJson
            .map((e) => NoticeItem.fromJson(e as Map<String, dynamic>))
            .toList(),
        latestPosts: postsJson
            .map((e) => PostItem.fromJson(e as Map<String, dynamic>))
            .toList(),
        pendingProfileRequests: data['pending_requests'] ?? 0,
      );
    } catch (_) {
      return MemberDashboardData(
        profile: MockMemberData.profile,
        quickStats: const [
          QuickStat(label: 'Assignments', value: '2'),
          QuickStat(label: 'Subordinates', value: '2'),
          QuickStat(label: 'Pending Requests', value: '1'),
        ],
        assignments: MockMemberData.assignments,
        leader: MockMemberData.leader,
        subordinates: MockMemberData.subordinates,
        latestNotices: MockMemberData.notices,
        latestPosts: MockMemberData.posts,
        pendingProfileRequests: 1,
      );
    }
  }
}
