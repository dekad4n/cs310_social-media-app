import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:sucial_cs310_project/model/user_profile.dart';
import 'package:sucial_cs310_project/routes/notification.dart';
import 'package:sucial_cs310_project/routes/user_details/other_user.dart';
import 'package:sucial_cs310_project/services/user_service.dart';
import 'package:sucial_cs310_project/widgets/navbars.dart';
import 'package:sucial_cs310_project/utils/colors.dart';
import 'package:sucial_cs310_project/utils/styles.dart';

class Requests extends StatefulWidget {
  final String userId;
  Requests({Key? key, required this.analytics, required this.observer, required this.userId}) : super(key: key);
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;
  final UsersService userService = UsersService();

  @override
  _RequestsState createState() => _RequestsState();
}

class _RequestsState extends State<Requests> {
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
                backgroundColor: AppColors.backgroundColor,
                appBar: AppBar(
                  title: Text('Follow Request', style: sucialStylemMed),
                  centerTitle: true,
                  backgroundColor: Colors.deepPurple[100],
                  elevation: 0.0,
                  automaticallyImplyLeading: false,
                  iconTheme: IconThemeData(color: AppColors.sucialColor),
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back, color: AppColors.sucialColor),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                body: Column(
                  children: userProfile.requests.map((message) =>
                      requestItem(
                        userProfile: userProfile
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

class requestItem extends StatefulWidget {
  UserProfile userProfile;

  requestItem({Key? key, required this.userProfile,}) : super(key: key);

  @override
  State<requestItem> createState() => _requestItemState();
}

class _requestItemState extends State<requestItem> {
  UsersService userService = UsersService();

  @override
  Widget build(BuildContext context) {
    String userID = widget.userProfile.userId;
    String profilepicture = widget.userProfile.profilepicture;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            child: ClipOval(
              child: Image.network(
                  'https://www.pngall.com/wp-content/uploads/5/User-Profile-PNG-Free-Image.png'),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Flexible(
                    child: TextButton(
                      child: RichText(text: TextSpan(
                          children: [
                            // TextSpan(text: notification.name, style: TextStyle(color: AppColors.sucialColor, fontWeight: FontWeight.bold)),
                            TextSpan(text: userID + " requested to follow you.",
                                style: TextStyle(
                                    color: AppColors.sucialColor)),
                            // TextSpan(text: notification.timeAgo, style: TextStyle(color: AppColors.explanationColor),)
                          ]
                      )),
                      onPressed: () {},
                    )
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
