import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:whats_app/core/routes/route_constants.dart';
import 'package:whats_app/core/utils/snak_bar.dart';

class AuthRepository {
  final FirebaseAuth firebaseAuth;
  final FirebaseStorage firebaseStorage;
  AuthRepository(
    this.firebaseAuth,
    this.firebaseStorage,
  );

  Future<void> signInWithPhone(BuildContext context, String phoneNumber) async {
    try {
      await firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (credential) async {
          await firebaseAuth.signInWithCredential(credential);
        },
        verificationFailed: (error) {
          return showSnakBar(context: context, content: error.message!);
        },
        codeSent: (verificationId, forceResendingToken) async {
          Navigator.pushNamed(
            context,
            RouteList.otp,
            arguments: verificationId,
          );
        },
        codeAutoRetrievalTimeout: (verificationId) {},
      );
    } on FirebaseAuthException catch (e) {
      return showSnakBar(
        context: context,
        content: e.message!,
      );
    }
  }

  Future<void> otpPhoneNumber({
    required BuildContext context,
    required String verificationId,
    required String smsCode,
  }) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      await firebaseAuth.signInWithCredential(credential);
      Navigator.pushNamedAndRemoveUntil(
        context,
        RouteList.infoUser,
        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      return showSnakBar(
        context: context,
        content: e.message!,
      );
    }
  }
}
