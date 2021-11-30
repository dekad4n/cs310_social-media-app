import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';


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

        appBar: AppBar(
          leading:IconButton(
            icon: Icon(Icons.close),
            onPressed: (){
              Navigator.pushNamed(context, '/welcome' );
            },
          ),

          title: Text('Back to Main Menu'),
          backgroundColor: Colors.deepPurple,

        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 40,),
                  Image.network('https://res.cloudinary.com/teepublic/image/private/s--OhLHtLWr--/t_Resized%20Artwork/c_fit,g_north_west,h_1054,w_1054/co_ffffff,e_outline:53/co_ffffff,e_outline:inner_fill:53/co_bbbbbb,e_outline:3:1000/c_mpad,g_center,h_1260,w_1260/b_rgb:eeeeee/c_limit,f_auto,h_630,q_90,w_630/v1575503762/production/designs/7039866_0.jpg',
                    width: 150,
                    height: 150,
                  ),
                  SizedBox(height: 20,),
                  Text('Login',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,

                    ),

                  ),
                  Padding(
                    padding: EdgeInsets.all(12.0),
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
                                    fillColor: Colors.grey,
                                    filled: true,
                                    hintText: 'E-mail',
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                      ),
                                      borderRadius: BorderRadius.all(Radius.circular(30)),
                                    ),
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
                          SizedBox(height: 16,),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 1,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    fillColor: Colors.grey,
                                    filled: true,
                                    hintText: 'Password',
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                      ),
                                      borderRadius: BorderRadius.all(Radius.circular(30)),
                                    ),
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
                          SizedBox(height: 16,),
                          Row(

                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: OutlinedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()){
                                      _formKey.currentState!.save();
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                                    child: Text(
                                      'Login',
                                      //style: kButtonDarkTextStyle,
                                    ),
                                  ),
                                  style: OutlinedButton.styleFrom(
                                    backgroundColor: Colors.white,
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
