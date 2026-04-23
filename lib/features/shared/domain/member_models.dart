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

class EventItem {
  final int id;
  final String title;
  final String description;
  final String dateTime;
  final String location;
  final String type; // Rally, Meeting, Briefing
  final String status; // upcoming, registered, completed
  final String? imageUrl;

  const EventItem({
    required this.id,
    required this.title,
    required this.description,
    required this.dateTime,
    required this.location,
    required this.type,
    required this.status,
    this.imageUrl,
  });

  factory EventItem.fromJson(Map<String, dynamic> json) {
    return EventItem(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      dateTime: json['date_time'] ?? '',
      location: json['location'] ?? '',
      type: json['type'] ?? 'Meeting',
      status: json['status'] ?? 'upcoming',
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
  final String? banglaName;
  final String email;
  final String phone;
  final String memberNo;
  final String status;
  final String primaryCommittee;
  final String primaryPosition;
  final String committeeLevel;
  final String joiningDate;
  final String membershipTier;
  
  // Personal
  final String? fatherName;
  final String? motherName;
  final String? dob;
  final String? gender;
  final String? bloodGroup;
  
  // Academic
  final String? institution;
  final String? department;
  final String? academicSession;
  final String? studentId;
  
  // Address
  final String addressLine;
  final String villageArea;
  final String postOffice;
  final String thana;
  final String district;
  final String division;
  
  final String emergencyContact;
  final String bio;
  final String? avatar;
  final int profileCompletion;

  const MemberProfile({
    required this.id,
    required this.fullName,
    this.banglaName,
    required this.email,
    required this.phone,
    required this.memberNo,
    required this.status,
    required this.primaryCommittee,
    required this.primaryPosition,
    required this.committeeLevel,
    required this.joiningDate,
    this.membershipTier = 'Basic',
    this.fatherName,
    this.motherName,
    this.dob,
    this.gender,
    this.bloodGroup,
    this.institution,
    this.department,
    this.academicSession,
    this.studentId,
    required this.addressLine,
    required this.villageArea,
    required this.postOffice,
    required this.thana,
    required this.district,
    required this.division,
    required this.emergencyContact,
    required this.bio,
    this.avatar,
    this.profileCompletion = 85,
  });

  factory MemberProfile.fromJson(Map<String, dynamic> json) {
    return MemberProfile(
      id: json['id'] ?? 0,
      fullName: json['name'] ?? '',
      banglaName: json['bangla_name'],
      email: json['email'] ?? '',
      phone: json['phone'] ?? '-',
      memberNo: json['member_no'] ?? '-',
      status: json['status'] ?? 'inactive',
      primaryCommittee: json['primary_committee'] ?? '-',
      primaryPosition: json['primary_position'] ?? '-',
      committeeLevel: json['committee_level'] ?? 'Central',
      joiningDate: json['joining_date'] ?? '-',
      fatherName: json['father_name'],
      motherName: json['mother_name'],
      dob: json['dob'],
      gender: json['gender'],
      bloodGroup: json['blood_group'],
      institution: json['institution'],
      department: json['department'],
      academicSession: json['academic_session'],
      studentId: json['student_id'],
      addressLine: json['address_line'] ?? '-',
      villageArea: json['village_area'] ?? '-',
      postOffice: json['post_office'] ?? '-',
      thana: json['thana'] ?? '-',
      district: json['district'] ?? '-',
      division: json['division'] ?? '-',
      emergencyContact: json['emergency_contact'] ?? '-',
      bio: json['bio'] ?? '-',
      avatar: json['avatar'],
      profileCompletion: json['profile_completion'] ?? 85,
      membershipTier: json['membership_tier'] ?? 'Sovereign',
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
