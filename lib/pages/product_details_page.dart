import 'package:chatapp/common/widgets/containers/rounded_container.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProductDetails extends StatefulWidget {
  final String? productName;
  final String? productDescription;
  final String? productPrice;
  final String? productImage;
  final String? sellerId;
  final String? userName;

  const ProductDetails({
    Key? key,
    this.productName,
    this.productDescription,
    this.productPrice,
    this.productImage,
    this.sellerId,
    this.userName,
  }) : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(
                widget.productImage ?? '',
                fit: BoxFit.contain,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Name
                  Text(
                    widget.productName ?? '',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  // Price
                  Text(
                    'Price: ${widget.productPrice}',
                    style: TextStyle(fontSize: 20, color: Colors.blue),
                  ),
                  SizedBox(height: 16),
                  // Seller Name
                  Text(
                    'Seller: ${widget.userName}',
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                  SizedBox(height: 16),
                  // Description
                  Text(
                    'Description',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    widget.productDescription ?? '',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 24),
                  // Price Proposal
                  Text(
                    'Make an Offer',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: TRoundedContainer(
                          child: TextField(
                            controller: controller,
                            decoration: InputDecoration(
                              hintText: 'Enter your offer...',
                              border: InputBorder.none,
                              prefixText: ' ₹ ',
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {
                          FirebaseFirestore.instance
                              .collection('product_requests')
                              .add({
                            'uid': FirebaseAuth.instance.currentUser!.uid,
                            'productId': widget.productName,
                            'price_propose': controller.text,
                            'sellerId': widget.sellerId,
                            'approved': true
                          });
                          // Show confirmation dialog or snackbar
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Offer sent successfully!')),
                          );
                        },
                        child: Text('Send Offer'),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black87, backgroundColor: Colors.blue,
                          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}