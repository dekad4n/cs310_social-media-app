import 'package:flutter/material.dart';
import 'package:sucial_cs310_project/services/user_service.dart';
import 'package:sucial_cs310_project/utils/colors.dart';
import 'package:sucial_cs310_project/utils/dimensions.dart';
import 'package:sucial_cs310_project/utils/styles.dart';

class EditPost extends StatefulWidget {
  String userId;
  int postId;
  String? picture;

  EditPost({Key? key, required this.userId, required this.postId, this.picture}) : super(key: key);

  @override
  _EditPostState createState() => _EditPostState();
}

class _EditPostState extends State<EditPost> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  UsersService usersService = UsersService();

  String? text;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
        key: _formKey,
        child: Scaffold(
          appBar: AppBar(
            leading: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: IconButton(
                onPressed: (){
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () async{
                  _formKey.currentState!.save();
                  await usersService.editPost(widget.userId, widget.postId, text!);
                  Navigator.pushNamed(context, '/profile');
                },
                child: Text(
                  "Edit Post!",
                  style: sucialStylemSmall,
                ),
              )
            ],
            title: Text(
              "Edit Post",
              style: sucialStylemMed,
            ),
            centerTitle: true,
            backgroundColor: AppColors.moreDarkerBackground,
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if(widget.picture != null)
                  Image.network(
                    widget.picture!
                  ),
                Padding(
                    padding: Dimen.symmetricSignupInsets,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Post Description"),
                        TextFormField(
                          onSaved:(value){
                            if(value != null) {
                              text = value;
                            }else{
                              text = "";
                            }
                            },

                        ),
                      ],
                    ))
              ],
            ),
          ),
        ),
      )
    );
  }
}
