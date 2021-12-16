import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
      'followerCount': 0,
      'followingCount': 0
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
  followSomeBody(UserProfile crrUser, UserProfile otherUser){
    // if not private
    users.doc(crrUser.userId).update(
      {
        "following": FieldValue.arrayUnion([otherUser.userId]),
        "followingCount": crrUser.followingCount +1
      }
    );
    users.doc(otherUser.userId).update(
        {
          "followers": FieldValue.arrayUnion([crrUser.userId]),
          "followerCount": otherUser.followerCount+1
        }
    );
    // TO DO: If private, send request
  }
  unFollow(UserProfile crrUser, UserProfile otherUser)
  {
    users.doc(crrUser.userId).update(
        {
          "following": FieldValue.arrayRemove([otherUser.userId]),
          "followingCount": crrUser.followingCount - 1
        }
    );
    users.doc(otherUser.userId).update(
        {
          "followers": FieldValue.arrayRemove([crrUser.userId]),
          "followerCount": otherUser.followerCount-1
        }
    );
  }
}
