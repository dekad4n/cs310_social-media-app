import 'package:flutter/material.dart';
import 'package:sucial_cs310_project/model/post.dart';
import 'package:sucial_cs310_project/utils/colors.dart';
import 'package:sucial_cs310_project/utils/dimensions.dart';
import 'package:sucial_cs310_project/utils/styles.dart';
import 'package:sucial_cs310_project/widgets/navbars.dart';


class CommentsView extends StatefulWidget {
  final List<dynamic> comments;
  const CommentsView({Key? key, required this.comments}) : super(key: key);

  @override
  _CommentsViewState createState() => _CommentsViewState();
}

class _CommentsViewState extends State<CommentsView> {
  final _formKey = GlobalKey<FormState>();
  String comment = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarBack(context, "Comments"),
      body: Column(
        children: [
          SingleChildScrollView(
            child: Column(

            ),
          ),
          Spacer(),
          Form(
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
                }, child: const Text("Send"))
              ],
            )
          )
        ],
      ),
    );
  }
}



