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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      child: Image.asset('assets/myappview.png',
                        height: 100,
                        width: 100,
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
                            fillColor: AppColors.sucialColor,
                            filled: true,
                            icon: const Icon(Icons.email),
                            hintText: 'E-mail',
                            hintStyle: smallExplanation,
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
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
                            fillColor: AppColors.sucialColor,
                            filled: true,
                            icon: const Icon(Icons.person),
                            hintText: 'Username',
                            hintStyle: smallExplanation,
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
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
                            fillColor: AppColors.sucialColor,
                            filled: true,
                            icon: const Icon(Icons.lock),
                            hintText: 'Password',
                            hintStyle: smallExplanation,
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(
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
                            fillColor: AppColors.sucialColor,
                            filled: true,
                            icon: const Icon(Icons.lock),
                            hintText:'Password Again',
                            hintStyle: smallExplanation,
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(
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
                        child: OutlinedButton(
                          onPressed: () {
                            if(_formKey.currentState!.validate()){
                              _formKey.currentState!.save();
                              Navigator.pushNamed(context, '/profile');
                            }
                          },
                          child: Padding(
                            padding: Dimen.symmetricSignupInsets,
                            child: Text(
                              'Sign Up',
                              style: smallExplanation,
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
                    Image.asset( 'assets/facebooklogo.jpg',
                      width: 42,
                      height: 42,
                    ),
                    Expanded(
                      flex: 1,
                      child: OutlinedButton(
                        onPressed: () {

                        },
                        child: Padding(
                          padding: Dimen.symmetricSignupInsets,
                          child: Text('Login With Facebook', style: smallExplanation,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset('assets/googlelogo.png',
                        width: 20,
                        height: 20,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: OutlinedButton(
                        onPressed: () {

                        },
                        child: Padding(
                          padding: Dimen.symmetricSignupInsets,
                          child: Text(
                            'Login With Google',
                            style: smallExplanation,
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

