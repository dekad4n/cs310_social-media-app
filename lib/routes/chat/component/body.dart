import 'package:flutter/material.dart';
import 'package:sucial_cs310_project/components/filled_oytline_button.dart';
import 'package:sucial_cs310_project/model/Chat.dart';
import 'package:sucial_cs310_project/routes/message/message_screen.dart';

import 'package:sucial_cs310_project/utils/colors.dart';

import 'chat_card.dart';

class Body extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Column(
      children: [
        Container(

          color: AppColors.backgroundColor,
          child: Row(

          ),
        ),
      //TODO: burda firebasedeki converstaionların gorunmesi icin gereken kısmı yazmalıyız
      /*Expanded(child: ListView.builder(
      itemCount: chatdata.length,
      itemBuilder: (context, index) => Chatcard(
      chat : chatdata[index],
      press: () => Navigator.push(
      context,
      MaterialPageRoute(
      builder: (context) => MessagesScreen(),
      ),
      ),
      ),
      )

       */

      ],

    );
  }
}