import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:sucial_cs310_project/model/user_profile.dart';
import 'package:sucial_cs310_project/services/user_service.dart';
import 'package:sucial_cs310_project/ui/person_card.dart';
import 'package:sucial_cs310_project/widgets/navbars.dart';



class Followers extends StatefulWidget {
  final UserProfile userProfile;
  Followers({Key? key, required this.analytics, required this.observer, required this.userProfile}) : super(key: key);
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;
  final UsersService userService = UsersService();
  @override
  _FollowersState createState() => _FollowersState();
}

class _FollowersState extends State<Followers> {
  List<UserProfile> tempList = [
    UserProfile(username: "newuser", fullName: "ss", profilepicture: "https://firebasestorage.googleapis.com/v0/b/sucial-ff03d.appspot.com/o/user%2Fprofile%2FprofilePic%2FOZiKhZpDZmNA3yVFv2S5UZrdssE3?alt=media&token=92510a48-97aa-414c-a388-5a6c06a13c1a", userId: "OZiKhZpDZmNA3yVFv2S5UZrdssE3", biography: "", followers: [], following: [], followerCount: 0, followingCount: 0),
    UserProfile(username: "newuser", fullName: "ss", profilepicture: "https://firebasestorage.googleapis.com/v0/b/sucial-ff03d.appspot.com/o/user%2Fprofile%2FprofilePic%2FOZiKhZpDZmNA3yVFv2S5UZrdssE3?alt=media&token=92510a48-97aa-414c-a388-5a6c06a13c1a", userId: "OZiKhZpDZmNA3yVFv2S5UZrdssE3", biography: "", followers: [], following: [], followerCount: 0, followingCount: 0),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarBack(context,"Followers"),
      body: Column(
        children: tempList.map((otherProfile) =>
      PersonCard(
      userProfile: widget.userProfile,
      otherUser: otherProfile,
      followButtonCallback: (){
        bool doIFollow  = widget.userProfile.following.contains(otherProfile.userId);
        if(doIFollow)
        {
          setState(() {
            widget.userService.unFollow(widget.userProfile,otherProfile);
            doIFollow = false;
          });
        }
        else
        {
          setState(() {
            widget.userService.followSomeBody(widget.userProfile,otherProfile);
            doIFollow = true;
          });
        }
      },
      text: widget.userProfile.following.contains(otherProfile.userId) ? "Unfollow" : "Follow",
    )
    ).toList(),
      )
    );
  }
}
