import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yg_assignment/services/user_services.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserService userService;

  UserBloc(this.userService) : super(UserInitial()) {
    on<LoadUser>((event, emit) async {
      emit(UserLoading());
      try {
        final user = await userService.getUserById(event.userId);
        if (user != null) {
          emit(UserLoaded(user));
        } else {
          emit(UserError("User not found"));
        }
      } catch (e) {
        emit(UserError("Failed to fetch user: $e"));
      }
    });
  }
}
