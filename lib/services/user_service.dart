import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:sucial_cs310_project/model/post.dart';
import 'package:sucial_cs310_project/model/user_profile.dart';
import 'package:sucial_cs310_project/services/post_service.dart';

class UsersService{
  final CollectionReference users = FirebaseFirestore.instance.collection('users');
  final FirebaseStorage storage = FirebaseStorage.instance;
  bool doesUsernameExists = false;
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
      'isPrivate': false,
      'notifications': [],
      'isThereNewNotif': false,
      'isDisabled': false
    });
  }
  Future deleteUser(String userId) async
  {
    users.doc(userId).delete();

  }
  Future disableUser(String userId) async{
    await users.doc(userId).update(
        {
          'isDisabled': true
        }
    );
    var docRef = await users.doc(userId).get();
    var posts = (docRef.data() as Map<String, dynamic>)["posts"];
    int i = 0;
    PostService postService = PostService();
    for(; i < posts.length ; i++)
    {
      posts[i]["isDisabled"] = true;
      postService.disablePost(userId + posts[i]['postId'].toString());


    }
    users.doc(userId).update(
      {
        'posts': posts
      }
    );
  }
  Future enableUser(String userId) async{
    await users.doc(userId).update(
      {
        'isDisabled': false
      }
    );
    var docRef = await users.doc(userId).get();
    var posts = (docRef.data() as Map<String, dynamic>)["posts"];
    int i = 0;
    PostService postService = PostService();
    for(; i < posts.length ; i++)
    {
      posts[i]["isDisabled"] = false;
      postService.enablePost(userId + posts[i]['postId'].toString());
    }
    users.doc(userId).update(
        {
          'posts': posts
        }
    );
  }
  Future getUser(String userId) async
  {
    var crrGet = await users.doc(userId).get();
  }

  Future getUserName(String userId) async
  {
    var crrGet = await users.doc(userId).get();
    return crrGet.get("username");
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
  // Bu yanlis olmali
  Future<bool> doesUsernameExist(String username) async
  {
    final QuerySnapshot result = await users
        .where('username', isEqualTo: username)
        .limit(1)
        .get();
    final List<DocumentSnapshot> documents = result.docs;
    return documents.length == 1;

  }
  Future<String> getUsername(String userId) async
  {
    var docRef = await users.doc(userId).get();
    var obj = docRef.data() as Map<String, dynamic>;
    var username = obj["username"];
    return username;
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
    doesUsernameExists = await doesUsernameExist(username);
    print("does username exist: $doesUsernameExist");
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
  acceptRequest(String requesterId, String requestedId) async{
    users.doc(requestedId).update(
        {
          "requests": FieldValue.arrayRemove([requesterId]),
          "followers": FieldValue.arrayUnion([requesterId])
        }
    );
    users.doc(requesterId).update(
        {
          "following": FieldValue.arrayUnion([requestedId])
        }
    );

  }



  pushNotifications(String crrUserId, String otherUserId, String message) async
  {
    // var crrGet = await users.doc(crrUserId);
    String current = await getUserName(crrUserId);
    users.doc(otherUserId).update(
        {
          "notifications": FieldValue.arrayUnion([{
            "context": message,
            "senderId": crrUserId
          }]),
          "isThereNewNotif": true
        }
    );
  }
  followSomeBody(String crrUserId, String otherUserId, bool isPrivate) async
  {
    // if not private
    if(!isPrivate) {
      // TO DO: PUSH NOTIFICATION
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
      pushNotifications(crrUserId, otherUserId, " started following you.");
    }
    else{
      String current = await getUserName(crrUserId);
      // TO DO: If private, send request
      users.doc(otherUserId).update(
          {
            // TO DO: PUSH NOTIFICATION AS REQUEST
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
  // POSTS
  createPost(String userId, Post post) async
  {
    users.doc(userId).update(
      {
        'posts': FieldValue.arrayUnion([post.toJson()]),
      }
    );
    PostService postService = PostService();
    postService.addPostTo(userId, post);

  }
  deletePost(String userId, Map<String, dynamic> post) async{
    users.doc(userId).update({
      "posts": FieldValue.arrayRemove([post])
    });
    PostService postService = PostService();
    postService.deletePost(userId, post);
  }

  likePost(String userId, String otherUserId, int postId) async
  {
    var docRef = await users.doc(otherUserId).get();
    var posts = (docRef.data() as Map<String, dynamic>)["posts"];
    var thePost = posts[0];
    int i = 0;
    for(; i < posts.length ; i++)
      {
        if(postId == posts[i]["postId"])
          {
            thePost = posts[i];
            break;
          }
      }
    if(!thePost["likes"].contains(userId)) {
      thePost["likes"] = thePost["likes"] + [userId];
      posts[i] = thePost;
      users.doc(otherUserId).update({
        "posts": posts
      });
      pushNotifications(userId, otherUserId, " liked your post.");
    }
    else{
      thePost["likes"].remove(userId);
      posts[i] = thePost;
      users.doc(otherUserId).update({
        "posts": posts
      });
    }
    PostService postService = PostService();
    postService.likePost(userId, otherUserId, postId);

  }
  dislikePost(String userId, String otherUserId, int postId) async
  {
    var docRef = await users.doc(otherUserId).get();
    var posts = (docRef.data() as Map<String, dynamic>)["posts"];
    var thePost = posts[0];
    int i = 0;
    for(; i < posts.length ; i++)
    {
      if(postId == posts[i]["postId"])
      {
        thePost = posts[i];
        break;
      }
    }
    PostService postService = PostService();
    postService.dislikePost(userId, otherUserId, postId);
    if(!thePost["dislikes"].contains(userId)) {
      thePost["dislikes"] = thePost["dislikes"] + [userId];
      posts[i] = thePost;
      users.doc(otherUserId).update({
        "posts": posts
      });
      pushNotifications(userId, otherUserId, " disliked your post.");

    }
    else{
      thePost["dislikes"].remove(userId);
      posts[i] = thePost;
      users.doc(otherUserId).update({
        "posts": posts
      });
    }


  }
  Future<void> sendCommendTo(String userId, String otherUserId, int postId, String context) async
  {
    var docRef = await users.doc(otherUserId).get();
    var posts = (docRef.data() as Map<String, dynamic>)["posts"];
    var thePost = posts[0];
    int i = 0;
    for(; i < posts.length ; i++)
    {
      if(postId == posts[i]["postId"])
      {
        thePost = posts[i];
        break;
      }
    }
      thePost["comments"] = thePost["comments"] + [{"senderId": userId, "context": context}];
      posts[i] = thePost;
      users.doc(otherUserId).update({
        "posts": posts
      });
    PostService postService = PostService();
    postService.sendCommendTo(userId, otherUserId, postId,context);
      pushNotifications(userId, otherUserId, " commented on your post.");

  }
  Future<int> getPostCount(String userId) async
  {
    var docRef = await users.doc(userId).get();
    var obj = docRef.data() as Map<String, dynamic>;
    var len = obj["posts"].length;
    return len;
  }
  updatePrivacy(String userId, bool isPrivate) async{
    users.doc(userId).update({
      "isPrivate": isPrivate
    });
  }
}
