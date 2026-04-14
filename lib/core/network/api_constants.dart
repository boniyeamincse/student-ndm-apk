class ApiConstants {
  // Configured default base URL (placeholder to be overridden in production)
  static const String baseUrl = 'https://api.ndm.bd/api/v1';

  // Auth
  static const String login = '/auth/login';
  static const String logout = '/auth/logout';
  static const String me = '/auth/me';

  // Dashboard / Profile
  static const String dashboard = '/me/dashboard';
  static const String profile = '/me/profile';
  static const String updatePhoto = '/me/profile/photo';

  // Organization
  static const String memberOverview = '/me/member-overview';
  static const String committeeAssignments = '/me/committee-assignments';
  static const String leader = '/me/leader';
  static const String subordinates = '/me/subordinates';

  // Content
  static const String notices = '/member/notices';
  static const String posts = '/public/posts';

  // Settings & Requests
  static const String profileUpdateRequests = '/me/profile-update-requests';
  static const String accountSettings = '/me/account-settings';
}
