import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:sucial_cs310_project/routes/requests.dart';
import 'package:sucial_cs310_project/utils/colors.dart';
import 'package:sucial_cs310_project/utils/styles.dart';
import 'package:sucial_cs310_project/model/user_profile.dart';
import 'package:sucial_cs310_project/services/user_service.dart';
import 'package:sucial_cs310_project/widgets/navbars.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';


class Notifications extends StatefulWidget {
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;
  final UsersService userService = UsersService();
  Notifications({Key? key,  required this.analytics, required this.observer}) : super(key: key);
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  UsersService usersService = UsersService();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    if(user != null) {
      return Scaffold(
        body: FutureBuilder<DocumentSnapshot>(
          future: usersService.users.doc(user.uid).get(),
          builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
            if(snapshot.hasError)
            {
              return const Center(child: Text("Refresh the page!"));
            }
            if(snapshot.connectionState == ConnectionState.done)
            {
              UserProfile userProfile = UserProfile.fromMap(snapshot.data!.data() as Map<String,dynamic>);

              return StreamBuilder(

                  stream: widget.userService.users.doc(userProfile.userId).snapshots(),
                  builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot)
                  {
                    if(snapshot.hasData)
                    {
                      UserProfile userProfile = UserProfile.fromMap(snapshot.data!.data() as Map<String,dynamic>);
                      return Scaffold(
                          backgroundColor: AppColors.backgroundColor,
                          appBar: AppBar(
                            title: Text('Notifications', style: sucialStylemMed),
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
                          body: Column(children: [
                            TextButton(
                              style: TextButton.styleFrom(
                                primary: AppColors.sucialColor,
                              ),
                              onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => Requests(analytics: widget.analytics,observer: widget.observer, userId: userProfile.userId)));
                              },
                              child: Row(
                                children: [
                                  Text('Follow Requests', style: smallExplanation),
                                  //const Icon(Icons.arrow_forward, color: AppColors.explanationColor),
                                ],
                              )

                            ),
                            Column(
                              children: userProfile.notifications.map((message) =>
                                  notificationItem(
                                    userProfile: userProfile,
                                    context: message,
                                  )
                              ).toList(),
                            )
                          ]
                          ));
                    }
                    return const Scaffold(body: Center(child: Text("Sth went wrong"),),);
                  }
              );
            }
            return const Center(child: Text('Loading...'),);
          },
        ),
        bottomNavigationBar: bottomNavBar(context),
      );
    }
    else {
      return const Center(child: Text("Refresh the page!"));
    }
  }
}

class notificationItem extends StatefulWidget {
  final UserProfile userProfile;
  final String context;


  notificationItem({Key? key, required this.userProfile, required this.context}) : super(key: key);

  @override
  State<notificationItem> createState() => _notificationItemState();
}

class _notificationItemState extends State<notificationItem> {
  UsersService userService = UsersService();

  @override
  Widget build(BuildContext context) {
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
                              TextSpan(text: widget.context,
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