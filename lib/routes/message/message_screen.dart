import 'package:flutter/material.dart';
import 'package:sucial_cs310_project/utils/colors.dart';

import 'component/body.dart';
//TODO: usera tıkladıgında bu sayfa acılmalı
class MessagesScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Body(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: AppColors.backgroundColor,
      title: Row(
        children: [
          BackButton(),
          CircleAvatar(backgroundImage: AssetImage("assets/logo.jpg"),
          ),
          SizedBox(width: 20*0.75),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Sadi Gulbey", // tıklanan userın adı olcak firebaseden gelcek buralar
                 style: TextStyle(fontSize: 16),
              ),


            ],
          )
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.local_phone),
          onPressed: () {  },
        ),
        IconButton(
          icon: Icon(Icons.videocam),
          onPressed: () {},
        ),
        SizedBox(width: 10,)
      ],
    );
  }
}