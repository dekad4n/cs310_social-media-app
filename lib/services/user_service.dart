import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:sucial_cs310_project/model/post.dart';
import 'package:sucial_cs310_project/model/user_profile.dart';

class UsersService{
  final CollectionReference users = FirebaseFirestore.instance.collection('users');
  final FirebaseStorage storage = FirebaseStorage.instance;
  bool doesUsernameExist = false;
  Future addUser(String username, String? userId) async{
    await users.doc(userId).set({
      'username': username,
      'usernameLower': username.toLowerCase(),
      'userId': userId,
      'biography': '',
      'profilepicture': 'https://firebasestorage.googleapis.com/v0/b/sucial-ff03d.appspot.com/o/user%2Fprofile%2FprofilePic%2Fnopp.png?alt=media&token=eaebea99-fc2d-4ede-893d-070e2d2595b0',
      'fullName': 'unknown',
      'isSignupDone': false,
      'followers': [],
      'following': [],
      'posts': [],
      'requests': [],
      'isPrivate': false
    });
  }
  Future getUser(String userId) async
  {
    var crrGet = await users.doc(userId).get();
  }
  Future isSignupDone(String userId) async{
    bool? dynamicNested;
    users.doc(userId).get().then((DocumentSnapshot documentSnapshot) {
      dynamicNested = documentSnapshot.get(FieldPath(['isSignupDone']));
      });
    return dynamicNested ?? false;
  }

  Future<String> uploadFile(User? user,File file) async{
    var storageRef = storage.ref().child("user/profile/profilePic/${user!.uid}");
    var uploadTask = await storageRef.putFile(file);
    String downloadURL = await uploadTask.ref.getDownloadURL();
    return downloadURL;
  }
  Future<String> uploadPost(User? user,File file) async{
    var storageRef = storage.ref().child("user/profile/posts/${user!.uid}");
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
  Future<bool> doesFollow(String userId, String otherUserId) async
  {
    var docRef = await users.doc(userId).get();
    var obj = docRef.data() as Map<String, dynamic>;
    var following = obj["following"];
    return following.contains(otherUserId);
  }
  Future<bool> hasFollower(String userId, String otherUserId) async
  {
    var docRef = await users.doc(otherUserId).get();
    var obj = docRef.data() as Map<String, dynamic>;
    var following = obj["followers"];
    return following.contains(userId);
  }
  void doesUsernameExistIn(String username) async{
    doesUsernameExist = await _doesUsernameExist(username);
  }
  setProfilePic(String url, String userId) async{
    users.doc(userId).update({
      'profilepicture': url,
    });
  }
  setBiography(String bio, String userId) async{
    users.doc(userId).update({
      'biography': bio,
    });
  }
  setFullName(String fullName, String userId) async{
    users.doc(userId).update({
      'isSignupDone': true,
      'fullName': fullName,
      'fullNameLower': fullName.toLowerCase(),
    });
  }
  removeRequest(String requesterId, String requestedId) async
  {
    users.doc(requestedId).update(
        {
          "requests": FieldValue.arrayRemove([requesterId]),
        }
    );
  }
  followSomeBody(String crrUserId, String otherUserId, bool isPrivate) async
  {
    // if not private
    if(!isPrivate) {
      users.doc(crrUserId).update(
          {
            "following": FieldValue.arrayUnion([otherUserId]),
          }
      );
      users.doc(otherUserId).update(
          {
            "followers": FieldValue.arrayUnion([crrUserId]),
          }
      );
    }
    else{
      // TO DO: If private, send request
      users.doc(otherUserId).update(
          {
            "requests": FieldValue.arrayUnion([crrUserId]),
          }
      );
    }
  }
  unFollow(String crrUserId, String otherUserId) async
  {
    users.doc(crrUserId).update(
        {
          "following": FieldValue.arrayRemove([otherUserId]),
        }
    );
    users.doc(otherUserId).update(
        {
          "followers": FieldValue.arrayRemove([crrUserId]),
        }
    );
  }
  createPost(String userId, Post post) async
  {
    users.doc(userId).update(
      {
        'posts': FieldValue.arrayUnion([post.toJson()]),
      }
    );
  }
  deletePost(String userId, Map<String, dynamic> post) async{
    users.doc(userId).update({
      "posts": FieldValue.arrayRemove([post])
    });
  }
  updatePrivacy(String userId, bool isPrivate) async{
    users.doc(userId).update({
      "isPrivate": isPrivate
    });
  }
}
