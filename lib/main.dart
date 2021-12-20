import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sucial_cs310_project/routes/search_page.dart';
import 'package:sucial_cs310_project/routes/feed.dart';
import 'package:sucial_cs310_project/routes/profile_view.dart';
import 'package:sucial_cs310_project/routes/signup_followup.dart';
import 'package:sucial_cs310_project/routes/walkthrough.dart';
import 'package:sucial_cs310_project/routes/login.dart';
import 'package:sucial_cs310_project/routes/signup.dart';
import 'package:sucial_cs310_project/routes/welcome.dart';
import 'package:sucial_cs310_project/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //FirebaseCrashlytics.instance.crash();
  //FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  void initState()
  {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if(snapshot.hasError) {

            return const MaterialApp(
              home: Scaffold(body: Center(child: Text("No FB"))),
            );
          }
          if(snapshot.connectionState == ConnectionState.done) {

            return AppBase();
          }

          return const MaterialApp(
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
        initialRoute: '/welcome',
        routes: {
          '/profile': (context) => ProfileView(analytics: analytics, observer: observer),
          '/walkthrough': (context) => WalkThrough(analytics: analytics, observer: observer),
          '/login': (context) => Login(analytics: analytics, observer: observer),
          '/signup': (context) => Signup(analytics: analytics, observer: observer),
          '/welcome': (context) => Welcome(analytics: analytics, observer: observer),
          '/feed': (context) => FeedView(analytics: analytics, observer: observer),
          '/search_page': (context) => SearchPage2(analytics: analytics, observer: observer),
          '/signup_followup': (context) => SignUpFollowUp(analytics: analytics, observer: observer),
        },

      ),
    );
  }
}
