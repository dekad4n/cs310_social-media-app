import 'package:flutter/material.dart';
import 'package:sucial_cs310_project/services/auth.dart';

class FeedView extends StatefulWidget {

  @override
  _FeedViewState createState() => _FeedViewState();
}

class _FeedViewState extends State<FeedView> {
  AuthService _auth = AuthService();
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
