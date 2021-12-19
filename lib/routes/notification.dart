import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sucial_cs310_project/model/notificationitem.dart';
import 'package:sucial_cs310_project/utils/colors.dart';
import 'package:sucial_cs310_project/utils/styles.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {

  List<dynamic> notifications = [];

  Future<void> readJson() async {
    final String response = await rootBundle.loadString(
        'assets/notifications.json');
    final data = await json.decode(response);

    setState(() {
      notifications = data['notifications']
          .map((data) => NotificationItem.fromJson(data)).toList();
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readJson();
  }

  @override
  Widget build(BuildContext context) {
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
      body: ListView.builder(
          physics: ClampingScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: notifications.length,
          itemBuilder: (context, index){
            return Container(
              child: notificationItem(notifications[index]),
            );
          },
      ),
    );
  }
  notificationItem(NotificationItem notification) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            child:ClipOval(
              child: Image.network('https://www.pngall.com/wp-content/uploads/5/User-Profile-PNG-Free-Image.png'),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Flexible(
                  child: TextButton(
                    child: RichText(text: TextSpan(
                        children: [
                          TextSpan(text: notification.name, style: TextStyle(color: AppColors.sucialColor, fontWeight: FontWeight.bold)),
                          TextSpan(text: notification.content, style: TextStyle(color: AppColors.sucialColor)),
                          TextSpan(text: notification.timeAgo, style: TextStyle(color: AppColors.explanationColor),)
                        ]
                    )),
                  onPressed: (){},
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