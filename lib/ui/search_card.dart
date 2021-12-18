
import 'package:flutter/material.dart';
import 'package:sucial_cs310_project/utils/colors.dart';


class SearchCard extends StatelessWidget {
  final String username;
  final String profilePic;

  const SearchCard({Key? key, required this.username, required this.profilePic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: (){
        // TO DO : GO TO THAT PROFILE
      },
      child: Card(
        color: AppColors.backgroundColor,
        elevation: 0,
        borderOnForeground: false,
        child: Row(
          children: [
            CircleAvatar(
              radius: 17.5,
              child: ClipOval(
                child: Image.network(
                    profilePic,
                  width: 35,
                  height: 35,
                  fit: BoxFit.cover
                ),
              ),
            ),
            const SizedBox(width: 16,),
            Text(username)
          ],
        ),
      ),
    );
  }
}
