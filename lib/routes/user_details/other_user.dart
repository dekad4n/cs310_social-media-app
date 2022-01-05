import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sucial_cs310_project/model/post.dart';
import 'package:sucial_cs310_project/model/user_profile.dart';
import 'package:sucial_cs310_project/routes/comments.dart';
import 'package:sucial_cs310_project/services/user_service.dart';
import 'package:sucial_cs310_project/ui/post_tile.dart';
import 'package:sucial_cs310_project/widgets/navbars.dart';

import '../login.dart';
import 'followers.dart';
import 'following.dart';

class OtherUser extends StatefulWidget {
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;
  final String otherUserId;
  const OtherUser({Key? key, required this.analytics, required this.observer, required this.otherUserId}) : super(key: key);
  @override
  State<OtherUser> createState() => _OtherUserState();
}

class _OtherUserState extends State<OtherUser> {

  UsersService usersService = UsersService();
  bool followingInfo = false;
  void _changeFollowingInfo(String userId) async
  {
    followingInfo = await usersService.hasFollower(userId, widget.otherUserId);
  }
  void waiter(String userId)
  {
    _changeFollowingInfo(userId);
  }
  @override
  Widget build(BuildContext context){
    final user = Provider.of<User?>(context);
    if(user != null) {

      return Scaffold(
        appBar: appBarDefault(context),
        body: StreamBuilder<DocumentSnapshot>(
          stream: usersService.users.doc(widget.otherUserId).snapshots(),
          builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){

            if(snapshot.hasData)
            {
              UserProfile userProfile = UserProfile.fromMap(snapshot.data!.data() as Map<String,dynamic>);
              waiter(user.uid);
              bool doesContain =userProfile.followers.contains(user.uid);
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
                                  // TO DO : PUSH NOTIFS
                                  setState(() {
                                    if(!userProfile.requests.contains(user.uid)) {
                                      usersService.followSomeBody(
                                          user.uid, userProfile.userId,
                                          userProfile.isPrivate);
                                    }
                                    else{
                                      if(!doesContain){
                                        usersService.removeRequest(user.uid, userProfile.userId);
                                      }
                                      else{
                                        usersService.unFollow(user.uid,  userProfile.userId);
                                      }
                                    }
                                  });
                                },
                                child: userProfile.requests.contains(user.uid)? const Text("Requested"): doesContain ? const Text('Unfollow'): const Text('Follow')
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
                      if(followingInfo || userProfile.isPrivate == false )
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            children: userProfile.posts.map((post) => PostTile(
                              post: Post.fromMap(post),
                              isOther: true,
                              delete: () {},
                              incrementLike: (){
                                usersService.likePost(user.uid, post["userId"], post["postId"]);
                              },
                              sharePost: () async{
                                final username = await usersService.getUserName(user.uid);
                                final postCount = await usersService.getPostCount(user.uid);

                                final addPost = Post(
                                    comments: post["comments"],
                                    date:post["date"],
                                    dislikeCount: post["dislikes"].length,
                                    likeCount: post["likes"].length,
                                    postId: (postCount + 1),
                                    text: post["text"],
                                    userId: post["userId"],
                                    username:  username,
                                    image: post["image"],
                                    isDisabled: post["isDisabled"],
                                    isShared: true,
                                    fromWho: post["username"],
                                    Topic: post["Topic"]
                                );
                                usersService.createPost(user.uid, addPost);
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
                              incrementDislike: (){
                                usersService.dislikePost(user.uid, post["userId"], post["postId"]);

                              },

                            )
                            ).toList()
                          ),
                        )
                        else
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:  [
                                 const Icon(
                                  Icons.lock,
                                  size: 50
                                )
                              ]
                          )
                    ],
                  ),
                ),
              );
            }
            return const Center(child: Text('Loading...'),);
          },
        ),
        bottomNavigationBar: bottomNavBar(context),
      );
    }
    return Login(analytics: widget.analytics, observer: widget.observer);
  }
}