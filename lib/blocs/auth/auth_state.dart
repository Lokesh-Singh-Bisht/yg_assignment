import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthCodeSent extends AuthState {
  final String verificationId;
  final String phoneNumber;
  AuthCodeSent(this.verificationId, {required this.phoneNumber});
}

class AuthCodeResent extends AuthState {
  final String verificationId;
  final String phoneNumber;
  AuthCodeResent(this.verificationId, {required this.phoneNumber});
}

class AuthAuthenticated extends AuthState {
  final User user;
  AuthAuthenticated(this.user);
}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}

class AuthLoggedOut extends AuthState {}
