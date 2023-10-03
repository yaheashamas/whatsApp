import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:whats_app/core/state_management/loading_cubit/loading_cubit.dart';
import 'package:whats_app/features/auth/controller/auth_controller.dart';
import 'package:whats_app/features/auth/repository/auth_repository.dart';
import 'package:whats_app/features/auth/state_management/cubit/login_cubit.dart';

final getIt = GetIt.instance;

Future<void> configureInjection() async {
  await mainGetIt();
  await fireBaseGetIt();
  await loginGetIt();
}

mainGetIt() async {
  getIt.registerSingleton(LoadingCubit());
}

fireBaseGetIt() async {
  getIt.registerFactory<FirebaseAuth>(() => FirebaseAuth.instance);
  getIt.registerFactory<FirebaseStorage>(() => FirebaseStorage.instance);
}

loginGetIt() async {
  //controller
  getIt.registerFactory<TextEditingController>(() => TextEditingController());
  //repository
  getIt.registerFactory<AuthRepository>(() => AuthRepository(getIt(), getIt()));
  //controller
  getIt.registerFactory<AuthController>(() => AuthController(getIt()));
  //state_management
  getIt.registerFactory<LoginCubit>(() => LoginCubit(getIt(),getIt(),getIt()));
}
