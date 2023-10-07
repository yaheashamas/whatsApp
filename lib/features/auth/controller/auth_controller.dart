import 'dart:io';

import 'package:flutter/material.dart';
import 'package:whats_app/features/auth/repository/auth_repository.dart';

class AuthController {
  final AuthRepository authRepository;
  AuthController(this.authRepository);

  Future signInWithPhone(BuildContext context, String phoneNumber) async {
    await authRepository.signInWithPhone(context, phoneNumber);
  }

  Future verficationOTP(
    BuildContext context,
    String verificationId,
    String smsCode,
  ) async {
    await authRepository.otpPhoneNumber(
      context: context,
      verificationId: verificationId,
      smsCode: smsCode,
    );
  }

  Future createUser(
    BuildContext context,
    String name,
    File? image,
  ) async {
    await authRepository.storeUserInFirebase(
      context: context,
      name: name,
      image: image,
    );
  }
}
