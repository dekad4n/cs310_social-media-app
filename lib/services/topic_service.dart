import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sucial_cs310_project/model/post.dart';


class TopicService{
  final CollectionReference topics = FirebaseFirestore.instance.collection('Topic');

  addToTopic(String topicName,String postID)async{
    final docRef = await topics.doc(topicName).get();
    if(docRef.exists)
    {
      await topics.doc(topicName).update(
          {
            'postIdList': FieldValue.arrayUnion([postID])
          }
      );


    }
    else{
      await topics.doc(topicName).set(
          {
            'postIdList': [postID]
          }
      );
    }

  }






}