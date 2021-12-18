import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:sucial_cs310_project/model/user_profile.dart';
import 'package:sucial_cs310_project/services/user_service.dart';
import 'package:sucial_cs310_project/ui/person_card.dart';
import 'package:sucial_cs310_project/widgets/navbars.dart';

class Following extends StatefulWidget {
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;
  String userId;
  UsersService userService = UsersService();
  Following({Key? key, required this.analytics, required this.observer, required this.userId}) : super(key: key);


  @override
  _FollowingState createState() => _FollowingState();
}

class _FollowingState extends State<Following> {


  @override
  Widget build(BuildContext context) {

    return StreamBuilder(
        stream: widget.userService.users.doc(widget.userId).snapshots(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot)
            {
              if(snapshot.hasData)
                {
                  UserProfile userProfile = UserProfile.fromMap(snapshot.data!.data() as Map<String,dynamic>);
                  return Scaffold(
                    appBar: appBarBack(context,"Following"),
                    body: Column(
                      children: userProfile.following.map((otherProfile) =>
                          PersonCard(
                            userProfile: userProfile,
                            otherUser: otherProfile,

                          )
                      ).toList(),
                    )
                  );
                }
              return const Scaffold(body: Center(child: Text("Sth went wrong"),),);
            }
    );

  }
}
