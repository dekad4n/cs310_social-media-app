import 'package:flutter/material.dart';
import 'package:sucial_cs310_project/model/user_profile.dart';
import 'package:sucial_cs310_project/services/user_service.dart';
import 'package:sucial_cs310_project/utils/colors.dart';
import 'package:sucial_cs310_project/utils/styles.dart';

class PersonCard extends StatelessWidget {
  final UserProfile userProfile;
  final UserProfile otherUser;
  final VoidCallback followButtonCallback;
  String text;
  PersonCard({Key? key, required this.userProfile, required this.otherUser, required this.followButtonCallback, required this.text}) : super(key: key);

  UsersService userService = UsersService();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shadowColor: AppColors.backgroundColor,
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            const SizedBox(width: 16,),
            CircleAvatar(
              child: ClipOval(
                child: Image.network(
                    otherUser.profilepicture,
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
                  otherUser.username,
                  style: personCardStyle,
                ),
            ),
            const Spacer(),
            ElevatedButton(
                onPressed: followButtonCallback,
                child: Text(
                  text,
                )
            ),
            const SizedBox(width: 16,),

          ],
        ),
      ),
    );
  }
}
