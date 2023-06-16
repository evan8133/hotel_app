import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageMethods{
  final FirebaseStorage _firebaseStorage;
  StorageMethods(this._firebaseStorage);

  Future<String> uploadFile(String path, File file) async {
    try {
      final ref = _firebaseStorage.ref(path);
      final uploadTask = ref.putFile(file);
      final snapshot = await uploadTask;
      final url = await snapshot.ref.getDownloadURL();
      return url;
    } catch (e) {
      rethrow;
    }
  }
}