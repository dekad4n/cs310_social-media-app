import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sucial_cs310_project/model/user_profile.dart';
import 'package:sucial_cs310_project/routes/messaging/chat_screen.dart';
import 'package:sucial_cs310_project/services/message_service.dart';
import 'package:sucial_cs310_project/services/user_service.dart';
import 'package:sucial_cs310_project/utils/styles.dart';


class DmCard extends StatefulWidget {
  String userId;
  String chatId;
  DmCard({Key? key, required this.userId, required this.chatId} ) : super(key: key);

  @override
  State<DmCard> createState() => _DmCardState();
}

class _DmCardState extends State<DmCard> {
  MessageService messageService = MessageService();

  UsersService usersService = UsersService();

  String profilePicture = "";

  String userName = "";

  String lastMessage = "";

  Future<void> getLastMessage() async
  {
    lastMessage = await messageService.getLastMessage(widget.chatId);


  }

  @override
  Widget build(BuildContext context) {
    getLastMessage();
    return FutureBuilder(
      future: usersService.users.doc(widget.userId).get(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
        if(snapshot.connectionState == ConnectionState.done) {
          UserProfile userProfile = UserProfile.fromMap((snapshot.data!.data() ?? Map<String,dynamic>.identity()) as Map<String,dynamic>);
          profilePicture = userProfile.profilepicture;
          userName = userProfile.username;
          return SafeArea(
              child: InkWell(
                child: Card(
                  child: Row(
                    children: [
                      CircleAvatar(
                        child: ClipOval(
                          child: Image.network(
                            profilePicture,
                            width: 150,
                            fit: BoxFit.cover,
                            height: 150,
                          ),

                        ),
                        radius: 37.5,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userName,
                              style: personCardStyleBold,
                            ),
                            Text(
                              lastMessage,
                              style: personCardStyle,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChatScreen(otherUserId: widget.userId))
                  );
                },
              )
          );
        }
        return const Text("Loading...");
      }
    );
  }
}
