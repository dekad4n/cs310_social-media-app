import 'package:firebase_auth/firebase_auth.dart';

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
      return  null;
    }
  }

}