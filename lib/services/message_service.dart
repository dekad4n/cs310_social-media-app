import 'package:cloud_firestore/cloud_firestore.dart';

class MessageService{

  final CollectionReference messageReference = FirebaseFirestore.instance.collection('messages');


  createMessage(String crrUser, String otherUser) async{
    await messageReference.doc(crrUser).set({
      'text': []
    });
    await messageReference.doc(otherUser).set({
      'text': []
    });
  }

}