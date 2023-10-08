import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:whats_app/core/common/firebase_storage_repository.dart';
import 'package:whats_app/core/models/user_model.dart';
import 'package:whats_app/core/routes/route_constants.dart';
import 'package:whats_app/core/state_management/uid_hydrated/uid_hydrated.dart';
import 'package:whats_app/core/utils/snak_bar.dart';

class AuthRepository {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseStore;
  final FireBaseStorageRepository fireBaseStorageRepository;
  final UidCubit uidCubit;

  AuthRepository(
    this.firebaseAuth,
    this.firebaseStore,
    this.fireBaseStorageRepository,
    this.uidCubit,
  );

  Future<UserModel?> getCurrenctUser() async {
    UserModel? user;
    var result =
        await firebaseStore.collection('users').doc(uidCubit.state).get();
    if (result.data() != null) {
      return user = UserModel.fromMap(result.data()!);
    } else {
      return user;
    }
  }

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

  storeUserInFirebase({
    required BuildContext context,
    required String name,
    required File? image,
  }) async {
    String uid = firebaseAuth.currentUser!.uid;
    String imageURL = "https://cdn-icons-png.flaticon.com/512/149/149071.png";

    if (image != null) {
      imageURL = await fireBaseStorageRepository.storeFileToFireBase(
        "ProfilePic/$uid",
        image,
      );
    }
    UserModel userModel = UserModel(
      name: name,
      uid: uid,
      profilePic: imageURL,
      isOnline: true,
      phoneNumber: uid,
      groupId: [],
    );
    uidCubit.addUID(uid);
    await firebaseStore.collection('users').doc(uid).set(userModel.toMap());
    Navigator.pushNamedAndRemoveUntil(
      context,
      RouteList.home,
      (route) => false,
    );
  }
}
