class AppConfig {
  static const bool isDebugMode = true;
  static const String firebaseProjectId = 'nodebook-flutter';
  
  // Feature flags
  static const bool enableAnalytics = false;
  static const bool enableCrashReporting = false;
  
  // UI Configuration
  static const int maxNotesPerPage = 50;
  static const Duration snackBarDuration = Duration(seconds: 3);
}