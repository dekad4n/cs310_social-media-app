import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:sucial_cs310_project/utils/colors.dart';
import 'package:sucial_cs310_project/utils/styles.dart';


class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final _formKey = GlobalKey<FormState>();
  String mail = "";
  String pass ="";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,

        body: SingleChildScrollView(
          child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 50, 24, 0),
                        child: IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: (){
                            Navigator.pushNamed(context, '/welcome' );
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40,),
                  Container(
                    height: 150,
                    width: 150,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage('https://www.pngall.com/wp-content/uploads/5/User-Profile-PNG-Free-Image.png',

                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20,),
                  const Text('Log-In',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,

                    ),

                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment:MainAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 1,
                                child: TextFormField(

                                  decoration: InputDecoration(
                                    fillColor: AppColors.backgroundColor,
                                    filled: true,
                                    hintText: 'E-mail',
                                    border: UnderlineInputBorder(),
                                  ),
                                  keyboardType: TextInputType.emailAddress,

                                  validator: (value){
                                    if (value == null){
                                      return 'E-mail Field Cannot be Empty';
                                    }
                                    else{
                                      String trimmedValue = value.trim();
                                      if(trimmedValue.isEmpty) {
                                        return 'E-mail field cannot be empty';
                                      }
                                      if(!EmailValidator.validate(trimmedValue)) {
                                        return 'Please enter a valid email';
                                      }
                                    }
                                    return null;
                                  },
                                  onSaved: (value){
                                    if(value != null){
                                      mail =value;
                                    }
                                  },

                                ),
                              ),
                            ],

                          ),
                          const SizedBox(height: 16,),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 1,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    fillColor: AppColors.backgroundColor,
                                    filled: true,
                                    hintText: 'Password',
                                    border: UnderlineInputBorder(),
                                  ),
                                  keyboardType: TextInputType.text,
                                  obscureText: true,
                                  enableSuggestions: false,
                                  autocorrect: false,
                                  validator: (value){
                                    if(value == null){
                                      return 'Password Field Cannot be Empty';
                                    }
                                    else{
                                      String trimmedValue = value.trim();
                                      if (trimmedValue.isEmpty){
                                        return 'Password Field Cannot be Empty';
                                      }
                                      if(trimmedValue.length < 8 ){
                                        return 'Password must be at least 8 characters';
                                      }
                                    }
                                    return null;
                                  },
                                  onSaved: (value){
                                    if (value != null){
                                      pass = value;
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16,),
                          Row(

                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Center(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.deepPurple[200],
                                  ),
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()){
                                      _formKey.currentState!.save();
                                      Navigator.pushNamed(context, '/feed');
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                                    child: Text(
                                      'Log-In',
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
                  ),
                ]
            ),
          ),
        )
    );
  }
}
