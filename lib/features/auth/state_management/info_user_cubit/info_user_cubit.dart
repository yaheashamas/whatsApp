import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:whats_app/core/state_management/loading_cubit/loading_cubit.dart';
import 'package:whats_app/core/validations/full_name.dart';
import 'package:whats_app/features/auth/controller/auth_controller.dart';
import 'package:whats_app/features/auth/state_management/login_cubit/login_cubit.dart';

part 'info_user_state.dart';

class InfoUserCubit extends Cubit<InfoUserState> {
  final LoadingCubit loadingCubit;
  final AuthController authController;

  InfoUserCubit(
    this.loadingCubit,
    this.authController,
  ) : super(InfoUserState.inial());

  changeName(String value) {
    emit(state.copyWith(fullName: FullName.dirty(value)));
  }

  changeImage(File? image) {
    emit(state.copyWith(image: image));
  }

  storeUser(BuildContext context) async {
    loadingCubit.show();
    await authController.createUser(
      context,
      state.fullName.value,
      state.image,
    );
    loadingCubit.hide();
  }
}
