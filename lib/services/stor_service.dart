import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StoreService {
  static final Reference _storage = FirebaseStorage.instance.ref();
  static const String folder = "post_image";

  static Future<String> uploadImage(File image) async {
    // image name
    String imgName = "image_" + DateTime.now().toString();
    Reference storageRef = _storage.child(folder).child(imgName);
    UploadTask uploadTask = storageRef.putFile(image);
    TaskSnapshot taskSnapshot = await uploadTask;

    final String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

}