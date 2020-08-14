import 'package:essf/platform_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

class User {
  User({@required this.uid});
  String uid;
  String email;
  String password;
}

abstract class AuthBase {
  Stream<User> get onAuthStateChanged;

  Future<User> signInwithGoogle();
  Future<User> signInwithFacebook();
  Future<User> createUserWithEmailAndPassword(String email, String password);
  Future<User> signInWithEmailAndPassword(String email, String password);
  Future<void> signout();
  Future<void> sendPasswordResetEmail(String email);
  Future<bool> isEmailVerfied();
}

class Auth implements AuthBase {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User _userFromFirebase(FirebaseUser user) {
    if (user.isEmailVerified == true) {
      return User(uid: user.uid);
    } else if (user.isEmailVerified == false) {
      PlatformAlertDialog(
          title: 'Error',
          content:
              'Please check your email. Issue logging in with your email and password',
          cancelActionText: null,
          defaultActionText: 'ok');
    }
    return null;
  }

  @override
  Stream<User> get onAuthStateChanged {
    return _firebaseAuth.onAuthStateChanged.map(_userFromFirebase);
  }

  @override
  Future<User> signInWithEmailAndPassword(
      String email, String password) async {
    final authResult = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    if (authResult.user.isEmailVerified != null) {
      PlatformAlertDialog(
          title: 'Signed In',
          content: 'You are now logged in',
          cancelActionText: null,
          defaultActionText: 'ok');
    } else if (authResult.user.isEmailVerified == null)
      PlatformAlertDialog(
          title: 'Error',
          content:
              'Please check your email verification. Issue logging in with your email and password',
          cancelActionText: null,
          defaultActionText: 'ok');

    return _userFromFirebase(authResult.user);
  }

  @override
  Future<User> createUserWithEmailAndPassword(
    String email,
    String password,
  ) async {
    assert(email != null);
    assert(password != null);

    try {
      final authResult = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      if (authResult != null) {
        authResult.user.sendEmailVerification();
      }
      return _userFromFirebase(authResult.user);
    } catch (error) {
      PlatformAlertDialog(
          title: 'Error',
          content: error.toString(),
          cancelActionText: null,
          defaultActionText: 'ok');
    }
    return null;
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    assert(email != null);
 
     return await _firebaseAuth.sendPasswordResetEmail(email: email);
   
  }

  @override
  Future<User> signInwithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount googleAccount = await googleSignIn.signIn();
    if (googleAccount != null) {
      final GoogleSignInAuthentication googleAuth =
          await googleAccount.authentication;
      if (googleAuth.accessToken != null && googleAuth.idToken != null) {
        final authResult = await _firebaseAuth.signInWithCredential(
          GoogleAuthProvider.getCredential(
            idToken: googleAuth.idToken,
            accessToken: googleAuth.accessToken,
          ),
        );

        return _userFromFirebase(authResult.user);
      } else {
        throw PlatformException(
          code: 'ERROR_Missing_Auth_token',
          message: 'Missing google auth token',
        );
      }
    } else {
      throw PlatformException(
        code: 'ERROR_ABORTED_BY_USER',
        message: 'Sign in aborted by user',
      );
    }
  }

  @override
  Future<User> signInwithFacebook() async {
    final facebookLogin = FacebookLogin();
    facebookLogin.loginBehavior = FacebookLoginBehavior.webViewOnly;
    final result = await facebookLogin.logInWithReadPermissions(
      ['Public_profile'],
    );
    if (result.accessToken != null) {
      final authResult = await _firebaseAuth.signInWithCredential(
        FacebookAuthProvider.getCredential(
          accessToken: result.accessToken.token,
        ),
      );
      return _userFromFirebase(authResult.user);
    } else {
      throw PlatformException(
          code: 'Error_Aborted_by_user', message: 'Sign in aborted by user');
    }
  }

  @override
  Future<void> signout() async {
    await _firebaseAuth.signOut();
    final googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    final facebookLogin = FacebookLogin();
    await facebookLogin.logOut();
    await _firebaseAuth.signOut();
  }

  @override
  Future<bool> isEmailVerfied() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    try {
      if (user.isEmailVerified != false) {
        await user.reload();
        user = await _firebaseAuth.currentUser();
        return user.isEmailVerified;
      } else if (user.isEmailVerified == false) {
        print('error');
      }
      return user.isEmailVerified == false;
    } catch (e) {
      PlatformAlertDialog(
          title: 'Error',
          content: e.toString(),
          cancelActionText: null,
          defaultActionText: 'ok');
    }
    return null;
  }
}
