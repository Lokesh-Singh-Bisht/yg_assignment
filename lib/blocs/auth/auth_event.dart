abstract class AuthEvent {}

class AuthPhoneNumberSubmitted extends AuthEvent {
  final String phoneNumber;
  AuthPhoneNumberSubmitted(this.phoneNumber);
}

class AuthOtpSubmitted extends AuthEvent {
  final String otp;
  AuthOtpSubmitted(this.otp);
}

class AuthCodeResentEvent extends AuthEvent {
  final String phoneNumber;

  AuthCodeResentEvent({required this.phoneNumber});
}

class AuthLogoutRequested extends AuthEvent {}
