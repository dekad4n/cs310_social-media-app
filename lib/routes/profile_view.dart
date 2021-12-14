import 'package:flutter/material.dart';
import 'package:sucial_cs310_project/model/post.dart';
import 'package:sucial_cs310_project/ui/post_tile.dart';

class ProfileView extends StatefulWidget {


  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  int count = 0;
  List<Post> myPosts = [
    Post(text: 'Hello Sadi', date: '10.12.2021', dislikeCount:0,likeCount: 0, commentCount: 0),
    Post(image: 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',text: 'Hello Sadi', date: '10.12.2021', dislikeCount:0,likeCount: 0, commentCount: 0),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Page',
            style: TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            )
        ),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
        elevation: 1.0,


      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(

                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // edit profile
                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                    onPressed: (){},
                    child: const Text('Edit Profile'),

                  ),


                  Column(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.grey,
                        child: ClipOval(
                          child: Image.network("https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png",
                            fit: BoxFit.cover,
                          ),

                        ),
                        radius: 50,
                      ),
                      Text('Name Surname'),

                    ],
                  ),

                  Column(
                    children: [
                      Text('XXX Following'),
                      Text('XXX FOLLOWERS'),
                    ],
                  ),

                ]
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Spacer(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.add_location),
                      tooltip: 'LOCATION',
                      onPressed: () {},

                    ),
                    IconButton(
                      icon: const Icon(Icons.not_started),
                      tooltip: 'BEN DE BILMIYOM',
                      onPressed: () {},

                    ),

                  ],
                ),
                SizedBox(width: 12,),
                Text(
                  'BIOGRAPHY IN HERE',

                ),
                Spacer(),
                SizedBox(width: 40,),

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
                        (post) =>
                        PostTile(
                          post: post,
                          delete: () {
                            setState(() {
                              myPosts.remove(post);
                            });
                          },
                          incrementLike: () {
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
                          },
                        )
                ).toList(),
              ),
            ),





          ],
        ),
      ),
    );
  }
}
