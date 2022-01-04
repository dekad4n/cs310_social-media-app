import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sucial_cs310_project/model/post.dart';
import 'package:sucial_cs310_project/model/user_profile.dart';
import 'package:sucial_cs310_project/routes/comments.dart';
import 'package:sucial_cs310_project/routes/edit_profile.dart';
import 'package:sucial_cs310_project/routes/login.dart';
import 'package:sucial_cs310_project/routes/user_details/followers.dart';
import 'package:sucial_cs310_project/routes/user_details/following.dart';
import 'package:sucial_cs310_project/services/user_service.dart';
import 'package:sucial_cs310_project/ui/post_tile.dart';
import 'package:sucial_cs310_project/widgets/navbars.dart';

class ProfileView extends StatefulWidget {
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;
  const ProfileView({Key? key, required this.analytics, required this.observer}) : super(key: key);
  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {

  UsersService usersService = UsersService();

  @override
  Widget build(BuildContext context){
    final user = Provider.of<User?>(context);
    if(user != null) {
      return Scaffold(
        appBar: appBarSignOut(context),
        body: FutureBuilder<DocumentSnapshot>(
          future: usersService.users.doc(user.uid).get(),
          builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
            if(snapshot.hasError)
            {
              return const Center(child: Text("Refresh the page!"));
            }
            if(snapshot.connectionState == ConnectionState.done && snapshot.hasData  && snapshot.data != null && snapshot.data!.data() != null)
            {
              UserProfile userProfile = UserProfile.fromMap((snapshot.data!.data() ?? Map<String,dynamic>.identity()) as Map<String,dynamic>);
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: TextButton(
                                onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfile(analytics: widget.analytics, observer: widget.observer, userProfile: userProfile)));
                                },
                                child: const Text('Edit Profile')
                            ),
                          ),
                          Column(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.grey,
                                child: ClipOval(
                                  child: Image.network(
                                    userProfile.profilepicture,
                                    fit: BoxFit.cover,
                                    width: 100,
                                    height: 100,
                                  ),
                                ),
                                radius: 50,
                              ),
                              Text(userProfile.fullName),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: Column(
                              children: [
                                TextButton(
                                  onPressed: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => Following(analytics: widget.analytics,observer: widget.observer, userId: userProfile.userId)));
                                  },
                                    child: Text('${userProfile.following.length} following')
                                ),
                                const SizedBox(height: 12.0),
                                TextButton(
                                    onPressed: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => Followers(analytics: widget.analytics,observer: widget.observer,userId: userProfile.userId)));
                                    },
                                    child: Text('${userProfile.followers.length} follower')
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(width: MediaQuery.of(context).size.width/8,),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              IconButton(
                                  onPressed: (){},
                                  tooltip: 'LOCATION',
                                  icon: const Icon(Icons.add_location)
                              ),
                              IconButton(
                                  onPressed: (){},
                                  tooltip: 'IDK',
                                  icon: const Icon(Icons.not_started)
                              )
                            ],
                          ),
                          SizedBox(width: MediaQuery.of(context).size.width/6 ,),
                          Padding(
                            padding: const EdgeInsets.only(top: 16.0),
                            child: Text(userProfile.biography),
                          ),
                          SizedBox(width: MediaQuery.of(context).size.width/4,),
                        ],

                      ),
                      const Divider(
                        height: 20,
                        thickness: 3,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: userProfile.posts.map(
                                  (post) => PostTile(
                                  post: Post.fromMap(post),
                                  delete: ()
                                  {
                                    setState(() {
                                      usersService.deletePost(user.uid, post);
                                    });
                                  },
                                  isOther: false,
                                  incrementLike:(){
                                      usersService.likePost(user.uid, userProfile.userId, post["postId"]);
                                  },
                                  incrementComment: (){

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
                                  sharePost: () async{
                                    final postCount = await usersService.getPostCount(user.uid);

                                    final addPost = Post(
                                        comments: post["comments"],
                                        date:post["date"],
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
                                    usersService.createPost(user.uid, addPost);
                                      },
                                  incrementDislike: (){
                                    usersService.dislikePost(user.uid, userProfile.userId, post["postId"]);

                                  }
                              )
                          ).toList(),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
        bottomNavigationBar: bottomNavBar(context),
      );
    }
    return Login(analytics: widget.analytics, observer: widget.observer);
  }
}
