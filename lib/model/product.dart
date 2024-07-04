import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Product {
  final String productName;
  final String productDescription;
  final String productPrice;
  final String productImage;
  Product({
    required this.productName,
    required this.productDescription,
    required this.productPrice,
    required this.productImage,
  }) {
    FirebaseFirestore.instance.collection('products').add({
      'uid': FirebaseAuth.instance.currentUser!.uid,
      'userName': FirebaseAuth.instance.currentUser!.displayName,
      'productName': productName,
      'productDescription': productDescription,
      'productPrice': productPrice,
      'productImage': productImage,
      'status': "Available",
    });
  }
}
