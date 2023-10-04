import 'package:flutter/material.dart';
import 'package:whats_app/features/auth/repository/auth_repository.dart';

class AuthController {
  final AuthRepository authRepository;
  AuthController(this.authRepository);

  signInWithPhone(BuildContext context, String phoneNumber) async {
    await authRepository.signInWithPhone(context, phoneNumber);
  }

  verficationOTP(
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
}
