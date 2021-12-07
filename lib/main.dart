import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sucial_cs310_project/routes/feed.dart';
import 'package:sucial_cs310_project/routes/walkthrough.dart';
import 'package:sucial_cs310_project/routes/login.dart';
import 'package:sucial_cs310_project/routes/signup.dart';
import 'package:sucial_cs310_project/routes/welcome.dart';
import 'package:sucial_cs310_project/services/auth.dart';
import 'package:provider/provider.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if(snapshot.hasError) {
            print('Cannot connect to firebase: '+snapshot.error.toString());
            return MaterialApp(
              home: Scaffold(body: Center(child: Text("No FB"))),
            );
          }
          if(snapshot.connectionState == ConnectionState.done) {
            print('Firebase connected');
            return AppBase();
          }

          return MaterialApp(
            home: Scaffold(body: Center(child: Text("Loading"))),
          );
        }
    );
  }
}

class AppBase extends StatelessWidget {

  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<User?>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        navigatorObservers: <NavigatorObserver>[observer],
        initialRoute: '/login',
        routes: {
          '/walkthrough': (context) => WalkThrough(),
          '/login': (context) => Login(),
          '/signup': (context) => Signup(),
          '/welcome': (context) => Welcome(),
          '/feed': (context) => FeedView(),
        },

      ),
    );
  }
}
