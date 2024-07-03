import 'package:chatapp/pages/chat_page.dart';
import 'package:chatapp/services/auth/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chatapp/components/my_button2.dart';
import 'package:chatapp/components/my_button3.dart';

import '../components/bottom_nav.dart';

class ReqPage extends StatefulWidget {
  const ReqPage({super.key});

  @override
  State<ReqPage> createState() => _ReqPageState();
}

class _ReqPageState extends State<ReqPage> {
  // Instance of auth
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void signOut() {
    // Sign out code
    final authService = Provider.of<AuthService>(context, listen: false);
    authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        actions: [
          // Sign out button
          IconButton(
            onPressed: signOut,
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: _buildRequestList(),
      bottomNavigationBar: BottomNav(),
    );
  }

  // Build list of users who requested products from the current logged-in seller
  Widget _buildRequestList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('products')
          .where('uid', isEqualTo: _auth.currentUser!.uid)
          .snapshots(),
      builder: (context, productSnapshot) {
        if (productSnapshot.hasError) {
          return const Text('Error');
        }
        if (productSnapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading...');
        }

        final productIds =
            productSnapshot.data!.docs.map((doc) => doc['productId']).toList();

        return StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('product_requests')
              .where('productId', whereIn: productIds)
              .snapshots(),
          builder: (context, requestSnapshot) {
            if (requestSnapshot.hasError) {
              return const Text('Error');
            }
            if (requestSnapshot.connectionState == ConnectionState.waiting) {
              return const Text('Loading...');
            }

            final requests = requestSnapshot.data!.docs;

            return ListView.builder(
              itemCount: requests.length,
              itemBuilder: (context, index) {
                final request = requests[index];
                return StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc(request['uid'])
                      .snapshots(),
                  builder: (context, userSnapshot) {
                    if (userSnapshot.hasError) {
                      return const Text('Error');
                    }
                    if (userSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Text('Loading...');
                    }

                    final userDoc = userSnapshot.data!;
                    final pricePropose =
                        double.tryParse(request['price_propose']) ?? 0.0;
                    return _buildUserListItem(userDoc, pricePropose);
                  },
                );
              },
            );
          },
        );
      },
    );
  }

  // Build individual user list item
  Widget _buildUserListItem(DocumentSnapshot document, double pricePropose) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.blue,
        child: Text(
          data['email'][0].toUpperCase(),
          style: const TextStyle(color: Colors.white),
        ),
      ),
      title: Text(
        data['email'],
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      subtitle: Text(
        "I'd buy it for $pricePropose dollars",
        style: TextStyle(
          color: Colors.grey,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 80, // Adjust the width as needed
            child: MyAcceptButton(
              text: 'Chat',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatPage(
                      receiverUserEmail: data['email'],
                      receiverUserID: data['uid'],
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(width: 8), // Add some spacing between buttons
          SizedBox(
            width: 80, // Adjust the width as needed
            child: MyRejectButton(
              text: '',
              onTap: () {},
            ),
          ),
        ],
      ),
      tileColor: Colors.grey[200],
      contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}
