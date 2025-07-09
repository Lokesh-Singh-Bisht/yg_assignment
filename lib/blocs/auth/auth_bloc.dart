import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yg_assignment/routes/app_routes.dart';
import 'package:yg_assignment/services/auth_services.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService _authService;

  AuthBloc(this._authService) : super(AuthInitial()) {
    on<AuthPhoneNumberSubmitted>((event, emit) async {
      emit(AuthLoading());
      try {
        await _authService.sendOtp(event.phoneNumber, (verificationId) {
          emit(AuthCodeSent(verificationId, phoneNumber: event.phoneNumber));
        });
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });

    on<AuthOtpSubmitted>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await _authService.verifyOtp(event.otp);
        emit(AuthAuthenticated(user!));
      } catch (e) {
        emit(AuthError("Invalid OTP"));
      }
    });
    on<AuthCodeResentEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        await _authService.sendOtp(event.phoneNumber, (verificationId) {
          emit(AuthCodeResent(verificationId, phoneNumber: event.phoneNumber));
        });
      } catch (e) {
        emit(AuthError("Failed to resend OTP"));
      }
    });

    on<AuthLogoutRequested>((event, emit) async {
      await _authService.signOut();
      AppRoutes.router.go('/');
      emit(AuthLoggedOut());
    });
  }
}
