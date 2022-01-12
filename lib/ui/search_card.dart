
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sucial_cs310_project/routes/messaging/chat_screen.dart';
import 'package:sucial_cs310_project/routes/user_details/other_user.dart';
import 'package:sucial_cs310_project/services/message_service.dart';
import 'package:sucial_cs310_project/utils/colors.dart';


class SearchCard extends StatelessWidget {
  final String username;
  final String profilePic;
  final String userId;
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;
  final bool isMessage;
  const SearchCard({Key? key,required this.analytics, required this.observer, required this.username, required this.profilePic, required this.userId,required this.isMessage }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    return OutlinedButton(
      onPressed: (){
        // TO DO : GO TO THAT PROFILE
        if(!isMessage) {
          Navigator.push(context, MaterialPageRoute(builder: (context) =>
              OtherUser(analytics: analytics,
                observer: observer,
                otherUserId: userId,)));
        }
        else{
          // TO DO : GO TO MESSAGE SCREEN
          MessageService().createMessage(user!.uid, userId);
          Navigator.push(context, 
              MaterialPageRoute(
                  builder: (context) =>
                      ChatScreen(otherUserId: userId)
              )
          );
        }
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
