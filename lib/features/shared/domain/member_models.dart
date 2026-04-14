class QuickStat {
  final String label;
  final String value;

  const QuickStat({required this.label, required this.value});
}

class CommitteeAssignment {
  final int id;
  final String committeeName;
  final String position;
  final bool isPrimary;
  final bool isLeader;
  final String assignmentType;
  final String startDate;

  const CommitteeAssignment({
    required this.id,
    required this.committeeName,
    required this.position,
    required this.isPrimary,
    required this.isLeader,
    required this.assignmentType,
    required this.startDate,
  });

  factory CommitteeAssignment.fromJson(Map<String, dynamic> json) {
    return CommitteeAssignment(
      id: json['id'] ?? 0,
      committeeName: json['committee_name'] ?? '',
      position: json['position'] ?? '',
      isPrimary: json['is_primary'] ?? false,
      isLeader: json['is_leader'] ?? false,
      assignmentType: json['assignment_type'] ?? 'regular',
      startDate: json['start_date'] ?? '-',
    );
  }
}

class LeaderInfo {
  final String name;
  final String position;
  final String committee;
  final String relationType;
  final String? phone;
  final String? photoUrl;

  const LeaderInfo({
    required this.name,
    required this.position,
    required this.committee,
    required this.relationType,
    this.phone,
    this.photoUrl,
  });

  factory LeaderInfo.fromJson(Map<String, dynamic> json) {
    return LeaderInfo(
      name: json['name'] ?? '',
      position: json['position'] ?? '',
      committee: json['committee'] ?? '',
      relationType: json['relation_type'] ?? 'reporting',
      phone: json['phone'],
      photoUrl: json['photo_url'],
    );
  }
}

class SubordinateInfo {
  final int id;
  final String name;
  final String position;
  final String committee;
  final String? photoUrl;

  const SubordinateInfo({
    required this.id,
    required this.name,
    required this.position,
    required this.committee,
    this.photoUrl,
  });

  factory SubordinateInfo.fromJson(Map<String, dynamic> json) {
    return SubordinateInfo(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      position: json['position'] ?? '',
      committee: json['committee'] ?? '',
      photoUrl: json['photo_url'],
    );
  }
}

class NoticeItem {
  final int id;
  final String title;
  final String summary;
  final String priority;
  final bool isPinned;
  final String publishedAt;

  const NoticeItem({
    required this.id,
    required this.title,
    required this.summary,
    required this.priority,
    required this.isPinned,
    required this.publishedAt,
  });

  factory NoticeItem.fromJson(Map<String, dynamic> json) {
    return NoticeItem(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      summary: json['summary'] ?? '',
      priority: json['priority'] ?? 'normal',
      isPinned: json['is_pinned'] ?? false,
      publishedAt: json['published_at'] ?? '',
    );
  }
}

class PostItem {
  final int id;
  final String slug;
  final String title;
  final String excerpt;
  final String type;
  final String publishedAt;
  final String? imageUrl;

  const PostItem({
    required this.id,
    required this.slug,
    required this.title,
    required this.excerpt,
    required this.type,
    required this.publishedAt,
    this.imageUrl,
  });

  factory PostItem.fromJson(Map<String, dynamic> json) {
    return PostItem(
      id: json['id'] ?? 0,
      slug: json['slug'] ?? '',
      title: json['title'] ?? '',
      excerpt: json['excerpt'] ?? '',
      type: json['type'] ?? 'news',
      publishedAt: json['published_at'] ?? '',
      imageUrl: json['image_url'],
    );
  }
}

class ProfileRequestItem {
  final int id;
  final String requestNo;
  final String type;
  final String status;
  final String summary;
  final String submittedAt;

  const ProfileRequestItem({
    required this.id,
    required this.requestNo,
    required this.type,
    required this.status,
    required this.summary,
    required this.submittedAt,
  });

  factory ProfileRequestItem.fromJson(Map<String, dynamic> json) {
    return ProfileRequestItem(
      id: json['id'] ?? 0,
      requestNo: json['request_no'] ?? '',
      type: json['type'] ?? 'profile_update',
      status: json['status'] ?? 'pending',
      summary: json['summary'] ?? '',
      submittedAt: json['submitted_at'] ?? '',
    );
  }
}

class MemberProfile {
  final int id;
  final String fullName;
  final String email;
  final String phone;
  final String memberNo;
  final String status;
  final String primaryCommittee;
  final String primaryPosition;
  final String addressLine;
  final String villageArea;
  final String postOffice;
  final String emergencyContact;
  final String bio;
  final String? avatar;

  const MemberProfile({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.memberNo,
    required this.status,
    required this.primaryCommittee,
    required this.primaryPosition,
    required this.addressLine,
    required this.villageArea,
    required this.postOffice,
    required this.emergencyContact,
    required this.bio,
    this.avatar,
  });

  factory MemberProfile.fromJson(Map<String, dynamic> json) {
    return MemberProfile(
      id: json['id'] ?? 0,
      fullName: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '-',
      memberNo: json['member_no'] ?? '-',
      status: json['status'] ?? 'inactive',
      primaryCommittee: json['primary_committee'] ?? '-',
      primaryPosition: json['primary_position'] ?? '-',
      addressLine: json['address_line'] ?? '-',
      villageArea: json['village_area'] ?? '-',
      postOffice: json['post_office'] ?? '-',
      emergencyContact: json['emergency_contact'] ?? '-',
      bio: json['bio'] ?? '-',
      avatar: json['avatar'],
    );
  }
}

class AccountSettings {
  final String language;
  final String timezone;
  final bool notificationEmail;
  final bool notificationSms;
  final bool notificationPush;
  final bool showEmail;
  final bool showPhone;
  final bool showAddress;

  const AccountSettings({
    required this.language,
    required this.timezone,
    required this.notificationEmail,
    required this.notificationSms,
    required this.notificationPush,
    required this.showEmail,
    required this.showPhone,
    required this.showAddress,
  });

  factory AccountSettings.fromJson(Map<String, dynamic> json) {
    return AccountSettings(
      language: json['language'] ?? 'en',
      timezone: json['timezone'] ?? 'Asia/Dhaka',
      notificationEmail: json['notification_email'] ?? true,
      notificationSms: json['notification_sms'] ?? false,
      notificationPush: json['notification_push'] ?? false,
      showEmail: json['show_email'] ?? true,
      showPhone: json['show_phone'] ?? true,
      showAddress: json['show_address'] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        'language': language,
        'timezone': timezone,
        'notification_email': notificationEmail,
        'notification_sms': notificationSms,
        'notification_push': notificationPush,
        'show_email': showEmail,
        'show_phone': showPhone,
        'show_address': showAddress,
      };
}

class MemberDashboardData {
  final MemberProfile profile;
  final List<QuickStat> quickStats;
  final List<CommitteeAssignment> assignments;
  final LeaderInfo? leader;
  final List<SubordinateInfo> subordinates;
  final List<NoticeItem> latestNotices;
  final List<PostItem> latestPosts;
  final int pendingProfileRequests;

  const MemberDashboardData({
    required this.profile,
    required this.quickStats,
    required this.assignments,
    required this.leader,
    required this.subordinates,
    required this.latestNotices,
    required this.latestPosts,
    required this.pendingProfileRequests,
  });
}
