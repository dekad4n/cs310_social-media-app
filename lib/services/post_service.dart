
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sucial_cs310_project/model/post.dart';
import 'package:sucial_cs310_project/services/user_service.dart';

class PostService{
  final CollectionReference posts = FirebaseFirestore.instance.collection('Posts');

  addPostTo(String userId, Post post) async
  {
    posts.doc(userId + post.postId.toString()).set(
      post.toJson()
    );
  }
  likePost(String userId, String otherUserId, int postId) async
  {
    var docRef = await posts.doc(otherUserId+ postId.toString()).get() ;

    if(!docRef["likes"].contains(userId)) {
      posts.doc(otherUserId+ postId.toString()).update({
        "likes": FieldValue.arrayUnion([userId])
      });

    }
    else{
      posts.doc(otherUserId+ postId.toString()).update({
        "likes": FieldValue.arrayRemove([userId])
      });
    }

  }
  dislikePost(String userId, String otherUserId, int postId) async
  {
    var docRef = await posts.doc(otherUserId+ postId.toString()).get();

    if(!docRef["dislikes"].contains(userId)) {
      posts.doc(otherUserId+ postId.toString()).update({
        "dislikes": FieldValue.arrayUnion([userId])
      });
    }
    else{
      posts.doc(otherUserId+ postId.toString()).update({
        "dislikes": FieldValue.arrayRemove([userId])
      });
    }
  }
  Future<void> sendCommendTo(String userId, String otherUserId, int postId, String context) async
  {
    var docRef = await posts.doc(otherUserId + postId.toString()).get();
    posts.doc(otherUserId).update({
      "comments": FieldValue.arrayUnion([{"senderId":  userId, "context": context}])
    });

  }
  deletePost(String userId, Map<String, dynamic> post) async{
    posts.doc(userId + post["postId"]).delete();
  }

}