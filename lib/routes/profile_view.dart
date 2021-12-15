import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sucial_cs310_project/model/post.dart';
import 'package:sucial_cs310_project/model/user_profile.dart';
import 'package:sucial_cs310_project/routes/edit_profile.dart';
import 'package:sucial_cs310_project/services/user_service.dart';
import 'package:sucial_cs310_project/ui/post_tile.dart';
import 'package:sucial_cs310_project/utils/colors.dart';
import 'package:sucial_cs310_project/utils/styles.dart';
import 'package:sucial_cs310_project/widgets/navbars.dart';

class ProfileView extends StatefulWidget {
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;
  const ProfileView({Key? key, required this.analytics, required this.observer}) : super(key: key);
  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  int count = 0;
  List<Post> myPosts = [
    Post(text: 'Hello Sadi', date: '10.12.2021', dislikeCount:0,likeCount: 0, commentCount: 0),
    Post(image: 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',text: 'Hello Sadi', date: '10.12.2021', dislikeCount:0,likeCount: 0, commentCount: 0),
  ];
  UsersService usersService = UsersService();

  @override
  Widget build(BuildContext context){
    final user = Provider.of<User?>(context);
    return Scaffold(
      appBar: appBarDefault(),
      body: FutureBuilder<DocumentSnapshot>(
        future: usersService.users.doc(user!.uid).get(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
          if(snapshot.hasError)
            {
              return Center(child: Text("Refresh the page!"));
            }
          if(snapshot.connectionState == ConnectionState.done)
            {
              UserProfile userProfile = UserProfile.fromMap(snapshot.data!.data() as Map<String,dynamic>);
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextButton(
                              onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfile(analytics: widget.analytics, observer: widget.observer, userProfile: userProfile)));
                              },
                              child: const Text('Edit Profile')
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
                          Column(
                            children: [
                              Text('XXX following'),
                              Text('XXX followers')
                            ],
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Spacer(),
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
                          const SizedBox(width: 12,),
                          Text(userProfile.biography),
                          Spacer(),
                          const SizedBox(width: 40,),
                        ],

                      ),
                      const Divider(
                        height: 20,
                        thickness: 3,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: myPosts.map(
                              (post) => PostTile(
                                  post: post,
                                  delete: ()
                                  {
                                    setState(() {
                                      myPosts.remove(post);
                                    });
                                  },
                                  incrementLike:(){
                                    setState(() {
                                      post.likeCount++;
                                    });
                                  },
                                  incrementComment: (){
                                    setState((){
                                      post.commentCount++;
                                    });
                                  },
                                  incrementDislike: (){
                                    setState((){
                                      post.dislikeCount++;
                                    });
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
          return Center(child: Text('Sth went wrong'),);
        },
      ),
      bottomNavigationBar: bottomNavBar(context),

    );
  }
}
