import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class UsersService{
  final CollectionReference users = FirebaseFirestore.instance.collection('users');
  FirebaseStorage storage = FirebaseStorage.instance;
  bool doesUsernameExist = false;
  Future addUser(String username, String? userId) async{
    await users.doc(userId).set({
      'username': username,
      'usernameLower': username.toLowerCase(),
      'userId': userId,
      'biography': '',
      'profilepicture': 'https://firebasestorage.googleapis.com/v0/b/sucial-ff03d.appspot.com/o/user%2Fprofile%2FprofilePic%2Fnopp.png?alt=media&token=eaebea99-fc2d-4ede-893d-070e2d2595b0',
      'fullName': 'unknown'
    });
  }
  Future<String> uploadFile(User? user,File file) async{
    var storageRef = storage.ref().child("user/profile/profilePic/${user!.uid}");
    var uploadTask = await storageRef.putFile(file);
    String downloadURL = await uploadTask.ref.getDownloadURL();
    return downloadURL;
  }
  Future<void> uploadProfilePicture(User? user,File image) async
  {
    String url = await uploadFile(user, image);
    setProfilePic(url, user!.uid);

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
  setProfilePic(String url, String userId) async{
    await users.doc(userId).update({
      'profilepicture': url,
    });
  }
  setFullName(String fullName, String userId) async{
    await users.doc(userId).update({
      'biography': '',
      'fullName': fullName,
      'fullNameLower': fullName.toLowerCase(),
    });
  }

}
