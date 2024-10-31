import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BackEndConfig {
  static const String kBusinessCategory = 'businessCategoies';
  static const String kMenus = 'menu';
  static const String kBusiness = 'business';
  static const String kUserCollection = 'users';
  static const String kProduct = 'products';

  static CollectionReference userCollection = FirebaseFirestore.instance.collection('users');

  static CollectionReference businessCollection = FirebaseFirestore.instance.collection('business');
  static CollectionReference menuCollection = FirebaseFirestore.instance.collection('menu');
  static CollectionReference businessCategoriesCollection = FirebaseFirestore.instance.collection('businessCategoies');
  static CollectionReference productCollection = FirebaseFirestore.instance.collection('products');
  static CollectionReference reviewCollection = FirebaseFirestore.instance.collection('reviews');
  static CollectionReference orderCollection = FirebaseFirestore.instance.collection('order');
}
