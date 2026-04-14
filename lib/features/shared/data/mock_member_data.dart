import '../domain/member_models.dart';

class MockMemberData {
  static MemberProfile profile = const MemberProfile(
    id: 1,
    fullName: 'Mahmudul Hasan',
    email: 'member@ndm.org',
    phone: '+8801712345678',
    memberNo: 'NDM-01700000002',
    status: 'active',
    primaryCommittee: 'Campus Affairs Committee',
    primaryPosition: 'Joint Convener',
    addressLine: 'Hall Road, Dhaka University',
    villageArea: 'Nabinagar',
    postOffice: 'Dhaka GPO',
    emergencyContact: '+8801812345678',
    bio: 'Student organizer focused on campus reform and volunteer growth.',
  );

  static List<CommitteeAssignment> assignments = const [
    CommitteeAssignment(
      id: 1,
      committeeName: 'Campus Affairs Committee',
      position: 'Joint Convener',
      isPrimary: true,
      isLeader: true,
      assignmentType: 'Executive',
      startDate: '2025-01-15',
    ),
    CommitteeAssignment(
      id: 2,
      committeeName: 'Membership Development',
      position: 'Coordinator',
      isPrimary: false,
      isLeader: false,
      assignmentType: 'Support',
      startDate: '2025-02-01',
    ),
  ];

  static LeaderInfo leader = const LeaderInfo(
    name: 'Farzana Islam',
    position: 'Member Secretary',
    committee: 'Central Student Wing',
    relationType: 'Direct Supervisor',
    phone: '+8801911122233',
  );

  static List<SubordinateInfo> subordinates = const [
    SubordinateInfo(
      id: 11,
      name: 'Samiul Rahman',
      position: 'Campus Volunteer',
      committee: 'Campus Affairs Committee',
    ),
    SubordinateInfo(
      id: 12,
      name: 'Nusrat Jahan',
      position: 'Organizer',
      committee: 'Membership Development',
    ),
  ];

  static List<NoticeItem> notices = const [
    NoticeItem(
      id: 1,
      title: 'District Conference Preparation Meeting',
      summary: 'All campus units must submit delegate list before Friday.',
      priority: 'urgent',
      isPinned: true,
      publishedAt: '2026-04-10',
    ),
    NoticeItem(
      id: 2,
      title: 'Monthly Membership Verification',
      summary: 'Verify member records and pending profile requests this week.',
      priority: 'normal',
      isPinned: false,
      publishedAt: '2026-04-08',
    ),
  ];

  static List<PostItem> posts = const [
    PostItem(
      id: 1,
      slug: 'student-rights-campaign-update',
      title: 'Student Rights Campaign Reaches 15 Campuses',
      excerpt: 'Coordination teams report strong volunteer participation.',
      type: 'news',
      publishedAt: '2026-04-09',
      imageUrl: null,
    ),
    PostItem(
      id: 2,
      slug: 'central-committee-statement-april',
      title: 'Central Committee Statement - April',
      excerpt: 'Official statement on campus policy and member safety.',
      type: 'statement',
      publishedAt: '2026-04-07',
      imageUrl: null,
    ),
  ];

  static List<ProfileRequestItem> requests = const [
    ProfileRequestItem(
      id: 1,
      requestNo: 'PR-2026-0007',
      type: 'mobile_change',
      status: 'pending',
      summary: 'Requested correction for mobile number.',
      submittedAt: '2026-04-05',
    ),
    ProfileRequestItem(
      id: 2,
      requestNo: 'PR-2026-0002',
      type: 'profile_update',
      status: 'approved',
      summary: 'Address details updated after review.',
      submittedAt: '2026-03-20',
    ),
  ];

  static AccountSettings settings = const AccountSettings(
    language: 'en',
    timezone: 'Asia/Dhaka',
    notificationEmail: true,
    notificationSms: false,
    notificationPush: false,
    showEmail: true,
    showPhone: true,
    showAddress: false,
  );
}
