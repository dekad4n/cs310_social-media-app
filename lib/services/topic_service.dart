
import 'package:cloud_firestore/cloud_firestore.dart';

class TopicService{
  CollectionReference topics = FirebaseFirestore.instance.collection("Topic");

  Future<void> addToTopic(String topicName, String postId) async
  {
    DocumentSnapshot ds = await topics.doc(topicName).get();
    if(ds.exists){
      topics.doc(topicName).update(
          {
            'postIdList': FieldValue.arrayUnion([postId])
          }
      );
    }
    else{
      topics.doc(topicName).set(
        {
          'postIdList': [postId],
          'subscribed': [],
          'topicName': topicName
        }
      );
    }
  }

  Future<void> subscribeToTopic(String topicName, String userId) async{
      topics.doc(topicName).update(
        {
          'subscribed': FieldValue.arrayUnion([userId])
        }
      );
    }
    Future<void> unsubscribeFromTopic(String topicName, String userId) async {
      topics.doc(topicName).update(
          {
            'subscribed': FieldValue.arrayRemove([userId])
          }
      );
    }
    Future<void> getTopicPosts(String userId) async{
      final QuerySnapshot result = await topics
          .where('topic', arrayContains: userId).get();
      final List<DocumentSnapshot> documents = result.docs;
      for(int i = 0 ; i <documents.length ; i++)
        {
          
        }

    }

}