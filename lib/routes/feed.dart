import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sucial_cs310_project/model/post.dart';
import 'package:sucial_cs310_project/routes/comments.dart';
import 'package:sucial_cs310_project/routes/user_details/disabled_screen.dart';
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
  bool disabled = false;

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
        appBar: !disabled ? appBarDefault(context): null,
        body: FutureBuilder<DocumentSnapshot>(
            future: usersService.users.doc(user.uid).get(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
            if(snapshot.hasError)
            {
            return const Center(child: Text("Refresh the page!"));
            }
            if(snapshot.connectionState == ConnectionState.done && snapshot.hasData && snapshot.data != null && snapshot.data!.data() != null)
            {
              bool isDisabled = ((snapshot.data!.data() ?? Map<String,dynamic>.identity()) as Map<String,dynamic>) ["isDisabled"] ?? false;
              disabled = isDisabled;
              if(!isDisabled) {
                List<dynamic> following = (snapshot.data!.data() as Map<
                    String,
                    dynamic>)["following"];
                var uname = (snapshot.data!.data() as Map<
                    String,
                    dynamic>)["username"];
                return StreamBuilder<QuerySnapshot>(
                    stream: usersService.users.snapshots().asBroadcastStream(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> querySnapshot) {
                      if (querySnapshot.hasData) {
                        List<dynamic> posts = [];

                        for (int i = 0; i < following.length; i++) {
                          posts = posts + querySnapshot.data!.docs.where(
                                  (QueryDocumentSnapshot<Object?> element) {
                                return ((following.contains(element["userId"])) && !element["isDisabled"]);
                              }
                          ).map((data) => (data["posts"])).toList();
                          posts = posts.isNotEmpty? posts[0] : posts;
                        }
                        return SingleChildScrollView(
                            child: Column(
                              children: List.from(posts.map(
                                      (post) =>
                                      PostTile(
                                        post: Post.fromMap(post),
                                        isOther: true,
                                        delete: () {
                                          setState(() {
                                            usersService.deletePost(
                                                user.uid, post);
                                            //myPosts.remove(post);
                                          });
                                        },
                                        incrementLike: () async {
                                          usersService.likePost(
                                              user.uid, post["userId"],
                                              post["postId"]);
                                        },
                                        incrementComment: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      CommentsView(
                                                          userId: user.uid,
                                                          otherUserId: post["userId"],
                                                          postId: post["postId"]
                                                      )
                                              )
                                          );
                                        },
                                        sharePost: ()async{
                                          final postCount = await usersService.getPostCount(user.uid);

                                          final addPost = Post(
                                              comments: post["comments"],
                                              date:post["date"],
                                              dislikeCount: post["dislikes"].length,
                                              likeCount: post["likes"].length,
                                              postId: postCount + 1,
                                              text: post["text"],
                                              userId: post["userId"],
                                              username: uname,
                                              image: post["image"],
                                              isDisabled: post["isDisabled"],
                                              isShared: true,
                                              fromWho: post["username"],
                                              topic: post["topic"] ?? ""
                                          );
                                          usersService.createPost(user.uid, addPost);
                                        },
                                        incrementDislike: () {
                                          usersService.dislikePost(
                                              user.uid, post["userId"],
                                              post["postId"]);
                                        },
                                      )
                              ).toList().reversed),
                            )
                        );
                      }
                      if(snapshot.connectionState != ConnectionState.done) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return Container();
                    }
                );
              }
              else{
                  return DisabledScreen();
              }
            }
            if(snapshot.connectionState == ConnectionState.done)
              {
                return Container();
              }
            return const Center(child: CircularProgressIndicator());
            }
        ),


        bottomNavigationBar: !disabled ? bottomNavBar(context): null,
      );
    }
    return Login(analytics: widget.analytics,observer: widget.observer,);
  }
}
