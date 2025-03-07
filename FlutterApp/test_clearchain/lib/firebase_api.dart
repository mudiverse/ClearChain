import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';


Future<String?> uploadImage(File imageFile) async {
  try {
    // Generate a unique file name using the current timestamp.
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference storageRef =
    FirebaseStorage.instance.ref().child("report_images").child(fileName);

    // Create default metadata (for example, contentType 'image/jpeg')
    SettableMetadata metadata = SettableMetadata(
      contentType: "image/jpeg",
    );

    // Upload the file with metadata.
    UploadTask uploadTask = storageRef.putFile(imageFile, metadata);
    TaskSnapshot snapshot = await uploadTask;

    // Retrieve the download URL
    return await snapshot.ref.getDownloadURL();
  } catch (e) {
    print("Error uploading image: $e");
    return null;
  }
}


Future<void> submitReportToFirestore({
  required String name,
  required String description,
  required DateTime date,
  required String location,
  // File? image,
}) async {
  String? imageURL;

  // if (image != null) {
  //   imageURL = await uploadImage(image);
  // }

  await FirebaseFirestore.instance.collection('reports').add({
    'name': name,
    'description': description,
    'date': date.toIso8601String(),
    'location': location,
    // 'imageURL': imageURL ?? '',
    'timestamp': FieldValue.serverTimestamp(),
  });
}
