import 'package:flutter/material.dart';
import 'package:sucial_cs310_project/utils/colors.dart';

import 'component/body.dart';

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
                "Sadi Gulbey",
                 style: TextStyle(fontSize: 16),
              ),
              Text(
                "Active 3m ago",
                style: TextStyle(fontSize: 12),
              )

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