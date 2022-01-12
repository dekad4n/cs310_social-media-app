import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MessageService{

  final CollectionReference messageReference = FirebaseFirestore.instance.collection('chats');


  createMessage(String crrUser, String otherUser) async{
    String bigger = otherUser+crrUser;

    if(crrUser.compareTo(otherUser) < 0) {
      bigger = crrUser + otherUser;
    }
    DocumentSnapshot ds = await messageReference.doc(bigger).get();
    if(!ds.exists) {
      await messageReference.doc(bigger
      ).set(
          {
            'texts': [],
            'chatters': [
              crrUser,
              otherUser
            ]
          }
      );
    }
  }
  // Send Message
  Future<void> sendMessage(String chatId, String message, String sender) async
  {
    await messageReference.doc(chatId).update({
      'texts': FieldValue.arrayUnion([
        {
          'msg' : message,
          'sender' : sender
        }
      ])
    });
  }
  Future<String> getLastMessage(String chatId) async
  {
    final chat = await messageReference.doc(chatId).get();
    List<dynamic> texts = (chat.data() as Map<String,dynamic>)["texts"];
    String lastMessage = texts[texts.length-1]["msg"];
    return lastMessage;
  }

}