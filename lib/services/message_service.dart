import 'package:cloud_firestore/cloud_firestore.dart';


class messageService
{
  final CollectionReference messageReference = FirebaseFirestore.instance.collection('messages');

  createMessage(String user, String otherUser) async
  {
    await messageReference.doc(user).set({
      'text': []
    });

    await messageReference.doc(otherUser).set({
      'text':[]
    });
  }

  sendMessage(String userid, String otherUser, String text){
    messageReference.doc(userid).update({
      'text': FieldValue.arrayUnion([text]),
    });
    messageReference.doc(otherUser).update({
      'text' : FieldValue.arrayUnion([text]),
    });
  }
  getMessage(String userid, String otherUser, String text){
    messageReference.doc(otherUser).update({
      'text' : FieldValue.arrayUnion([text]),
    });

    messageReference.doc(userid).update({
      'text': FieldValue.arrayUnion([text]),
    });

  }

  createChatBox(String chatId, chatBMap){
    FirebaseFirestore.instance.collection("ChatBox")
        .doc(chatId).set(chatBMap).catchError((e){
          print(e.toString());

    });
  }
}