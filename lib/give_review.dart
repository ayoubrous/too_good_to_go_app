import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class GiveReview extends StatefulWidget {
  final Map<String, dynamic> product;

  const GiveReview({super.key, required this.product});

  @override
  State<GiveReview> createState() => _GiveReviewState();
}

class _GiveReviewState extends State<GiveReview> {
  final TextEditingController reviewController = TextEditingController();

  Future<void> submitReview(String review) async {
    String reviewId = FirebaseFirestore.instance.collection('reviews').doc().id;
    await FirebaseFirestore.instance.collection('reviews').doc(reviewId).set({
      'review_id': reviewId,
      'product_id': widget.product['pId'],
      'user_id': FirebaseAuth.instance.currentUser!.uid,
      'review': review,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Review ${widget.product['pName']}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: reviewController,
              maxLines: 5,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Your Review',
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                await submitReview(reviewController.text);
                Get.snackbar('Success', 'Review submitted successfully');
                Navigator.pop(context);
              },
              child: Text('Submit Review'),
            ),
          ],
        ),
      ),
    );
  }
}
