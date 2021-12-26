import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sucial_cs310_project/model/ChatMessage.dart';
import 'package:sucial_cs310_project/routes/message/component/text.dart';
import 'package:sucial_cs310_project/routes/message/component/video.dart';
import 'package:sucial_cs310_project/utils/colors.dart';

import 'package:sucial_cs310_project/utils/dimensions.dart';

import 'audio.dart';
import 'chatinput.dart';

class Body extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView.builder(
            itemCount: demeChatMessages.length,
            itemBuilder: (context,index)=> Message(message: demeChatMessages[index]),
          ),
        ),
        ),
        Chatinputfield(),
      ],
    );
  }
}

class Message extends StatelessWidget{
  const Message({
     Key? key,
     required this.message,
}): super(key: key);

  final ChatMessage message;

  @override
  Widget build(BuildContext context)
  {
    Widget messageContaint( ChatMessage message)
    {
      switch (message.messageType)
      {
        case ChatMessageType.text:
          return TextMessage(message: message);
          break;
        case ChatMessageType.audio:
          return AudioMessage(message: message);
          break;
        case ChatMessageType.audio:
          return VideoMessage();
          break;
        default:
          return SizedBox();

      }

    }
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment:
        message.isSender ? MainAxisAlignment.end: MainAxisAlignment.start,
        children: [
          if(!message.isSender)
            ...[
              CircleAvatar(
                  radius: 12,
               backgroundImage: AssetImage("assets/logo.jpg"),
              ),
              SizedBox(width: 10,)

            ],
          messageContaint(message),
          if(message.isSender) MessageStatusDot(status: message.messageStatus,)
        ],
      ),
    );
  }
}

class MessageStatusDot extends StatelessWidget{
  final MessageStatus status;
  const MessageStatusDot({Key? key, required this.status}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Color? dotColor( MessageStatus status){
      switch(status)
      {
        case MessageStatus.not_sent:
           return Colors.red;
           break;
        case MessageStatus.not_view:
          return Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.1);
          break;
        case MessageStatus.viewed:
          return AppColors.backgroundColor;
          break;
        default:
          return Colors.transparent;
      }
    }
    return Container(
      margin: EdgeInsets.only(left: 10 ),
      height: 12,
      width: 12,
      decoration: BoxDecoration(
        color: dotColor(status),
        shape: BoxShape.circle,
      ),
      child: Icon(
          status== MessageStatus.not_sent ? Icons.close: Icons.done,
      size: 8,
      color: Theme.of(context).scaffoldBackgroundColor,
      ),

    );

  }
}













