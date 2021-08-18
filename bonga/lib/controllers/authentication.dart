import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Authentication {
  static Future<void> registerUser(String emailAddress, String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
        Fluttertoast.showToast(msg: 'Email verification link sent');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Fluttertoast.showToast(msg: 'Please use a stronger password.');
      } else if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(msg: 'This email address is already registered');
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<void> loginUser(String emailAddress, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(msg: 'User does not exist');
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(msg: 'Incorrect password. Try again');
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
