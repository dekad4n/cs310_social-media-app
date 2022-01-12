import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sucial_cs310_project/services/message_service.dart';
import 'package:sucial_cs310_project/services/user_service.dart';
import 'package:sucial_cs310_project/ui/dm_card.dart';
import 'package:sucial_cs310_project/widgets/navbars.dart';


class AllMessages extends StatefulWidget {
  const AllMessages({Key? key}) : super(key: key);

  @override
  _AllMessagesState createState() => _AllMessagesState();
}

class _AllMessagesState extends State<AllMessages> {
  MessageService messageService = MessageService();
  UsersService usersService = UsersService();
  // TO DO: DO IT WITH FIREBASE
  // IDEA 1 : ADD "chats" part to user.




  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    return StreamBuilder(
      stream: messageService.messageReference.snapshots().asBroadcastStream(),
      builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot> snapshot) {
        if(snapshot.data != null) {
          return Scaffold(
            appBar: appBarNewMessage(context),
            body: SingleChildScrollView(
              child: Column(
                  children: List.from(snapshot.data!.docs.where((element) =>
                      element["chatters"].contains(user!.uid)
                  ).map((chat) {
                    String firstChatter = chat["chatters"][0];
                    String secondChatter = chat["chatters"][1];
                    String otherChatter = firstChatter == user!.uid
                        ? secondChatter
                        : firstChatter;
                    String bigger = otherChatter + user.uid;

                    if (user.uid.compareTo(otherChatter) < 0) {
                      bigger = user.uid + otherChatter;
                    }
                    return DmCard(userId: otherChatter, chatId: bigger);
                  }
                  ).toList().reversed)
              ),
            ),

          );
        }
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }
    );
  }
}
