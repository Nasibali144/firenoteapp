import 'package:firebase_auth/firebase_auth.dart';
import 'package:firenoteapp/pages/sign_in_page.dart';
import 'package:firenoteapp/services/db_service.dart';
import 'package:flutter/cupertino.dart';

class AuthService {
  static final FirebaseAuth auth = FirebaseAuth.instance;

  static Future<User?> signUpUser(String name, String email, String password) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
      print(user.toString());
      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }

    return null;
  }

  static Future<User?> signInUser(String lastname, String firstname, String email, String password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
      DBService.storeString(StorageKeys.UID, user!.uid);
      DBService.storeString(StorageKeys.FIRSTNAME, firstname);
      DBService.storeString(StorageKeys.LASTNAME, lastname);
      print(user.toString());
      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    } catch (e) {
      print(e);
    }

    return null;
  }

  static void signOutUser(BuildContext context) async {
    await auth.signOut();
    Navigator.pushReplacementNamed(context, SignInPage.id);
  }
}