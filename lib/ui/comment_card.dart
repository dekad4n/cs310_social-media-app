import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sucial_cs310_project/model/user_profile.dart';
import 'package:sucial_cs310_project/services/user_service.dart';
import 'package:sucial_cs310_project/utils/styles.dart';

class CommentCard extends StatefulWidget {
  final String comment;
  final String userId;
  const CommentCard({Key? key,required  this.userId, required this.comment}) : super(key: key);

  @override
  _CommentCardState createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  UsersService userService = UsersService();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: userService.users.doc(widget.userId).get(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
          if(snapshot.hasData)
          {
            var profilePicture = (snapshot.data!.data() as Map<String, dynamic>)["profilepicture"];
            return Card(
              child: Row(
                children: [
                  const SizedBox(width: 16,),
                  CircleAvatar(
                    child: ClipOval(
                      child: Image.network(
                        profilePicture,
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
                      widget.comment,
                      style: personCardStyle,
                    ),
                  ),
                ],
              ),
            );
          }
          return const CircularProgressIndicator();
        }
    );
  }
}
