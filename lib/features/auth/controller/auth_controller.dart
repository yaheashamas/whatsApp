import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whats_app/features/auth/repository/auth_repository.dart';

var authControllerProvider = Provider((ref) {
  var authProvider = ref.watch(authRepositoryProvider);
  return AuthController(authProvider);
});

class AuthController {
  final AuthRepository authRepository;
  AuthController(this.authRepository);

  signInWithPhone(BuildContext context, String phoneNumber) async {
    await authRepository.signInWithPhone(context, phoneNumber);
  }
}
