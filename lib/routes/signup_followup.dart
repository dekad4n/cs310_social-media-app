import 'dart:io';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sucial_cs310_project/utils/colors.dart';
import 'package:sucial_cs310_project/utils/dimensions.dart';
import 'package:sucial_cs310_project/utils/styles.dart';
import 'package:sucial_cs310_project/services/user_service.dart';

class SignUpFollowUp extends StatefulWidget {
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;
  const SignUpFollowUp({Key? key, required this.analytics, required this.observer}) : super(key: key);

  @override
  _SignUpFollowUpState createState() => _SignUpFollowUpState();
}

class _SignUpFollowUpState extends State<SignUpFollowUp> {
  final _formKey = GlobalKey<FormState>();
  String fullName ="";
  UsersService usersService = UsersService();
  final picker = ImagePicker();
  File? image;
  late bool isDone = false;
  Future<File>? imageFile;
  Future pickImage() async{
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      final imageTemporary = File(image!.path);
      setState(() {
        this.image = imageTemporary;
      });
    }catch(e){
      print('Error');
    }
  }
  Future<void> isSignupDone(User? user) async{
    isDone = await usersService.isSignupDone(user!.uid);
  }
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    isSignupDone(user);
    if(!isDone)
      {
        return Scaffold(
            backgroundColor: AppColors.backgroundColor,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: Dimen.onStartingMarginInsets,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 100),
                      IconButton(
                          iconSize: 200,
                          onPressed: () =>  pickImage(),
                          icon: CircleAvatar(
                              radius: 100,
                              child: ClipOval(

                                child: image != null ? Image.file(
                                  image!,
                                  width: 200,
                                  height: 200,
                                  fit: BoxFit.cover,
                                ): Image.asset('assets/nopp.png'),
                              )
                          )
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: Dimen.signBoxWidth,
                              height: Dimen.signBoxHeight,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        fillColor: AppColors.backgroundColor,
                                        filled: true,
                                        icon: const Icon(Icons.email),
                                        hintText: 'Full name',
                                        hintStyle: hintStyleLogin,
                                        border: UnderlineInputBorder(
                                          borderRadius: Dimen.borderRadius,
                                          borderSide: const BorderSide(
                                            color: AppColors.activeDots,
                                          ),
                                        ),
                                      ),

                                      validator: (value) {
                                        if (value == null) {
                                          return 'Full name field cannot be empty';
                                        } else {
                                          String trimmedValue = value.trim();
                                          if (trimmedValue.isEmpty) {
                                            return 'Full name field cannot be empty';
                                          }
                                        }
                                        return null;
                                      },

                                      onSaved: (value) {
                                        if (value != null) {
                                          fullName = value;
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: Dimen.symmetricSignup),
                            SizedBox(
                              width: 150,
                              child: Row( // width 150
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Expanded(
                                    child: ElevatedButton(

                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.deepPurple[200],
                                      ),

                                      onPressed: () async {
                                        if (_formKey.currentState!.validate()) {
                                          _formKey.currentState!.save();

                                          usersService.setFullName(fullName,user!.uid);
                                          if(image != null) {
                                            usersService.uploadProfilePicture(
                                                user, File(image!.path));
                                          }
                                          Navigator.pushNamed(context, '/feed');
                                        }
                                      },
                                      child: Padding(
                                        padding: Dimen.symmetricSignupInsets,
                                        child: Text(
                                          'Next',
                                          style: hintStyleLogin,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
        );
      }
    Navigator.pushNamed(context, '/feed');
    return Scaffold(body: Center(child: Text('Loading'),),);
  }
}
