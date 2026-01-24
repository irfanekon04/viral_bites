class AppUrls {
  static const String baseUrl = 'http://23.239.111.164:4500/api/auth';

  static const String signup = '$baseUrl/register';
  static const String signUpOtpVerify = '$baseUrl/verify-otp';
  static const String login = '$baseUrl/login';
  static const String forgotPass = '$baseUrl/forgot-password';
  static const String forgotPassOtp = '$baseUrl/verify-reset-otp';
  static const String resetPass = '$baseUrl/reset-password';
  static const String getUser = '$baseUrl/me';
}
