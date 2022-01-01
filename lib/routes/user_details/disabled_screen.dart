import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sucial_cs310_project/services/auth.dart';
import 'package:sucial_cs310_project/services/user_service.dart';
import 'package:sucial_cs310_project/utils/styles.dart';

class DisabledScreen extends StatefulWidget {
  const DisabledScreen({Key? key}) : super(key: key);

  @override
  _DisabledScreenState createState() => _DisabledScreenState();
}

class _DisabledScreenState extends State<DisabledScreen> {
  final AuthService _auth = AuthService();
  UsersService usersService = UsersService();
  
  @override
  void initState() {
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text(
                "Your account is disabled...",
              style: mediumExplanation,
            )
            ,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              TextButton(
                  onPressed: (){
                    _auth.signOut();
                    Navigator.pushNamed(context, '/login');
                  },
                  child: const Text("Login to different account")
              ),
              TextButton(
                  onPressed: (){
                    usersService.enableUser(user!.uid);
                    Navigator.pushNamed(context, '/feed');
                  },
                  child: const Text("Enable account")
              ),
            ],
          )
        ],
      ),
    );
  }
}
