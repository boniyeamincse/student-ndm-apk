class ApiConstants {
  // Configured default base URL (placeholder to be overridden in production)
  // Local development base URL
  // For Android Emulator, use: http://10.0.2.2:8000/api/v1
  // For Physical Device/Desktop, use your computer's IP or 127.0.0.1
  static const String baseUrl = 'http://127.0.0.1:8000/api/v1';

  // Auth
  static const String login = '/auth/login';
  static const String logout = '/auth/logout';
  static const String me = '/auth/me';
  static const String forgotPassword = '/auth/forgot-password';
  static const String changePassword = '/auth/change-password';

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
