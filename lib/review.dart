// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:too_good_to_go_app/utils/constant/back_end_config.dart';
//
// import 'give_review.dart';
//
// class ReviewScreenGPT extends StatefulWidget {
//   final String orderId;
//
//   const ReviewScreenGPT({super.key, required this.orderId});
//
//   @override
//   State<ReviewScreenGPT> createState() => _ReviewScreenGPTState();
// }
//
// class _ReviewScreenGPTState extends State<ReviewScreenGPT> {
//   late Future<List<Map<String, dynamic>>> orderItemsFuture;
//
//   @override
//   void initState() {
//     super.initState();
//     orderItemsFuture = fetchOrderDetails(widget.orderId);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Cart Product Review'),
//       ),
//       body: FutureBuilder<List<Map<String, dynamic>>>(
//         future: orderItemsFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return Center(child: Text('No items found in this order.'));
//           } else {
//             List<Map<String, dynamic>> orderItems = snapshot.data!;
//             return ListView.builder(
//               itemCount: orderItems.length,
//               itemBuilder: (context, index) {
//                 Map<String, dynamic> product = orderItems[index];
//                 return ListTile(
//                   title: Text(product['pName']),
//                   subtitle: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text('Total Price: \$${product['totalPrice']}'),
//                       Text('Total qty: ${product['qty']}'),
//                       Text('product id : ${product['pId']}'),
//                       SizedBox(height: 8),
//                       ElevatedButton(
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => GiveReview(product: product),
//                             ),
//                           );
//                         },
//                         child: Text('Give Review'),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
//
//   Future<List<Map<String, dynamic>>> fetchOrderDetails(String orderId) async {
//     DocumentSnapshot orderSnapshot = await BackEndConfig.orderCollection.doc(orderId).get();
//     List<Map<String, dynamic>> orderItems = List<Map<String, dynamic>>.from(orderSnapshot['cart_items']);
//     return orderItems;
//   }
// }

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ReviewScreenGPT extends StatelessWidget {
  final Map<String, dynamic> product;

  ReviewScreenGPT({required this.product, Key? key}) : super(key: key);

  final TextEditingController _reviewController = TextEditingController();
  final TextEditingController _ratingController = TextEditingController();

  Future<void> submitReview() async {
    var userId = FirebaseAuth.instance.currentUser!.uid;
    var reviewData = {
      'product_id': product['pId'],
      'user_id': userId,
      'review': _reviewController.text,
      'rating': int.parse(_ratingController.text),
      'time': Timestamp.now(),
    };

    await FirebaseFirestore.instance.collection('reviews').add(reviewData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Review Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Product: ${product['pName']}'),
            const SizedBox(height: 10),
            TextField(
              controller: _reviewController,
              decoration: const InputDecoration(
                labelText: 'Your Review',
                border: OutlineInputBorder(),
              ),
              maxLines: 4,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _ratingController,
              decoration: const InputDecoration(
                labelText: 'Rating (1-5)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await submitReview();
                Get.back();
                Get.snackbar(
                  'Success',
                  'Review submitted successfully',
                  snackPosition: SnackPosition.BOTTOM,
                );
              },
              child: const Text('Submit Review'),
            ),
          ],
        ),
      ),
    );
  }
}
