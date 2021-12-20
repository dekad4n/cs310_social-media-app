
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:sucial_cs310_project/routes/user_details/other_user.dart';
import 'package:sucial_cs310_project/utils/colors.dart';


class SearchCard extends StatelessWidget {
  final String username;
  final String profilePic;
  final String userId;
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;
  const SearchCard({Key? key,required this.analytics, required this.observer, required this.username, required this.profilePic, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: (){
        // TO DO : GO TO THAT PROFILE
        Navigator.push(context, MaterialPageRoute(builder: (context) => OtherUser(analytics: analytics, observer: observer, otherUserId: userId,)));
      },
      child: Card(
        color: AppColors.backgroundColor,
        elevation: 0,
        borderOnForeground: false,
        child: Row(
          children: [
            CircleAvatar(
              radius: 17.5,
              child: ClipOval(
                child: Image.network(
                    profilePic,
                  width: 35,
                  height: 35,
                  fit: BoxFit.cover
                ),
              ),
            ),
            const SizedBox(width: 16,),
            Text(username)
          ],
        ),
      ),
    );
  }
}
