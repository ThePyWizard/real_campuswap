import 'package:chatapp/common/widgets/containers/rounded_container.dart';
import 'package:chatapp/model/product.dart';
import 'package:chatapp/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

import '../components/bottom_nav.dart';

class SellPage extends StatefulWidget {
  const SellPage({super.key});

  @override
  State<SellPage> createState() => _SellPageState();
}

class _SellPageState extends State<SellPage> {
  TextEditingController productNameController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();
  TextEditingController productDescriptionController = TextEditingController();

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
      Reference ref = storage.ref().child('images/${DateTime.now().toString()}');
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
        padding: EdgeInsets.all(TSizes.lg),
        child: Column(
          children: [
                        const SizedBox(height: TSizes.productImageHeight),

            const Text("Heading",

                      style: TextStyle(
                          fontSize: 40,
                          decoration: TextDecoration.none,
                          color: Colors.black)),
            const SizedBox(height: TSizes.defaultSpace),
            TRoundedContainer(
              child: TextField(
                controller: productNameController,
                decoration: InputDecoration(
                  hintText: 'Enter product name',
                ),
              ),
            ),
            const SizedBox(height: TSizes.defaultSpace),
            TRoundedContainer(
              child: TextField(
                controller: productDescriptionController,
                decoration: InputDecoration(
                  hintText: 'Enter product description',
                ),
              ),
            ),
            const SizedBox(height: TSizes.defaultSpace),
            TRoundedContainer(
              child: TextField(
                controller: productPriceController,
                decoration: InputDecoration(
                  hintText: 'Enter product price',
                ),
              ),
            ),
            const SizedBox(height: TSizes.defaultSpace),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: pickImage,
                    child: const Text('Gallery'),
                  ),
                ),
                const SizedBox(width: TSizes.defaultSpace),
                Expanded(
                  child: ElevatedButton(
                    onPressed: captureImage,
                    child: const Text('Camera'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Product(
                        productName: productNameController.text,
                        productDescription: productDescriptionController.text,
                        productPrice: productPriceController.text,
                        productImage: productImageUrl ?? "Image",
                      );
                    },
                    child: const Text('Submit'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNav(
        currentIndex: 2,
        onTap: (index) {
          if (index != 2) {
            Navigator.pushReplacementNamed(context, ['/home', '/req', '/sell','/profile'][index]);
          }
        },
      ),
    );
  }
}
