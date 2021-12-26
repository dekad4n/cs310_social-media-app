
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:sucial_cs310_project/help/constans.dart';
import 'package:sucial_cs310_project/help/helpfnc.dart';
import 'package:sucial_cs310_project/routes/chat/component/body.dart';
import 'package:sucial_cs310_project/routes/message/message_screen.dart';
import 'package:sucial_cs310_project/services/message_service.dart';
import 'package:sucial_cs310_project/utils/colors.dart';

class ChatsScreen extends StatefulWidget{
   final FirebaseAnalytics analytics;
   final FirebaseAnalyticsObserver observer;
  const ChatsScreen({Key? key, required this.analytics, required this.observer}) : super(key: key);
  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}
getChatBoxId(String a, String b) {
  if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
    return "$b\_$a";
  } else {
    return "$a\_$b";
  }
}

@override
createChatBoxS(BuildContext context,String userName,QuerySnapshot search){
  if(userName != Constants.myName){
    String chatBoxId = getChatBoxId(userName, Constants.myName);
    List<String> users = [userName, Constants.myName];
    Map<String, dynamic> chatBoxMap = {
      "users" : users,
      "chatboxid": chatBoxId,
    };
    messageService().createChatBox(chatBoxId,chatBoxMap);
    Navigator.push(context, MaterialPageRoute(
        builder: (context) =>MessagesScreen()));
  }
  else
    {
      print("You cannot send message to yourself");
    }


}

class _ChatsScreenState extends State<ChatsScreen> {
  @override
  void initState(){
    getUserInfo();
    super.initState();
  }

  getUserInfo() async {
    Constants.myName = await HelperFunctions.getUserNameSharedPreference() as String;
    setState(() {
    });

  }

  int _selectedIndex=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Body(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        backgroundColor: AppColors.backgroundColor,
      child: Icon(
          Icons.person_add_alt_1),
      ),
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  BottomNavigationBar buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _selectedIndex,
        onTap: (value){
        setState(() {
          _selectedIndex=value;

        });
        },
        items:[
          BottomNavigationBarItem(
              icon: Icon(Icons.messenger,color: AppColors.backgroundColor,),
              label : "Chats"),
          BottomNavigationBarItem(
              icon: Icon(Icons.people, color: AppColors.backgroundColor,),
              label : "People"),
          BottomNavigationBarItem(
              icon: Icon(Icons.call, color: AppColors.backgroundColor,),
              label : "Call",
          ),
          BottomNavigationBarItem(

            icon: CircleAvatar(
              radius: 14,
              backgroundImage: AssetImage("assets/gandi.jpg"),),
              label : "Profile",
          ),
        ],
      selectedItemColor: Colors.blueGrey,

    );
  }

  AppBar buildAppBar(){
    return AppBar(
      backgroundColor: AppColors.backgroundColor,
      automaticallyImplyLeading: false,
      title: Text("Chats"),
      actions: [
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {},
        ),
      ],
    );
  }
}