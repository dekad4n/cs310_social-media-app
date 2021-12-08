import 'package:firebase_analytics/firebase_analytics.dart';

setLogEvent(FirebaseAnalytics analytics, String name)
{
  analytics.logEvent(
    name: name,
    parameters: <String, dynamic>{
      'string': 'a string',
      'int': 14
    }
  );
}

setCurrentScreen(FirebaseAnalytics analytics, String screenName, String screenClass)
{
  analytics.setCurrentScreen(
    screenName: screenName,
    screenClassOverride: screenClass,
  );
}
setuserId(FirebaseAnalytics analytics, String userID)
{
  analytics.setUserId(userID);
}