import 'package:flutter/material.dart';
import 'package:sucial_cs310_project/routes/walkthrough.dart';
import 'package:sucial_cs310_project/routes/login.dart';
import 'package:sucial_cs310_project/routes/signup.dart';
import 'package:sucial_cs310_project/routes/welcome.dart';


void main() {

  runApp(MaterialApp(
    initialRoute: '/welcome',
    routes: {
        '/walkthrough': (context) => WalkThrough(),
        '/login': (context) => Login(),
        '/signup': (context) => Signup(),
        '/welcome': (context) => Welcome(),
      },

  ));
}