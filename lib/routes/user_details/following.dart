import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:sucial_cs310_project/model/user_profile.dart';
import 'package:sucial_cs310_project/services/user_service.dart';
import 'package:sucial_cs310_project/ui/person_card.dart';
import 'package:sucial_cs310_project/widgets/navbars.dart';

class Following extends StatefulWidget {
  final UserProfile userProfile;
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;
  UsersService userService = UsersService();
  Following({Key? key, required this.analytics, required this.observer,required this.userProfile}) : super(key: key);


  @override
  _FollowingState createState() => _FollowingState();
}

class _FollowingState extends State<Following> {
  List<UserProfile> tempList = [
    UserProfile(username: "sadiglby", fullName: "Sadi Gulbey", profilepicture: "https://firebasestorage.googleapis.com/v0/b/sucial-ff03d.appspot.com/o/user%2Fprofile%2FprofilePic%2F1uOGFoOJWBR9xz4ojGFnkzPLYCH2?alt=media&token=a8d373a9-dbce-4d70-bd9b-65b7d9c9afe3", userId: "d", biography: "s", followers: [], following: [], followerCount: 1, followingCount: 1),
    UserProfile(username: "sadigul", fullName: "Sadi Gulbey", profilepicture: "https://firebasestorage.googleapis.com/v0/b/sucial-ff03d.appspot.com/o/user%2Fprofile%2FprofilePic%2F1uOGFoOJWBR9xz4ojGFnkzPLYCH2?alt=media&token=a8d373a9-dbce-4d70-bd9b-65b7d9c9afe3", userId: "d", biography: "s", followers: [], following: [], followerCount: 1, followingCount: 1),
  ];
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: appBarBack(context,"Following"),
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
