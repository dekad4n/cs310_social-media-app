import 'package:flutter/material.dart';
import 'package:sucial_cs310_project/routes/login.dart';
import 'package:sucial_cs310_project/routes/signup.dart';
import 'package:sucial_cs310_project/utils/styles.dart';


class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  _WelcomeState createState() => _WelcomeState();
}


class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body:
        Container(
            height: size.height,
            width: double.infinity,
            child: Stack(
              children: <Widget>[
                Positioned(
                    top: 0,
                    left:0,
                    right:0,
                    bottom: -400,
                    child:
                    Image.asset("assets/myappview.png")

                ),
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: <Widget>[
                      Text(
                        "Welcome to ",
                        style: gettingStartedStyleBold,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "Sucial",
                        style: sucialStyleBig,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly ,
                        children: <Widget>[

                          Container(


                            width: size.width*0.6,
                            child: ClipOval(

                              //padding: EdgeInsets.symmetric(vertical: 20,horizontal:20),

                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 20,horizontal:20),
                                child: TextButton(

                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.indigo,
                                    ),
                                    onPressed: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) =>Login()));
                                    },
                                    child: const Text("LOGIN",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),)),
                              ),
                            ),

                          ),

                        ],

                      ),

                      Column(

                        children: <Widget>[

                          Container(

                            width: size.width*0.6,
                            child: ClipOval(


                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                                child: TextButton(
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.pinkAccent,
                                    ),
                                    onPressed: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) =>Signup()));
                                    },
                                    child: const Text("SIGN UP",
                                      style: TextStyle(
                                        color: Colors.indigo,
                                      ),)),
                              ),
                            ),

                          ),

                        ],

                      ),

                    ]



                ),
              ],
            )
        )
    );
  }
}

