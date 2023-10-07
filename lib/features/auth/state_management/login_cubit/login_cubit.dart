import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:whats_app/core/helper/helper.dart';
import 'package:whats_app/core/models/code_phone_number_model.dart';
import 'package:whats_app/core/state_management/loading_cubit/loading_cubit.dart';
import 'package:whats_app/core/validations/phone.dart';
import 'package:whats_app/features/auth/controller/auth_controller.dart';

part 'login_state.dart';

enum StateWidget { loading, error, loaded }

class LoginCubit extends Cubit<LoginState> {
  final AuthController authController;
  final LoadingCubit loadingCubit;
  final TextEditingController codeController;

  LoginCubit(
    this.authController,
    this.loadingCubit,
    this.codeController,
  ) : super(LoginState.inial());

  getAllCountry() async {
    List<CodePhoneNumberModel> list = await Helper().getAllCountries();
    emit(
      state.copyWith(
        allCountries: list,
        chooseCountry: list.first,
        phone: Phone.dirty(
          value: "",
          min: int.parse(list.first.minPhoneLength),
          max: int.parse(list.first.maxPhoneLength),
        ),
        stateWidget: StateWidget.loaded,
      ),
    );
    codeController.text = state.chooseCountry!.regionalNumber;
  }

  login(BuildContext context) async {
    loadingCubit.show();
    await authController
        .signInWithPhone(
      context,
      codeController.text + state.phone.value,
    )
        .then((value) {
      loadingCubit.hide();
    });
  }

  chooseCountry(CodePhoneNumberModel chooseCountry) {
    emit(
      state.copyWith(
        chooseCountry: chooseCountry,
        phone: Phone.dirty(
          value: state.phone.value,
          min: int.parse(chooseCountry.minPhoneLength),
          max: int.parse(chooseCountry.maxPhoneLength),
        ),
      ),
    );
    codeController.text = chooseCountry.regionalNumber;
  }

  changePhoneNumber(String phoneNumber) {
    emit(
      state.copyWith(
        phone: Phone.dirty(
          value: phoneNumber,
          min: int.parse(state.chooseCountry!.minPhoneLength),
          max: int.parse(state.chooseCountry!.maxPhoneLength),
        ),
      ),
    );
  }
}
