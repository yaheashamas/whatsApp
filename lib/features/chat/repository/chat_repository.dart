import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whats_app/core/models/user_model.dart';

class ChatRepository {
  final FirebaseFirestore firebaseFirestore;
  ChatRepository(this.firebaseFirestore);

  Stream<UserModel> getUserInfo(String uid) async* {
    yield* firebaseFirestore
        .collection("users")
        .doc(uid)
        .snapshots()
        .map((user) => UserModel.fromMap(user.data()!));
  }
}
