import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sucial_cs310_project/model/post.dart';
import 'package:sucial_cs310_project/services/analytics.dart';
import 'package:sucial_cs310_project/services/auth.dart';
import 'package:sucial_cs310_project/services/user_service.dart';
import 'package:sucial_cs310_project/ui/post_tile.dart';
import 'package:sucial_cs310_project/widgets/navbars.dart';

import 'login.dart';

class FeedView extends StatefulWidget {
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;
  FeedView({Key? key, required this.analytics, required this.observer}) : super(key: key);
  @override
  _FeedViewState createState() => _FeedViewState();
}

class _FeedViewState extends State<FeedView> {
  UsersService usersService = UsersService();
  final AuthService _auth = AuthService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setCurrentScreen(widget.analytics, 'Init Feed View Page', 'feed.dart');
  }
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    if(user != null) {
      return Scaffold(
        appBar: appBarDefault(context),
        body: FutureBuilder<DocumentSnapshot>(
            future: usersService.users.doc(user.uid).get(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
            if(snapshot.hasError)
            {
            return const Center(child: Text("Refresh the page!"));
            }
            if(snapshot.connectionState == ConnectionState.done)
            {
              List<dynamic> following = (snapshot.data!.data() as Map<String,dynamic>)["following"];
              return StreamBuilder<QuerySnapshot>(
                  stream: usersService.users.snapshots().asBroadcastStream(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> querySnapshot)  {
                    if(querySnapshot.hasData)
                      {
                        List<dynamic> posts = [];
                        for(int i = 0 ; i < following.length ; i++)
                        {
                          posts = posts +querySnapshot.data!.docs.where(
                                  (QueryDocumentSnapshot<Object?> element) =>
                                  following.contains(element["userId"])
                          ).map((data) => (data["posts"])).toList()[0];
                        }
                        return SingleChildScrollView(
                            child: Column(
                              children: posts.map(
                                      (post) => PostTile(
                                        post: Post.fromMap(post),
                                        isOther: true,
                                        delete: ()
                                        {
                                          setState(() {
                                            usersService.deletePost(user.uid, post);
                                            //myPosts.remove(post);
                                          });
                                        },
                                        incrementLike:() async{
                                            // TO DO: PUSH NOTIFICATION
                                            usersService.likePost(user.uid, post["userId"], post["postId"]);
                                        },
                                        incrementComment: (){
                                          setState((){
                                          });
                                        },
                                        incrementDislike: (){
                                          usersService.dislikePost(user.uid,post["userId"], post["postId"]);
                                        }
                                  )
                              ).toList(),
                            )
                        );
                      }
                    return const Center(child: CircularProgressIndicator());

                  }
                  );
            }
            return const Center(child: CircularProgressIndicator());
            }
        ),


        bottomNavigationBar: bottomNavBar(context),
      );
    }
    return Login(analytics: widget.analytics,observer: widget.observer,);
  }
}
