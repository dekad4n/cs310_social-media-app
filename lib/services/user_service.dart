import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UsersService{
  final CollectionReference users = FirebaseFirestore.instance.collection('users');
  bool doesUsernameExist = false;
  Future addUser(String username, String? userId) async{
    await users.doc(userId).set({
      'username': username,
      'usernameLower': username.toLowerCase(),
      'userId': userId,
      'biography': '',
      'profilepicture': '',
      'fullName': 'unknown'
    });
  }
  Future<bool> _doesUsernameExist(String username) async
  {
    var docRef = users.doc('username');
    var doc = await docRef.get();

    if(!doc.exists)
      {
        return false;
      }
    return true;
  }
  void doesUsernameExistIn(String username) async{
    doesUsernameExist = await _doesUsernameExist(username);
  }
  setFullName(String fullName, String userId) async{
    await users.doc(userId).update({
      'biography': '',
      'profilepicture': '',
      'fullName': fullName,
      'fullNameLower': fullName.toLowerCase(),
    });
  }

}
