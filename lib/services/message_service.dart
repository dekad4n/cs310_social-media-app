import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sucial_cs310_project/model/Chat.dart';

// send message yapmak icin burdan fonksiyon kullanıcaz
class messageService {
  final CollectionReference messageReference = FirebaseFirestore.instance
      .collection('chats');


  addConv(String userId, Chat chat) async
  {
    messageReference.doc(userId + chat.chatId.toString()).set(
        chat.toJson()
    );
  }




  createMessage(String user, String otherUser) async
  {


    await messageReference.doc(user).set({
      'text': []
    });

    await messageReference.doc(otherUser).set({
      'text': []
    });
  }

  sendMessage(String userid, String otherUser, String text) {

    messageReference.doc(userid).update({
      'text': FieldValue.arrayUnion([text]),
    });
    messageReference.doc(otherUser).update({
      'text': FieldValue.arrayUnion([text]),
    });
  }

  getMessage(String userid, String otherUser, String text) {
    messageReference.doc(otherUser).update({
      'text': FieldValue.arrayUnion([text]),
    });

    messageReference.doc(userid).update({
      'text': FieldValue.arrayUnion([text]),
    });
  }

}






