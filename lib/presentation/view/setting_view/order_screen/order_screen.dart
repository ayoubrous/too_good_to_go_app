// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:too_good_to_go_app/utils/constant/app_colors.dart';
// import 'package:too_good_to_go_app/utils/constant/sizes.dart';
// import 'package:too_good_to_go_app/utils/theme/theme.dart';
//
// import '../../../../utils/constant/image_string.dart';
//
// class OrderScreen extends StatelessWidget {
//   const OrderScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('order'.tr),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: AppSizes.lg),
//           child: Column(
//             children: [
//               20.sH,
//               StreamBuilder(
//                 stream: FirebaseFirestore.instance
//                     .collection('order')
//                     .where(
//                       'uid',
//                       isEqualTo: FirebaseAuth.instance.currentUser!.uid,
//                     )
//                     .snapshots(),
//                 builder: (context, snapshot) {
//                   if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
//                     return Center(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           const SizedBox(height: kToolbarHeight),
//                           Text(
//                             'noOrder'.tr,
//                             textAlign: TextAlign.center,
//                             style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
//                           ),
//                           const SizedBox(height: kToolbarHeight / 2),
//                           Image.asset(
//                             AppImages.notProductYet,
//                             width: Get.width * 0.4,
//                           ),
//                           const SizedBox(height: kToolbarHeight),
//                         ],
//                       ),
//                     );
//                   }
//                   if (snapshot.hasError) {
//                     Text(
//                       'someThingWentWrong'.tr,
//                       style: Theme.of(context).textTheme.bodyLarge,
//                     );
//                   }
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return const Center(
//                       child: CircularProgressIndicator(),
//                     );
//                   }
//                   return ListView.builder(
//                     shrinkWrap: true,
//                     primary: false,
//                     itemCount: snapshot.data!.docs.length,
//                     itemBuilder: (context, index) {
//                       var data = snapshot.data!.docs[index];
//                       return Card(
//                         color: AppColors.textFieldGreyColor,
//                         child: Padding(
//                           padding: const EdgeInsets.all(10.0),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Row(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Container(
//                                     clipBehavior: Clip.antiAlias,
//                                     height: 80,
//                                     width: 80,
//                                     decoration: BoxDecoration(
//                                         color: Colors.red.withOpacity(0.5), borderRadius: BorderRadius.circular(12)),
//                                     child: CachedNetworkImage(
//                                       fit: BoxFit.cover,
//                                       imageUrl: data['order_product_image'].toString(),
//                                     ),
//                                   ),
//                                   10.sW,
//                                   Expanded(
//                                     child: Column(
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: [
//                                         Row(
//                                           children: [
//                                             Text(
//                                               'order'.tr + "#\t",
//                                               style: Theme.of(context)
//                                                   .textTheme
//                                                   .bodyLarge!
//                                                   .copyWith(fontWeight: FontWeight.bold),
//                                             ),
//                                             Text(
//                                               data['oder_id'].toString().substring(16),
//                                               style: Theme.of(context)
//                                                   .textTheme
//                                                   .bodyLarge!
//                                                   .copyWith(fontWeight: FontWeight.bold),
//                                             ),
//                                           ],
//                                         ),
//                                         Text(
//                                           'totalAmount'.tr + "\t",
//                                           style: Theme.of(context)
//                                               .textTheme
//                                               .bodyLarge!
//                                               .copyWith(fontWeight: FontWeight.w500),
//                                         ),
//                                         5.sH,
//                                         Row(
//                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             FittedBox(
//                                               child: Text(
//                                                 '\$${data['total_price'].toString()}',
//                                                 style: Theme.of(context).textTheme.bodyLarge!.copyWith(
//                                                     fontWeight: FontWeight.bold, color: AppColors.kPrimaryColor),
//                                               ),
//                                             ),
//                                             Text(
//                                               "x${data['qty'].toString()}",
//                                               style: Theme.of(context).textTheme.bodyLarge!.copyWith(
//                                                   fontWeight: FontWeight.bold, color: AppColors.kPrimaryColor),
//                                             ),
//                                             Text(
//                                               'paid'.tr,
//                                               style: Theme.of(context)
//                                                   .textTheme
//                                                   .bodyLarge!
//                                                   .copyWith(color: AppColors.kGreenColor, fontWeight: FontWeight.bold),
//                                             ),
//                                           ],
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               10.sH,
//                               Row(
//                                 children: [
//                                   Text(
//                                     'dateTime'.tr + "\t",
//                                     style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
//                                   ),
//                                   Text(
//                                     data['time'],
//                                     style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w500),
//                                   ),
//                                 ],
//                               )
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   );
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:too_good_to_go_app/presentation/view/home_view/give_review_screen/give_review_screen.dart';
import 'package:too_good_to_go_app/utils/constant/app_colors.dart';

import '../../../../utils/constant/image_string.dart';
import '../../../../utils/constant/sizes.dart';

class OrderScreen extends StatefulWidget {
  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  // Stream<QuerySnapshot> fetchOrders() {
  Future<List<QueryDocumentSnapshot>> fetchOrders() async {
    var userId = FirebaseAuth.instance.currentUser!.uid;
    var snapshot = await FirebaseFirestore.instance.collection('order').where('uid', isEqualTo: userId).get();
    return snapshot.docs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Orders'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.lg / 1.2),
        child: FutureBuilder(
          future: fetchOrders(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return const Center(child: Text('Something went wrong'));
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'No Order Found'.tr,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: kToolbarHeight),
                    Image.asset(
                      AppImages.notProductYet,
                      width: Get.width * 0.6,
                    ),
                  ],
                ),
              );
            }

            var orders = snapshot.data!;
            return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                var order = orders[index];
                var orderData = order.data() as Map<String, dynamic>;
                return Card(
                  clipBehavior: Clip.antiAlias,
                  elevation: 5,
                  color: AppColors.lightRed,
                  child: ExpansionTile(
                    iconColor: AppColors.kPrimaryColor,
                    initiallyExpanded: true,
                    title: Text('Order ID:\n${order['order_id']}'),
                    children: orderData['cart_items'].map<Widget>((item) {
                      return Column(
                        children: [
                          ListTile(
                            title: Text(item['pName']),
                            subtitle: Row(
                              children: [
                                Text('actualPrice'.tr + "\t:"),
                                Text(
                                  ' \$${item['totalPrice']}',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            trailing: TextButton(
                              style: TextButton.styleFrom(side: BorderSide(color: AppColors.kPrimaryColor)),
                              onPressed: item['isReviewed']
                                  ? null
                                  : () {
                                      Get.to(() => GiveReviewScreen(product: item, orderId: order['order_id']));
                                    },
                              // this isReviewed is from cart collection
                              child: Text(
                                item['isReviewed'] ? 'reviewed'.tr : 'addYourReview'.tr,
                                style: TextStyle(fontSize: 13),
                              ),
                            ),
                          ),
                          Divider(),
                        ],
                      );
                    }).toList(),
                  ),
                );
                // return Card(
                //   margin: EdgeInsets.symmetric(vertical: AppSizes.sm),
                //   elevation: 5,
                //   color: AppColors.lightRed,
                //   child: Padding(
                //     padding: const EdgeInsets.all(10),
                //     child: Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Row(
                //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //           children: [
                //             Expanded(
                //               child: Text(
                //                 'Order ID:\n${orderData['order_id']}',
                //                 style: const TextStyle(fontWeight: FontWeight.bold),
                //               ),
                //             ),
                //             ClipRRect(
                //               borderRadius: BorderRadius.circular(6),
                //               child: ColoredBox(
                //                 color: AppColors.kGreenColor,
                //                 child: const Padding(
                //                   padding: EdgeInsets.symmetric(horizontal: 8.0),
                //                   child: Text(
                //                     'Paid',
                //                     style: TextStyle(fontWeight: FontWeight.bold),
                //                   ),
                //                 ),
                //               ),
                //             ),
                //           ],
                //         ),
                //         const SizedBox(height: 5),
                //         Row(
                //           children: [
                //             const Text('Total Price:\t'),
                //             Text(
                //               '\$${orderData['total_price']}',
                //               style: const TextStyle(fontWeight: FontWeight.bold),
                //             )
                //           ],
                //         ),
                //         const SizedBox(height: 5),
                //         Row(
                //           children: [
                //             const Text('Order Date:\t'),
                //             Text(
                //               '\$${orderData['time']}',
                //               style: const TextStyle(fontWeight: FontWeight.bold),
                //             )
                //           ],
                //         ),
                //         const SizedBox(height: 10),
                //         const Text('Items:', style: TextStyle(fontWeight: FontWeight.bold)),
                //         ...orderData['cart_items'].map<Widget>((item) {
                //           return Padding(
                //             padding: const EdgeInsets.only(top: 5),
                //             child: Row(
                //               children: [
                //                 Card(
                //                   shadowColor: AppColors.greyColor,
                //                   color: AppColors.greyColor,
                //                   clipBehavior: Clip.antiAlias,
                //                   elevation: 5,
                //                   child: CachedNetworkImage(
                //                     height: 45,
                //                     width: 55,
                //                     fit: BoxFit.cover,
                //                     imageUrl: item['pImage'].toString(),
                //                     errorWidget: (context, url, error) {
                //                       return const Icon(Icons.error_outline);
                //                     },
                //                   ),
                //                 ),
                //                 // Image.network(
                //                 //   item['pImage'].toString(),
                //                 //   height: 40,
                //                 //   width: 50,
                //                 //   fit: BoxFit.cover,
                //                 // ),
                //                 5.sW,
                //                 Expanded(child: Text(item['pName'])),
                //                 Text('\$${item['totalPrice']}'),
                //               ],
                //             ),
                //           );
                //         }).toList(),
                //       ],
                //     ),
                //   ),
                // );
              },
            );
          },
        ),
      ),
    );
  }
}
