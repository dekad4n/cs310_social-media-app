
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
  Future<void> disablePost(String postId) async
  {
    posts.doc(postId).update(
        {
          'isDisabled': true
        }
    );
  }
  Future<void> enablePost(String postId) async
  {
    posts.doc(postId).update(
        {
          'isDisabled': false
        }
    );
  }
  Future<void> sendCommendTo(String userId, String otherUserId, int postId, String context) async
  {
    posts.doc(otherUserId + postId.toString()).update({
      "comments": FieldValue.arrayUnion([{"senderId":  userId, "context": context}])
    });

  }
  Future<void> editPost(String postId, String text) async{
    posts.doc(postId).update({
      'text': text
    });
  }

  Future<void> editTopic(String postId, String text) async{ //BU eklendi User servicele birlikte calisan bir sey olması lzm
    posts.doc(postId).update({
      'Topic': text
    });
  }

  deletePost(String userId, Map<String, dynamic> post) async{
    posts.doc(userId + post["postId"].toString()).delete();
  }
  getPosts(String topicName) async
  {
    final QuerySnapshot result = await posts
        .where('topic', isEqualTo: topicName).get();
    final List<DocumentSnapshot> documents = result.docs;
    return documents;
  }


}