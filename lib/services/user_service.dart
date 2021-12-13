import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UsersService{
  final CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future addUser(String username, String? userId) async{
    await users.doc(userId).set({
      'username': username,
      'userId': userId,
      'biography': '',
      'profilepicture': '',
      'fullName': 'unknown'
    });
  }


}
