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
    return StreamBuilder(
      stream: userService.users.doc(widget.otherUser).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
        if(snapshot.hasData)
          {
            UserProfile otherUserProfile = UserProfile.fromMap(snapshot.data!.data() as Map<String,dynamic>);
            bool doesFollow = otherUserProfile.followers.contains(widget.userProfile.userId);
            String buttonWrite = "";
            if(doesFollow)
              {
                buttonWrite = "Unfollow";
              }
            else{
              bool doesRequest = otherUserProfile.requests.contains(widget.userProfile.userId);
              if(doesRequest)
                {
                  buttonWrite = "Requested";
                }
              else{
                buttonWrite = "Follow";
              }
            }
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
                        onPressed: () async{
                            if(otherUserProfile.followers.contains(widget.userProfile.userId)) {
                                await userService.unFollow(widget.userProfile.userId,
                                    otherUserProfile.userId);

                            }
                            else{
                              await userService.followSomeBody(widget.userProfile.userId, otherUserProfile.userId, otherUserProfile.isPrivate);



                            }
                            print("Other user followers: ${otherUserProfile.followers}");
                            setState(() {
                            });
                        },
                        child: Text(buttonWrite)
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
