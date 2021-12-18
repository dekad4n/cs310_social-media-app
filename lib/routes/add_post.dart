import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sucial_cs310_project/model/post.dart';
import 'package:sucial_cs310_project/services/user_service.dart';
import 'package:sucial_cs310_project/utils/colors.dart';
import 'package:sucial_cs310_project/utils/dimensions.dart';
import 'package:sucial_cs310_project/utils/styles.dart';
import 'package:sucial_cs310_project/widgets/navbars.dart';

class AddPost extends StatefulWidget {
  const AddPost({Key? key}) : super(key: key);

  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  File? image;
  String? text;
  final _formKey = GlobalKey<FormState>();
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      final imageTemporary = File(image!.path);
      setState(() {
        this.image = imageTemporary;
      });
    } catch (e) {
      // TO DO
    }
  }
  dynamic returnImage()
  {
    if(image != null)
      {
        return Image.file(
          image!,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height*3/4,
        );
      }
    return Image.asset('assets/nopp.png');
  }
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    return Form(
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
                UsersService userService = UsersService();
                print("neden $text");
                String? imageStr;
                if(image != null) {
                  imageStr = await userService.uploadPost(user, image!);
                }
                final timestamp = DateTime.now(); // timestamp in seconds
                String today = timestamp.year.toString() + "/" +timestamp.month.toString() + "/"+ timestamp.day.toString();
                Post post = Post(image: imageStr,text: text ?? "", likeCount: 0, date: today.toString(), commentCount: 0, dislikeCount: 0);
                userService.createPost(user!.uid, post);
                Navigator.pushNamed(context, '/profile');
              },
              child: Text(
                "Post!",
                style: sucialStylemSmall,
              ),
            )
          ],
          title: Text(
            "Add Post",
            style: sucialStylemMed,
          ),
          centerTitle: true,
          backgroundColor: AppColors.moreDarkerBackground,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                  iconSize: MediaQuery.of(context).size.width,
                  onPressed: () => pickImage(),
                  icon: returnImage()
              ),
              Padding(
                padding: Dimen.symmetricSignupInsets,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Post Description"),
                    TextFormField(
                      onSaved:(value){ text =value;},
                    ),
                  ],
                ))
            ],
          ),
        ),
      ),
    );
  }
}
