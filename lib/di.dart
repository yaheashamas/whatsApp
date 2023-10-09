import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:whats_app/core/common/firebase_storage_repository.dart';
import 'package:whats_app/core/state_management/loading_cubit/loading_cubit.dart';
import 'package:whats_app/core/state_management/uid_hydrated/uid_hydrated.dart';
import 'package:whats_app/features/auth/controller/auth_controller.dart';
import 'package:whats_app/features/auth/repository/auth_repository.dart';
import 'package:whats_app/features/auth/state_management/info_user_cubit/info_user_cubit.dart';
import 'package:whats_app/features/auth/state_management/login_cubit/login_cubit.dart';
import 'package:whats_app/features/landing/state_management/user_cubit/user_cubit.dart';
import 'package:whats_app/features/select_contact/controller/select_contact_controller.dart';
import 'package:whats_app/features/select_contact/repository/select_contact_repository.dart';
import 'package:whats_app/features/select_contact/state_management/select_contact_cubit/select_contact_cubit.dart';

final getIt = GetIt.instance;

Future<void> configureInjection() async {
  await mainGetIt();
  await fireBaseGetIt();
  await commonClassesGetIt();
  await loginGetIt();
  await userCubit();
  await infoUser();
  await selectContactCubit();
}

mainGetIt() async {
  getIt.registerSingleton(LoadingCubit());
  getIt.registerSingleton(UidCubit());
}

fireBaseGetIt() async {
  getIt.registerSingleton<FirebaseAuth>(FirebaseAuth.instance);
  getIt.registerSingleton<FirebaseStorage>(FirebaseStorage.instance);
  getIt.registerSingleton<FirebaseFirestore>(FirebaseFirestore.instance);
}

commonClassesGetIt() async {
  getIt.registerSingleton<FireBaseStorageRepository>(
    FireBaseStorageRepository(getIt()),
  );
}

loginGetIt() async {
  //controller
  getIt.registerFactory<TextEditingController>(() => TextEditingController());
  //repository
  getIt.registerFactory<AuthRepository>(() => AuthRepository(
        getIt(),
        getIt(),
        getIt(),
        getIt(),
      ));
  //controller
  getIt.registerFactory<AuthController>(() => AuthController(getIt()));
  //state_management
  getIt
      .registerFactory<LoginCubit>(() => LoginCubit(getIt(), getIt(), getIt()));
}

userCubit() async {
  getIt.registerSingleton<UserCubit>(UserCubit(getIt()));
}

infoUser() async {
  getIt.registerFactory<InfoUserCubit>(() => InfoUserCubit(getIt(), getIt()));
}

// search and git all users
selectContactCubit() async {
  getIt.registerSingleton<SelectContactRepository>(SelectContactRepository(
    getIt(),
  ));
  getIt.registerSingleton<SelectContactController>(SelectContactController(
    getIt(),
  ));
  getIt.registerFactory<SelectContactCubit>(() => SelectContactCubit(
        getIt(),
      ));
}
