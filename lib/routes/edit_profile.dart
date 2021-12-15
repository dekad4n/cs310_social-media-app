import 'dart:io';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sucial_cs310_project/model/user_profile.dart';
import 'package:sucial_cs310_project/services/auth.dart';
import 'package:sucial_cs310_project/services/user_service.dart';
import 'package:sucial_cs310_project/utils/colors.dart';
import 'package:sucial_cs310_project/utils/styles.dart';
import 'package:sucial_cs310_project/widgets/alert.dart';
import 'package:sucial_cs310_project/widgets/navbars.dart';

class EditProfile extends StatefulWidget {
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;
  final UserProfile userProfile;
  const EditProfile({Key? key, required this.analytics, required this.observer, required this.userProfile}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  final UsersService _usersService = UsersService();
  String? fullName;
  String? biography;
  File? image;
  String oldPassword = "";
  String newPassword = "";
  String newPasswordAgain= "";
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      final imageTemporary = File(image!.path);
      setState(() {
        this.image = imageTemporary;
      });
    } catch (e) {
      print('Error');
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fullName = widget.userProfile.fullName;
    biography = widget.userProfile.biography;

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: appBarDefault(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      iconSize: 100,
                      onPressed: () =>  pickImage(),
                      icon: CircleAvatar(
                          radius: 100,
                          child: ClipOval(
                            child: image != null ? Image.file(
                              image!,
                              width: 200,
                              height: 200,
                              fit: BoxFit.cover,
                            ): Image.network(
                                widget.userProfile.profilepicture,
                                width: 200,
                                height: 200,
                                fit: BoxFit.cover,
                            ),
                          )
                      )
                  ),
                ],
              ),
            ),
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        "Name Surname ",
                        style: hintStyleLoginButton,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: TextFormField(

                            decoration: InputDecoration(
                              fillColor: AppColors.backgroundColor,
                              filled: true,
                              hintText: fullName,
                            ),
                            onSaved: (value) {
                              if (value != null) {
                                fullName = value;
                              }
                            },

                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16,),
                    Text(
                        "Biography",
                        style: hintStyleLoginButton,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: TextFormField(

                            decoration: InputDecoration(
                              fillColor: AppColors.backgroundColor,
                              filled: true,
                              hintText: biography,
                            ),

                            validator: (value) {
                              return null;
                            },
                            onSaved: (value) {
                              if (value != null) {
                                biography = value;
                              }
                            },

                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),

                    Text(
                        "Change Password",
                        style: hintStyleLoginButton,
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: TextFormField(

                            decoration: InputDecoration(
                              fillColor: AppColors.backgroundColor,
                              filled: true,
                              hintText: "Old Password",

                            ),
                            onSaved: (value) {
                              if (value != null) {
                                oldPassword = value;
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),

                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: TextFormField(

                            decoration: InputDecoration(
                              fillColor: AppColors.backgroundColor,
                              filled: true,
                              hintText: "New Password",

                            ),
                            validator: (value) {
                              if(oldPassword != "")
                              {
                                if (value == null) {
                                  return 'Password field cannot be empty';
                                } else {
                                  String trimmedValue = value.trim();
                                  if (trimmedValue.isEmpty) {
                                    return 'Password field cannot be empty';
                                  }
                                  if (trimmedValue.length < 8) {
                                    return 'Password must be at least 8 characters long';
                                  }
                                }
                                newPassword = value;
                              }
                              return null;
                            },
                            onSaved: (value) {
                              if (value != null) {
                                newPassword = value;
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: TextFormField(

                            decoration: InputDecoration(
                              fillColor: AppColors.backgroundColor,
                              filled: true,
                              hintText: "New Password Again",

                            ),
                            validator: (value)
                            {
                              if(value != newPassword)
                                {
                                  return "New passwords does not match";
                                }
                              return null;
                            },
                            onSaved: (value) {
                            if (value != null) {
                              newPasswordAgain = value;
                            }
                          },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Center(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.deepPurple[200],
                            ),
                            onPressed: () async {
                              if (_formKey.currentState!.validate())  {
                                _formKey.currentState!.save();
                                if(biography != null) {
                                  _usersService.setBiography(
                                      biography!, widget.userProfile.userId);
                                }
                                if(fullName != null)
                                  {
                                    _usersService.setFullName(
                                        fullName!, widget.userProfile.userId);
                                  }

                                if(oldPassword != "") {
                                  bool isSuccess = await _auth.changePassword(
                                      oldPassword, newPassword);
                                  if (!isSuccess) {
                                    showAlertScreen(
                                        context, "Old password is wrong",
                                        "Try again");
                                  }
                                  else {
                                    Navigator.pushNamed(context, '/profile');
                                  }
                                }
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12.0),
                              child: Text(
                                'Save Changes',
                                style: hintStyleLoginButton,
                              ),
                            ),
                          ),
                        ),
                      ],

                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      )
    );
  }
}
