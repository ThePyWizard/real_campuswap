import 'package:flutter/material.dart';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class SellPage extends StatefulWidget {
  const SellPage({super.key});

  @override
  State<SellPage> createState() => _SellPageState();
}

class _SellPageState extends State<SellPage> {
  String? productImageUrl;

  bool isUploading = false;

  final picker = ImagePicker();

  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File image = File(pickedFile.path);
      uploadImage(image);
    }
  }

  Future<void> captureImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      File image = File(pickedFile.path);
      uploadImage(image);
    }
  }

  Future<void> uploadImage(File image) async {
    setState(() {
      isUploading = true;
    });
    try {
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref =
          storage.ref().child('images/${DateTime.now().toString()}');
      UploadTask uploadTask = ref.putFile(image);
      await uploadTask.whenComplete(() => print('Upload Complete'));
      String downloadURL = await ref.getDownloadURL();
      setState(() {
        productImageUrl = downloadURL;
      });
    } catch (e) {
      print('Error: $e');
    } finally {
      setState(() {
        isUploading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 200),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(onTap: pickImage, child: Icon(Icons.upload)),
                InkWell(onTap: captureImage, child: Icon(Icons.camera_alt)),
              ],
            ),
            Image.network(
              productImageUrl??"https://lh3.googleusercontent.com/ogw/AF2bZyiFN7Ry1ZR6w2OOh8G011f_u8sFmgMpROxVFe00Bhy03bE=s32-c-mo"
            ),
            Text(productImageUrl??"link illa")
          ],
        ),
      ),
    );
  }
}
