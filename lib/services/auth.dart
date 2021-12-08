import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? _userFromFirebase(User? user)
  {
    return user;
  }
  Stream<User?> get user{
    return _auth.authStateChanges().map(_userFromFirebase);
  }

  Future signupWithMailAndPass(String mail, String pass) async{
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: mail, password: pass);
      User user = result.user!;
      return _userFromFirebase(user);
    }catch(e)
    {
      print(e.hashCode.toString());
      return  null;
    }
  }
  Future loginWithMailAndPass(String mail, String pass) async {
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: mail, password: pass);
      User user = result.user!;
      return _userFromFirebase(user);
    }
    on FirebaseAuthException catch (e) {
      print("why?");
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

}