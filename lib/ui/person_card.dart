import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sucial_cs310_project/model/user_profile.dart';
import 'package:sucial_cs310_project/services/user_service.dart';
import 'package:sucial_cs310_project/utils/colors.dart';
import 'package:sucial_cs310_project/utils/styles.dart';

class PersonCard extends StatefulWidget {
  final UserProfile userProfile;
  final String otherUser;

  PersonCard({Key? key, required this.userProfile, required this.otherUser}) : super(key: key);

  @override
  State<PersonCard> createState() => _PersonCardState();
}

class _PersonCardState extends State<PersonCard> {
  UsersService userService = UsersService();

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: userService.users.doc(widget.otherUser).get(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
        if(snapshot.hasData)
          {
            UserProfile otherUserProfile = UserProfile.fromMap(snapshot.data!.data() as Map<String,dynamic>);
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8),
              shadowColor: AppColors.backgroundColor,
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const SizedBox(width: 16,),
                    CircleAvatar(
                      child: ClipOval(
                        child: Image.network(
                          otherUserProfile.profilepicture,
                          fit: BoxFit.cover,
                          width: 70,
                          height: 70,
                        ),
                      ),
                      radius: 35,
                    ),
                    const SizedBox(width: 16,),
                    TextButton(
                      onPressed: (){
                      },
                      child: Text(
                        otherUserProfile.username,
                        style: personCardStyle,
                      ),
                    ),
                    const Spacer(),
                    ElevatedButton(
                        onPressed: (){
                          setState(() {
                            userService.unFollow(widget.userProfile.userId,otherUserProfile.userId);
                          });
                        },
                        child: const Text("Unfollow")
                    ),
                    const SizedBox(width: 16.0,)
                  ],
                ),
              ),
            );
          }
        return Card();
      }
    );
  }
}
