import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sucial_cs310_project/model/post.dart';
import 'package:sucial_cs310_project/model/user_profile.dart';
import 'package:sucial_cs310_project/routes/comments.dart';
import 'package:sucial_cs310_project/routes/login.dart';
import 'package:sucial_cs310_project/services/post_service.dart';
import 'package:sucial_cs310_project/services/user_service.dart';
import 'package:sucial_cs310_project/ui/post_tile.dart';
import 'package:sucial_cs310_project/widgets/navbars.dart';

class Bookmarks extends StatefulWidget {
  final String userId;
  FirebaseAnalytics analytics;
  FirebaseAnalyticsObserver observer;
  Bookmarks({Key? key, required this.userId, required this.analytics, required this.observer}) : super(key: key);

  @override
  _BookmarksState createState() => _BookmarksState();
}

class _BookmarksState extends State<Bookmarks> {
  PostService postService = PostService();
  UsersService usersService = UsersService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    if (user != null) {
      return Scaffold(
          appBar: appBarBack(context, "Bookmarks"),
          body: FutureBuilder<DocumentSnapshot>(
              future: usersService.users.doc(user.uid).get(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Center(child: Text("Refresh the page!"));
                }
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData && snapshot.data != null &&
                    snapshot.data!.data() != null) {
                  UserProfile userProfile = UserProfile.fromMap(
                      snapshot.data!.data() as Map<String, dynamic>);
                  List<dynamic> postList = userProfile.bookmarks;
                  return SingleChildScrollView(
                    child: Column(
                      children: postList.map((e) =>
                          FutureBuilder<DocumentSnapshot>
                            (
                            future: postService.posts.doc(e).get(),
                            builder: (BuildContext context,
                                AsyncSnapshot<DocumentSnapshot> postSnapshot) {
                              if (postSnapshot.hasData &&
                                  postSnapshot.connectionState ==
                                      ConnectionState.done &&
                                  postSnapshot.data != null &&
                                  postSnapshot.data!.data() != null) {
                                Map<String, dynamic> post = postSnapshot.data!
                                    .data() as Map<String, dynamic>;
                                return PostTile(
                                    post: Post.fromMap(post),
                                    delete: () {
                                      setState(() {
                                        usersService.deletePost(
                                            widget.userId, post);
                                      });
                                    },
                                    isOther: false,
                                    incrementLike: () {
                                      usersService.likePost(
                                          widget.userId, userProfile.userId,
                                          post["postId"]);
                                    },
                                    incrementComment: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CommentsView(
                                                      userId: widget.userId,
                                                      otherUserId: post["userId"],
                                                      postId: post["postId"]
                                                  )
                                          )
                                      );
                                    },
                                    sharePost: () async {
                                      final postCount = await usersService
                                          .getPostCount(widget.userId);

                                      final addPost = Post(
                                          comments: post["comments"],
                                          date: post["date"],
                                          dislikeCount: post["dislikes"].length,
                                          likeCount: post["likes"].length,
                                          postId: postCount + 1,
                                          text: post["text"],
                                          userId: post["userId"],
                                          username: userProfile.username,
                                          image: post["image"],
                                          isDisabled: post["isDisabled"],
                                          isShared: true,
                                          fromWho: post["username"]
                                      );
                                      usersService.createPost(
                                          widget.userId, addPost);
                                    },
                                    incrementDislike: () {
                                      usersService.dislikePost(
                                          widget.userId, userProfile.userId,
                                          post["postId"]);
                                    }
                                );
                              }
                              return Container();
                            },
                          )
                      ).toList(),
                    ),
                  );
                }
                return const Center(child: Text("Its not happenin"));
              }));
    }
    return Login(analytics: widget.analytics, observer: widget.observer);
  }
}