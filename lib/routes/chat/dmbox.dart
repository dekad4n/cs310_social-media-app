
import 'package:flutter/material.dart';
import 'package:sucial_cs310_project/routes/chat/component/body.dart';
import 'package:sucial_cs310_project/utils/colors.dart';

class ChatsScreen extends StatefulWidget{
  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
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