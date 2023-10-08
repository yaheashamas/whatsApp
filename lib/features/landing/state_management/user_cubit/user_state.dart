import 'package:equatable/equatable.dart';
import 'package:whats_app/core/models/user_model.dart';
import 'package:whats_app/features/auth/state_management/login_cubit/login_cubit.dart';

class UserState extends Equatable {
  final UserModel? userModel;
  final StateWidget stateWidget;

  const UserState({
    this.userModel,
    required this.stateWidget,
  });

  factory UserState.inial() {
    return const UserState(
      userModel: null,
      stateWidget: StateWidget.loading,
    );
  }

  @override
  List<Object?> get props => [userModel, stateWidget];


  UserState copyWith({
    UserModel? userModel,
    StateWidget? stateWidget,
  }) {
    return UserState(
      userModel: userModel ?? this.userModel,
      stateWidget: stateWidget ?? this.stateWidget,
    );
  }
}
