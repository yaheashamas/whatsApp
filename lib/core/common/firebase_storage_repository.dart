import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class FireBaseStorageRepository {
  final FirebaseStorage firebaseStorage;
  FireBaseStorageRepository(this.firebaseStorage);

  Future<String> storeFileToFireBase(String path, File file) async {
    UploadTask uploadTask = firebaseStorage.ref().child(path).putFile(file);
    TaskSnapshot snap = await uploadTask;
    String downloadURL = await snap.ref.getDownloadURL();
    return downloadURL;
  }
}
