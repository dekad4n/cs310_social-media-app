import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:sucial_cs310_project/utils/colors.dart';
import 'package:sucial_cs310_project/utils/dimensions.dart';
import 'package:sucial_cs310_project/utils/styles.dart';


class Signup extends StatefulWidget {

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {

  final _formKey = GlobalKey<FormState>();
  String mail = "";
  String uname = "";
  TextEditingController pass = TextEditingController();
  TextEditingController passagain = TextEditingController();
  Future<void> signUpSuccessful(String title, String message) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {

            return AlertDialog(
              title: Text(title),
              content: SingleChildScrollView(
                child: Text(message),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/login');
                    },
                    child: Text('OK')),
              ],
            );
        });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: Dimen.onStartingMarginInsets,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Padding(
                      padding:const EdgeInsets.all(0.0),
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage('https://www.pngall.com/wp-content/uploads/5/User-Profile-PNG-Free-Image.png')
                          )
                        ),
                      )
                    ),
                  ],
                ),
                const SizedBox(height:16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      'SIGN UP',
                      style: gettingStartedStyleBold,
                    ),
                  ],
                ),
                const SizedBox(height:Dimen.signUpSized),
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
                            hintText: 'E-mail',
                            hintStyle: hintStyleLogin,
                            border: UnderlineInputBorder (
                              borderRadius: Dimen.borderRadius,
                              borderSide: BorderSide(
                                color: AppColors.activeDots,
                              ),
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,

                          validator: (value){
                            if (value == null) {
                              return 'E-mail field cannot be empty';
                            } else {
                              String trimmedValue = value.trim();
                              if (trimmedValue.isEmpty){
                                return 'E-mail field cannot be empty';
                              }
                              if (!EmailValidator.validate(trimmedValue)){
                                return 'Please enter a valid email';
                              }
                            }
                            return null;
                          },

                          onSaved: (value){
                            if(value != null){
                              mail = value;
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height:Dimen.signUpSized),
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
                            icon: const Icon(Icons.person),
                            hintText: 'Username',
                            hintStyle: hintStyleLogin,
                            border: UnderlineInputBorder (
                              borderRadius: Dimen.borderRadius,
                              borderSide: BorderSide(
                                color: AppColors.activeDots,
                              ),
                            ),
                          ),
                          keyboardType: TextInputType.text,

                          validator: (value){
                            if (value == null){
                              return 'Username field cannot be empty';
                            } else {
                              String trimmedValue = value.trim();
                              if (trimmedValue.isEmpty){
                                return 'Username field cannot be empty';
                              }
                            }
                            return null;
                          },

                          onSaved: (value){
                            if(value != null) {
                              uname = value;
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height:Dimen.signUpSized),

                SizedBox(
                  width: Dimen.signBoxWidth,
                  height: Dimen.signBoxHeight,
                  child: Row( // 350 50
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          decoration: InputDecoration(
                            fillColor: AppColors.backgroundColor,
                            filled: true,
                            icon: const Icon(Icons.lock),
                            hintText: 'Password',
                            hintStyle: hintStyleLogin,
                            border:  UnderlineInputBorder (
                              borderRadius: Dimen.borderRadius,
                              borderSide: const BorderSide(
                                color: AppColors.activeDots,
                              ),
                            ),
                          ),
                          controller: pass,
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,

                          validator: (value){
                            if (value == null ) {
                              return 'Password field cannot be empty';
                            } else {
                              String trimmedValue = value.trim();
                              if (trimmedValue.isEmpty) {
                                return 'Password field cannot be empty';
                              }
                              if (trimmedValue.length < 8){
                                return 'Password must be at least 8 characters long';
                              }
                            }
                            return null;
                          },

                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height:Dimen.signUpSized),
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
                            icon: const Icon(Icons.lock),
                            hintText:'Password Again',
                            hintStyle: hintStyleLogin,
                            border: UnderlineInputBorder(
                              borderRadius: Dimen.borderRadius,
                              borderSide: const BorderSide(
                                color: AppColors.activeDots,
                              ),
                            ),
                          ),
                          controller: passagain,
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,

                          validator: (value){
                            if (value == null ) {
                              return 'This field cannot be empty';
                            } else {
                              String trimmedValue = value.trim();
                              if (trimmedValue.isEmpty) {
                                return 'This field cannot be empty';
                              }
                              if (pass.text != passagain.text){
                                return 'Password do not match';
                              }
                            }
                            return null;
                          },

                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height:Dimen.signUpSized),
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

                          onPressed: () {
                            if(_formKey.currentState!.validate()){
                              _formKey.currentState!.save();
                              setState(() {
                                signUpSuccessful('Sign up is successful', 'Click ok to go login page');
                              });
                            }
                          },
                          child: Padding(
                            padding: Dimen.symmetricSignupInsets,
                            child: Text(
                              'Sign Up',
                              style: hintStyleLogin,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height:Dimen.signUpSized),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[

                    Expanded(
                      flex: 1,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          primary: Colors.deepPurple[100],
                        ),
                        onPressed: () {
                        },
                        child: Padding(
                          padding: Dimen.symmetricSignupInsets,
                          child: Container(
                            height: 42,
                            width: 42,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                        'https://www.transparentpng.com/thumb/facebook-logo-png/facebook-logo-clipart-hd-10.png'
                                    )
                                )
                            ),
                          ),
                        ),
                      ),
                    ),

                    Expanded(
                      flex: 1,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          primary: Colors.deepPurple[100],
                        ),
                        onPressed: () {

                        },
                        child: Padding(
                          padding: Dimen.symmetricSignupInsets,
                          child: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Container(
                              height: 42,
                              width: 42,
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        'https://www.freepnglogos.com/uploads/google-logo-png/google-logo-dwglogo-19.png'
                                    ),
                                    fit: BoxFit.cover,
                                  )
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

