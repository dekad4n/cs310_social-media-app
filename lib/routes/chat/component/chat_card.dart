import 'package:flutter/material.dart';
import 'package:sucial_cs310_project/model/Chat.dart';



class Chatcard extends StatelessWidget {
  const Chatcard({
    Key? key,
    required this.chat,
    required this.press,
  }) : super(key: key);
  final Chat chat;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20*0.75),
        child: Row(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundImage: AssetImage(chat.image),
                ),


              ],
            ),
            Expanded(child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(chat.name, style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500
                  ),
                  ),
                  SizedBox(height: 8),
                  Opacity(
                    opacity: 0.64,
                    child: Text(
                      chat.lastMessage,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )

                ],
              ),
            ),
            ),
            Opacity(
                opacity: 0.64,
                child: Text(chat.time)),


          ],
        ),
      ),
    );
  }
}