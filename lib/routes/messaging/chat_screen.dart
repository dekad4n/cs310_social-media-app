import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:sucial_cs310_project/services/message_service.dart';
import 'package:sucial_cs310_project/services/user_service.dart';
import 'package:sucial_cs310_project/utils/colors.dart';
import 'package:sucial_cs310_project/utils/styles.dart';
import 'package:sucial_cs310_project/widgets/navbars.dart';

class ChatScreen extends StatefulWidget {
  String otherUserId;
  ChatScreen({Key? key,required this.otherUserId }) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  MessageService messageService = MessageService();
  UsersService usersService = UsersService();
  String chatId = "";
  final _key = GlobalKey<FormState>();
  String newMsg = "";

  String otherUsername =  "";
  String otherUserPp = "";
  Future<void>? otherUserInfo() async
  {
    otherUsername = await usersService.getUserName(widget.otherUserId);
    otherUserPp = await usersService.getUserPp(widget.otherUserId);

  }

  @override
  void initState()  {
    // TODO: implement initState
    otherUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    return Scaffold(
      appBar: appBarBack(context, "Sucial"),
      body: StreamBuilder(
        stream: messageService.messageReference.doc(user!.uid.compareTo(widget.otherUserId) < 0 ? user.uid+widget.otherUserId: widget.otherUserId+ user.uid
        ).snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<DocumentSnapshot> snapshot)
        {
          if(snapshot.hasData && snapshot.data != null && snapshot.data!.data() != null)
            {
              List textList = (snapshot.data!.data() as Map<String, dynamic>)["texts"];
              // TO DO: ADD A TEXT INPUT FIELD AND SEND MESSAGE
              return FutureBuilder<void>(
                future: otherUserInfo(),
                builder: (context, snapshot) {
                  return SafeArea(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: SingleChildScrollView(
                        reverse: true,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: textList.map((message){
                                  bool amISender = message['sender'] == user.uid;
                                  return Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment:  amISender ? MainAxisAlignment.end: MainAxisAlignment.start,
                                    children: [
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          if(!amISender)
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(4.0, 0.0, 0.0, 1.0),
                                              child: Text(
                                                  otherUsername
                                              ),
                                            ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(8.0,8.0,8.0,2.0),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                if(otherUserPp != "" && !amISender)
                                                  Padding(
                                                    padding: const EdgeInsets.only(right: 8.0),
                                                    child: CircleAvatar(
                                                      child: ClipOval(
                                                        child: Image.network(
                                                          otherUserPp
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                IntrinsicWidth(
                                                  child: Container(
                                                    constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.8),
                                                    child: Padding(
                                                      padding: const EdgeInsets.fromLTRB(8.0,8.0,8.0,6.0),
                                                      child: Text(
                                                        message['msg'],
                                                        style: hintStyleLoginButton,
                                                      ),
                                                    ),
                                                    alignment: amISender ? Alignment.centerRight: Alignment.centerLeft,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(30),
                                                      color: AppColors.backgroundColor,
                                                    ),
                                                  ),
                                                ),

                                              ],
                                            ),
                                          ),

                                        ],
                                      )
                                    ],
                                  );
                                }
                                ).toList()
                            ),
                            Form(
                              key: _key,
                              child: Row(
                                children: [
                                  Expanded(
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                          fillColor: AppColors.backgroundColor,
                                          filled: true,
                                          hintText: 'Write something',
                                          border: const UnderlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(30)
                                            )
                                          ),
                                        ),
                                        onSaved: (value){
                                          if(value != null)
                                            {

                                              newMsg = value;
                                            }
                                        },
                                      ),
                                  ),
                                  IconButton(
                                      onPressed: (){
                                        _key.currentState!.save();
                                        if(newMsg != ""){
                                          // send message
                                          chatId = user.uid.compareTo(widget.otherUserId) < 0 ? user.uid+widget.otherUserId: widget.otherUserId+ user.uid;
                                          _key.currentState!.reset();
                                          messageService.sendMessage(chatId, newMsg, user.uid);
                                        }
                                      },
                                      icon: const Icon(Icons.send)
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
              );
            }

          return const Center(child: CircularProgressIndicator());
        }
        ,
      ),
    );
  }
}
