import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:intl/intl.dart';
import 'package:too_good_to_go_app/presentation/view/home_view/give_review_screen/give_review_screen.dart';
import 'package:too_good_to_go_app/utils/constant/app_colors.dart';

import '../../../../utils/constant/back_end_config.dart';
import '../../../../utils/constant/image_string.dart';
import '../../../../utils/constant/loaders.dart';
import '../../../../utils/constant/sizes.dart';
import '../../../elements/custom_button.dart';
import '../../../elements/custom_text_field.dart';

class OrderScreen extends StatefulWidget {
  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final String userId = FirebaseAuth.instance.currentUser!.uid;
  TextEditingController otpController = TextEditingController();
  bool isOTPObsecure = true;
  bool isBusiness = false;
  final Map<String, bool> otpVisibilityMap = {};
  final Map<String, bool> expansionStateMap = {}; // Track ExpansionTile states

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }

  DateTime _parseTime(String timeString) {
    try {
      final DateFormat formatter = DateFormat("hh:mm a");
      DateTime todayDate = DateTime.now();
      DateTime parsedTime = formatter.parse(timeString);
      return DateTime(
        todayDate.year,
        todayDate.month,
        todayDate.day,
        parsedTime.hour,
        parsedTime.minute,
      );
    } catch (e) {
      print("Error parsing time: $e");
      return DateTime.now(); // Default to now if parsing fails
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Your Orders')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.lg / 1.2),
        child: StreamBuilder<List<QueryDocumentSnapshot>>(
          stream: fetchOrdersStream(),
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
                    Image.asset(AppImages.notProductYet, width: Get.width * 0.6),
                  ],
                ),
              );
            }

            var orders = snapshot.data!;
            return ListView.builder(
              itemCount: orders.length,
              padding: EdgeInsets.only(top: 12),
              itemBuilder: (context, index) {
                var order = orders[index];
                var orderData = order.data() as Map<String, dynamic>;

                final String expansionKey = order.id;

                expansionStateMap.putIfAbsent(expansionKey, () => false);
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Card(
                    child: ExpansionTile(
                      iconColor: AppColors.kPrimaryColor,
                      dense: true,
                      expansionAnimationStyle:
                          AnimationStyle(curve: Curves.easeIn, duration: Duration(milliseconds: 300)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      backgroundColor: AppColors.lightRed,
                      initiallyExpanded: expansionStateMap[expansionKey]!,
                      onExpansionChanged: (isExpanded) {
                        setState(() {
                          expansionStateMap[expansionKey] = isExpanded;
                        });
                      },
                      title: const Text('Order ID'),
                      subtitle: Text(order['order_id']),
                      children: orderData['cart_items'].asMap().entries.map<Widget>((entry) {
                        final int itemIndex = entry.key;
                        final Map<String, dynamic> item = entry.value;
                        // final String itemKey = 'order_${itemIndex}';
                        final String itemKey = '${order.id}_$itemIndex';
                        otpVisibilityMap.putIfAbsent(itemKey, () => true);
                        DateTime nowtime = DateTime.now(); // Current time
                        DateTime parsedEndTime = _parseTime(item['pEndTime']); // Convert end time string to DateTime

                        if (nowtime.isAfter(parsedEndTime)) {
                          print('expired');
                        } else {
                          print('wait');
                        }

                        return Column(
                          children: [
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Hurry your order needs to be collected from\n${item['pStartTime']} to ${item['pEndTime']}',
                                      style: Theme.of(context).textTheme.labelLarge,
                                      textAlign: TextAlign.center,
                                    ),
                                    ListTile(
                                      contentPadding: EdgeInsets.all(5),
                                      leading: Container(
                                        height: 35,
                                        width: 35,
                                        clipBehavior: Clip.antiAlias,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),
                                        child: Image.network(
                                          item['pImage'],
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      title: Text(item['pName'], overflow: TextOverflow.ellipsis),
                                      subtitle: isBusiness
                                          ? InkWell(
                                              onTap: nowtime.isAfter(parsedEndTime)
                                                  ? null
                                                  : () {
                                                      Get.dialog(
                                                        barrierDismissible: false,
                                                        Dialog(
                                                          child: Padding(
                                                            padding: const EdgeInsets.all(12.0),
                                                            child: Column(
                                                              mainAxisSize: MainAxisSize.min,
                                                              children: [
                                                                const SizedBox(height: 20),
                                                                const Text('OTP Validation',
                                                                    style: TextStyle(fontWeight: FontWeight.bold)),
                                                                const SizedBox(height: 20),
                                                                CustomTextField(
                                                                  controller: otpController,
                                                                  textInputType: TextInputType.number,
                                                                  inputFormatter: [LengthLimitingTextInputFormatter(4)],
                                                                  hintText: 'Enter Otp',
                                                                ),
                                                                const SizedBox(height: 30),
                                                                CustomButton(
                                                                  text: 'Validate',
                                                                  onTapped: () {
                                                                    if (otpController.text.isEmpty) {
                                                                      BLoaders.warningSnackBar(
                                                                          title: 'Warning',
                                                                          messagse: 'Please enter otp');
                                                                    } else if (item['otp'] !=
                                                                        otpController.text.toString()) {
                                                                      BLoaders.warningSnackBar(
                                                                          title: 'Warning',
                                                                          messagse: 'Please enter valid otp');
                                                                    } else {
                                                                      BLoaders.successSnackBar(
                                                                          title: 'Success',
                                                                          messagse: 'Congratulation ');
                                                                    }
                                                                  },
                                                                ),
                                                                const SizedBox(height: 20),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                              child: const Text(
                                                'Enter OTP',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold, color: AppColors.kPrimaryColor),
                                              ))
                                          : Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text('OTP: ${otpVisibilityMap[itemKey]! ? '****' : item['otp']}'),
                                                const SizedBox(width: 8),
                                                nowtime.isAfter(parsedEndTime)
                                                    ? Text('Expired')
                                                    : InkWell(
                                                        onTap: () {
                                                          setState(() {
                                                            otpVisibilityMap[itemKey] = !otpVisibilityMap[itemKey]!;
                                                          });
                                                          print(itemIndex);
                                                        },
                                                        child: Icon(
                                                          otpVisibilityMap[itemKey]! ? Iconsax.eye_slash : Iconsax.eye,
                                                          size: 20,
                                                        ),
                                                      ),
                                              ],
                                            ),
                                      trailing: FittedBox(
                                        child: TextButton(
                                          style: TextButton.styleFrom(
                                              side: const BorderSide(color: AppColors.kPrimaryColor)),
                                          onPressed: item['isReviewed']
                                              ? null
                                              : nowtime.isAfter(parsedEndTime)
                                                  ? null
                                                  : () {
                                                      Get.to(() =>
                                                          GiveReviewScreen(product: item, orderId: order['order_id']));
                                                    },
                                          child: Text(
                                            item['isReviewed'] ? 'reviewed'.tr : 'Add Review'.tr,
                                            style: const TextStyle(fontSize: 12),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  getCurrentUser() {
    FirebaseFirestore.instance
        .collection(BackEndConfig.kUserCollection)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .listen((DocumentSnapshot documentSnapshot) {
      setState(() {
        isBusiness = documentSnapshot.get('isBusiness');
      });
    });
  }

  Stream<List<QueryDocumentSnapshot>> fetchOrdersStream() {
    return FirebaseFirestore.instance
        .collection('order')
        .where('uid', isEqualTo: userId)
        .snapshots()
        .map((snapshot) => snapshot.docs);
  }
}
