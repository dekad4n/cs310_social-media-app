import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sucial_cs310_project/services/user_service.dart';
import 'package:sucial_cs310_project/ui/comment_card.dart';
import 'package:sucial_cs310_project/utils/colors.dart';
import 'package:sucial_cs310_project/utils/dimensions.dart';
import 'package:sucial_cs310_project/utils/styles.dart';
import 'package:sucial_cs310_project/widgets/navbars.dart';


class CommentsView extends StatefulWidget {
  final String userId;
  final String otherUserId;
  final int postId;

  const CommentsView({Key? key, required this.userId, required this.otherUserId, required this.postId}) : super(key: key);

  @override
  _CommentsViewState createState() => _CommentsViewState();
}

class _CommentsViewState extends State<CommentsView> {
  final _formKey = GlobalKey<FormState>();
  UsersService userService = UsersService();
  String comment = "";
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: userService.users.doc(widget.otherUserId).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot)
      {
        if(snapshot.hasData)
          {
            List<dynamic> post = (snapshot.data!.data() as Map<String,dynamic>)["posts"];
            List<dynamic> comments = [];
            for(int i = 0 ; i < post.length ; i++)
              {
                if(post[i]["postId"] == widget.postId)
                  {
                    comments = post[i]["comments"];
                    break;
                  }

              }

            return Scaffold(
              appBar: appBarBack(context, "Comments"),
              body: SingleChildScrollView(
                child: Column(
                    children: [
                      Column(
                        children: comments.map((comment) =>
                                CommentCard(
                                    userId: comment["senderId"],
                                    comment: comment["context"])
                            ).toList(),
                      ),


                      Align(
                        alignment: FractionalOffset.bottomCenter,
                        child: Form(
                            key: _formKey,
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      fillColor: AppColors.backgroundColor,
                                      filled: true,
                                      hintText: 'Write your comment',
                                      hintStyle: hintStyleLogin,
                                      border: UnderlineInputBorder(
                                        borderRadius: Dimen.borderRadius,
                                        borderSide:  const BorderSide(
                                          color: AppColors.activeDots,
                                        ),
                                      ),
                                    ),
                                    keyboardType: TextInputType.emailAddress,

                                    onSaved: (value) {
                                      if (value != null) {
                                        comment = value;
                                      }
                                    },
                                  ),
                                ),
                                TextButton(onPressed: ()
                                {
                                  // TO DO: CREATE COMMENT
                                  _formKey.currentState!.save();
                                  if(comment != "") {
                                    userService.sendCommendTo(
                                        widget.userId, widget.otherUserId, widget.postId,
                                        comment);
                                    setState(() {

                                      comments.add({"context": comment, "senderId": widget.userId});

                                    });

                                  }
                                }, child: const Text("Send"))
                              ],
                            )
                        ),
                      )
                ]
                ),
              ),
            );
          }
        return const Center(child:CircularProgressIndicator());
      }
    );
  }
}



