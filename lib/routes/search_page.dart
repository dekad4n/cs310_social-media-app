import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sucial_cs310_project/model/post.dart';
import 'package:sucial_cs310_project/services/post_service.dart';
import 'package:sucial_cs310_project/services/user_service.dart';
import 'package:sucial_cs310_project/ui/post_tile.dart';
import 'package:sucial_cs310_project/ui/search_card.dart';
import 'package:sucial_cs310_project/utils/colors.dart';
import 'package:sucial_cs310_project/widgets/navbars.dart';

import 'comments.dart';


class SearchPage2 extends StatefulWidget {
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;
  const SearchPage2({Key? key, required this.analytics, required this.observer}) : super(key: key);

  @override
  _SearchPageState2 createState() => _SearchPageState2();
}

class _SearchPageState2 extends State<SearchPage2> {
  TextEditingController searchController =  TextEditingController();
  List<bool> isSelected = [true,false];
  late Future<QuerySnapshot>  searchResultsFuture;
  UsersService userService = UsersService();
  PostService postService = PostService();

  @override
  void initState(){
    super.initState();
    searchController.addListener(_onSearchChanged);
  }
  @override
  void dispose(){
    searchController.removeListener(_onSearchChanged);
    searchController.dispose();
    super.dispose();
  }
  _onSearchChanged( ){

  }
  buildSearchResults(){

  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);

    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    // TODO: implement build
    if(isSelected[0]) {
      return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: StreamBuilder<QuerySnapshot>(
            stream: userService.users.snapshots().asBroadcastStream(),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot> snapshot) {
              return SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: [
                      const SizedBox(height: 40,),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: TextFormField(
                          controller: searchController,
                          decoration: InputDecoration(
                            hintText: "Search Something.....",
                            fillColor: Colors.white,
                            filled: true,
                            prefixIcon: const Icon(
                              Icons.search,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(Icons.clear),
                              onPressed: clearSearch,
                            ),
                          ),

                        ),
                      ),
                      ToggleButtons(
                        children: [
                          const Text("User Search"),
                          const Text("Post Search"),
                        ],
                        isSelected: isSelected,
                        onPressed: (int index) {
                          setState(() {
                            isSelected[0] = index == 1 ? false: true;
                            isSelected[1] = index == 1 ? true : false;
                          });
                        },
                      ),
                      const SizedBox(height: 40,),
                      if(searchController.text != "")
                        Column(
                          children: snapshot.data!.docs.where(
                                  (QueryDocumentSnapshot<Object?> element) =>
                                  element['usernameLower']
                                      .toString().contains(
                                      searchController.text.toLowerCase()))
                              .map((QueryDocumentSnapshot<Object?> data) =>
                              SearchCard(
                                analytics: widget.analytics,
                                observer: widget.observer,
                                username: data['username'],
                                profilePic: data['profilepicture'],
                                userId: data['userId'],
                              )).toList(),
                        )
                    ],
                  ),
                ),
              );
            }

        ),
        bottomNavigationBar: bottomNavBar(context),

      );
    }
    else{
      return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: StreamBuilder<QuerySnapshot>(
            stream: postService.posts.snapshots().asBroadcastStream(),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot> snapshot) {
              return SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: [
                      const SizedBox(height: 40,),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: TextFormField(
                          controller: searchController,
                          decoration: InputDecoration(
                            hintText: "Search Something.....",
                            fillColor: Colors.white,
                            filled: true,
                            prefixIcon: const Icon(
                              Icons.search,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(Icons.clear),
                              onPressed: clearSearch,
                            ),
                          ),

                        ),
                      ),
                      ToggleButtons(
                        children: [
                          const Text("User Search"),
                          const Text("Post Search"),
                        ],
                        isSelected: isSelected,
                        onPressed: (int index) {
                          setState(() {
                            isSelected[0] = index == 1 ? false: true;
                            isSelected[1] = index == 1 ? true : false;
                          });

                        },
                      ),
                      const SizedBox(height: 40,),
                      if(searchController.text != "")
                        Column(
                          children: snapshot.data!.docs.where(
                                  (QueryDocumentSnapshot<Object?> element) =>
                                  element['text']
                                      .toString().contains(
                                      searchController.text.toLowerCase()))
                              .map((QueryDocumentSnapshot<Object?> data) =>
                              PostTile(
                                delete: (){},
                                incrementDislike: (){
                                  userService.dislikePost(user!.uid, data["userId"], data["postId"]);
                                },
                                incrementComment: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CommentsView(
                                                  userId: user!.uid,
                                                  otherUserId: data["userId"],
                                                  postId: data["postId"]
                                              )
                                      )
                                  );
                                },
                                incrementLike: (){
                                  userService.likePost(user!.uid, data["userId"], data["postId"]);
                                },
                                isOther: true,
                                post: Post(
                                  comments: data["comments"],
                                  date:data["date"],
                                  dislikeCount: data["dislikes"].length,
                                  likeCount: data["likes"].length,
                                  postId: data["postId"],
                                  text: data["text"],
                                  userId: data["userId"],
                                  username: data["username"],
                                  image: data["image"]
                                ),
                              )).toList(),
                        )
                    ],
                  ),
                ),
              );

            }

        ),
        bottomNavigationBar: bottomNavBar(context),

      );
    }
  }

  void clearSearch() {
    searchController.clear();
  }
}
