import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:sucial_cs310_project/services/analytics.dart';
import 'package:sucial_cs310_project/services/auth.dart';
import 'package:sucial_cs310_project/services/user_service.dart';

class FeedView extends StatefulWidget {
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;
  FeedView({Key? key, required this.analytics, required this.observer}) : super(key: key);
  @override
  _FeedViewState createState() => _FeedViewState();
}

class _FeedViewState extends State<FeedView> {
  final AuthService _auth = AuthService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setCurrentScreen(widget.analytics, 'Init Feed View Page', 'feed.dart');
  }
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: Center(child: OutlinedButton(
        onPressed: ()
        {
          _auth.signOut();
          Navigator.pushNamed(context, "/login");
        },
        child: const Text("Sign Out")
      )),
    );
  }
}
