import 'package:chatapp/common/widgets/containers/rounded_container.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class productDetails extends StatefulWidget {
  final String? productName;
  final String? productDescription;
  final String? productPrice;
  final String? productImage;
  final String? sellerId;

  const productDetails(
      {super.key,
      this.productName,
      this.productDescription,
      this.productPrice,
      this.productImage,
      this.sellerId});

  @override
  State<productDetails> createState() => _productDetailsState();
}

class _productDetailsState extends State<productDetails> {
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  const Text("Product Detail",
                      style: TextStyle(
                          fontSize: 40,
                          decoration: TextDecoration.none,
                          color: Colors.black)),
                  // const Center(
                  //     child: Icon(Icons.favorite,
                  //         color: Colors.black, size: 200)),
                  // const SizedBox(height: 20),
                  // const Text(
                  //   "Details",
                  //   style: TextStyle(
                  //       fontSize: 20,
                  //       decoration: TextDecoration.none,
                  //       color: Colors.black),
                  // ),
                  const SizedBox(height: 20),
                  const SizedBox(height: 20),
                  Text(
                    "${widget.productName}",
                    style: const TextStyle(
                      fontSize: 20,
                      decoration: TextDecoration.none,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Description: $productDetails",
                    style: const TextStyle(
                      fontSize: 20,
                      decoration: TextDecoration.none,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Price:   ${widget.productPrice}",
                    style: const TextStyle(
                      fontSize: 20,
                      decoration: TextDecoration.none,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Image.network(widget.productImage ?? ""),
                  // Text(
                  //   "productImage: $productImage?",
                  //   style: const TextStyle(
                  //     fontSize: 20,
                  //     decoration: TextDecoration.none,
                  //     color: Colors.black,
                  //   ),
                  // )
                  Row(children: [
                    Expanded(
                      child: TRoundedContainer(
                        child: TextField(
                          controller: controller,
                          decoration: InputDecoration(
                              hintText: 'type your price here...'),
                        ),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          FirebaseFirestore.instance
                              .collection('product_requests')
                              .add({
                            'uid': FirebaseAuth.instance.currentUser!.uid,
                            'productId': widget.productName,
                            'price_propose': controller.text,
                            'sellerId':widget.sellerId,
                            'approved': true
                          });
                        },
                        icon: Icon(Icons.send))
                  ])
                  // Row(
                  //   children: [
                  //     TextField(

                  //     ),
                  //     IconButton(onPressed: (){}, icon: Icon(Icons.abc))
                  //   ],
                  // )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
