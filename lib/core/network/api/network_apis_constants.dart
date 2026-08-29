import 'package:flexiJobs/core/config/app_config.dart';

class ApiConstants {
  // release
  static const String devUrl = "https://api-dev.flexijobapp.com/api/";
  static const String prodUrl = "https://api.flexijobapp.com/api/";
  static String baseStorageUrl = AppConfig.baseStorageUrl;
  static String baseStorageUrlProd = AppConfig.baseStorageUrl;

  // dev
  // static String devUrl = "https://api.flexijobapp.com/api/";
  // static String prodUrl = "https://api-dev.flexijobapp.com/api/";
  // static String baseStorageUrl = 'https://api.flexijobapp.com/storage/';
  // static String baseStorageUrlProd = 'https://api-dev.flexijobapp.com/storage/';

  static const String login = 'auth/login';
  static const String register = 'auth/register';
  static const String getAvailableJobs = 'job/getAvailableJobs';
  static const String getGovernorates = 'governorate/getGovernorates';
  static const String getUniversities = 'University/getUniversities';
  static const String getUpcomingJob = 'job/getUpcomingJobs';
  static const String getPastJobs = 'job/getPastJobs';
  static const String getAppliedJobs = 'job/getAppliedJobs';
  static const String getAppUserInfo = 'appUser/getAppUserInfo';
  static const String verifyCode = 'auth/verifyCode';
  static const String resendVerificationCode = 'auth/sendEmailVerificationCode';
  static const String completePersonalInfo = 'appUser/completePersonalInfo';
  static const String completeDocuments = 'appUser/completeDocuments';
  static const String completePaymentInfo = 'appUser/completePaymentInfo';
  static const String getJobCategories = 'jobCategory/getJobCategories';
  static const String setJobCategoryHistories = 'appUser/setJobCategoryHistories';
  static const String completeProfile = 'appUser/completeProfile';
  static const String getJobById = 'job/getJobByIdForAppUser';
  static const String checkIn = 'jobAttendance/checkIn';
  static const String checkOut = 'jobAttendance/checkOut';
  static const String cancelJob = 'jobApplicant/cancelJobApplicantForAppUser';
  static const String applyOnJob = 'job/applyOnJob';
  static const String getAvailableJobsForCategory = 'job/getAvailableJobsForCategory';
  static const String deleteUser = 'appUser/sendDeleteMail';
  static const String changePassword = 'user/changePassword';
  static const String notifications = 'notification/getAUNotifications';
  static const String getUnReadNotificationCount = 'notification/getUnReadNotificationCount';

  static const String readAllNotifications = "notification/readNotification";
  static const String uploadVideo = "appUser/uploadIntroVideo";
  static const String getUpcomingShift = "jobAttendance/getUpcomingShift";

  static const String sendVendorEmail = "sendEmailAboutVendor";
  static const String getAppVersion = "getAppVersion";
}
