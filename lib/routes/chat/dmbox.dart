


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sucial_cs310_project/model/Chat.dart';
import 'package:sucial_cs310_project/model/user_profile.dart';
import 'package:sucial_cs310_project/routes/message/message_screen.dart';
import 'package:sucial_cs310_project/routes/user_details/other_user.dart';
import 'package:sucial_cs310_project/services/analytics.dart';
import 'package:sucial_cs310_project/services/message_service.dart';
import 'package:sucial_cs310_project/services/user_service.dart';
import 'package:sucial_cs310_project/utils/colors.dart';
import 'package:sucial_cs310_project/widgets/navbars.dart';
import 'package:sucial_cs310_project/routes/chat/component/body.dart';

import '../search_page.dart';

class ChatsScreen extends StatefulWidget{
  final UsersService userService = UsersService();
  final messageService messagesService =  messageService();
   final FirebaseAnalytics analytics;
   final FirebaseAnalyticsObserver observer;
   ChatsScreen({Key? key, required this.analytics, required this.observer}) : super(key: key);
  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}
class _ChatsScreenState extends State<ChatsScreen> {
  UsersService usersService = UsersService();
  messageService messageservice =  messageService();
  int _selectedIndex=0;
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User?>(context);

    return Scaffold(
      appBar: buildAppBar(),

      body: Body(),
      //TODO: bunu bodyde yapcaz streambuilder eklemeliyiz ve son gonderilen basta aynı notf gibi, ve burdan tıkladıgımızda message screen acılcak
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => SearchPage2(analytics: widget.analytics, observer: widget.observer)));

        },
        backgroundColor: AppColors.backgroundColor,
      child: Icon(
          Icons.person_add_alt_1),
      ),
      bottomNavigationBar: bottomNavBar(context),
    );
  }

  AppBar buildAppBar(){
    return AppBar(
      backgroundColor: AppColors.backgroundColor,
      automaticallyImplyLeading: false,
      title: Text("Chats"),

    );
  }
}

