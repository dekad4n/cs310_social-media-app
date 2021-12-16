import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sucial_cs310_project/services/user_service.dart';
import 'package:sucial_cs310_project/widgets/alert.dart';

class AuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? _userFromFirebase(User? user)
  {
    return user;
  }
  Stream<User?> get user{
    return _auth.authStateChanges().map(_userFromFirebase);
  }

  Future signupWithMailAndPass(String mail, String pass, String uname) async{
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: mail, password: pass);
      User user = result.user!;
      UsersService().addUser(uname,user.uid);
      return _userFromFirebase(user);
    }catch(e)
    {
      print(e.hashCode.toString());
      return  null;
    }
  }
  Future loginWithMailAndPass(String mail, String pass, BuildContext context) async {
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: mail, password: pass);
      User user = result.user!;
      return _userFromFirebase(user);
    }
    on FirebaseAuthException catch (e) {
      showAlertScreen(context, "Wrong password or lost connection", "Try again");
      return null;
      }
    catch(e)
    {
      return null;
    }

  }
  Future signOut() async
  {
    try{
      return await _auth.signOut();
    }catch (e){
      return null;
    }
  }
  Future signInWithGoogle() async {
    // Trigger the authentication flow

    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    UserCredential result =  await FirebaseAuth.instance.signInWithCredential(credential);
    User? user =  result.user;
    return _userFromFirebase(user);
  }
  Future<bool> changePassword(String crrPass, String newPass) async{
    bool isSuccess = false;
    final user = _auth.currentUser;
    final credentials = EmailAuthProvider.credential(
        email: user!.email!,
        password: crrPass
    );

    await user.reauthenticateWithCredential(credentials).then((value) async{
      await user.updatePassword(newPass).then((value)
          {
            isSuccess = true;
          }).catchError((error){
        isSuccess =  false;
      });
    }).catchError((error) {
      isSuccess = false;
    });  // end of catch
    return isSuccess;
  } // end of function
}