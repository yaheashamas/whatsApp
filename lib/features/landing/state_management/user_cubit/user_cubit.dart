import 'package:bloc/bloc.dart';
import 'package:whats_app/features/auth/controller/auth_controller.dart';
import 'package:whats_app/features/auth/state_management/login_cubit/login_cubit.dart';
import 'package:whats_app/features/landing/state_management/user_cubit/user_state.dart';

class UserCubit extends Cubit<UserState> {
  final AuthController authController;

  UserCubit(this.authController) : super(UserState.inial());

  Future getUser() async {
    emit(state.copyWith(stateWidget: StateWidget.loading));
    authController.getCurrenctUser().then((user) {
      if (user != null) {
        emit(state.copyWith(
          stateWidget: StateWidget.loaded,
          userModel: user,
        ));
      } else {
        emit(state.copyWith(
          stateWidget: StateWidget.error,
          userModel: null,
        ));
      }
    });
  }
}
