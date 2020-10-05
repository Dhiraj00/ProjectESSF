import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:essf/adminscreens/adminpage.dart';
import 'package:essf/firestore/Firestore.dart';
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

  Future<void> signInwithGoogle(BuildContext context);
  Future<void> signInWithFacebook(BuildContext context);
  Future<void> createUserWithEmailAndPassword(
      BuildContext context, String name, String email, String password);
  Future<void> signInWithEmailAndPassword(
      BuildContext context, String email, String password);
  Future<void> signout();
  Future<void> sendPasswordResetEmail(String email);
  Future<bool> isEmailVerfied();
  Future<FirebaseUser> getCurrentUser();
  
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

  static final FacebookLogin facebookSignIn = new FacebookLogin();
  String _message = 'Log in/out by pressing the buttons below.';

  @override
  Future<void> signInWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    final authResult = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    if (await getCurrentUser() != null) {
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
    }
    return _userFromFirebase(authResult.user);
  }

  @override
  Future createUserWithEmailAndPassword(
    BuildContext context,
    String name,
    String email,
    String password,
  ) async {
    assert(email != null);
    assert(password != null);
    assert(name != null);

    try {
      AuthResult authResult = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = authResult.user;
      if (authResult != null) {
        authResult.user.sendEmailVerification();
        await DatabaseManager().createUserData(name, user.email,user.uid);

        return user;
      }
    } catch (error) {
      PlatformAlertDialog(
          title: 'Error',
          content: error.toString(),
          cancelActionText: null,
          defaultActionText: 'ok');
    }
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    assert(email != null);

    return await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  @override
  Future<void> signInwithGoogle(context) async {
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
      }
      return null;
    } else {
      throw PlatformException(
        code: 'ERROR_ABORTED_BY_USER',
        message: 'Sign in aborted by user',
      );
    }
  }

  Future<void> signInWithFacebook(context) async {
    final FacebookLoginResult authResult =
        await facebookSignIn.logInWithReadPermissions(['email']);

    switch (authResult.status) {
      case FacebookLoginStatus.loggedIn:
        final FacebookAccessToken accessToken = authResult.accessToken;
        _showMessage('''
         Logged in!
         
         Token: ${accessToken.token}
         User id: ${accessToken.userId}
         Expires: ${accessToken.expires}
         Permissions: ${accessToken.permissions}
         Declined permissions: ${accessToken.declinedPermissions}
         ''');
        break;
      case FacebookLoginStatus.cancelledByUser:
        _showMessage('Login cancelled by the user.');
        break;
      case FacebookLoginStatus.error:
        _showMessage('Something went wrong with the login process.\n'
            'Here\'s the error Facebook gave us: ${authResult.errorMessage}');
        break;
    }
    return null;
  }

  void _showMessage(String message) {
    _message = message;
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
    return user.isEmailVerified;
  }

  @override
  Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user;
  }
}

  authorizeAccess(BuildContext context){
    
      Firestore.instance.collection('/users').where('uid',isEqualTo:getCurrentUser().uid).getDocuments().then((docs){if(docs.documents[0].exists){if (docs.documents[0].data['role']=='admin'){
              Navigator.of(context).push(new MaterialPageRoute(
                builder:(BuildContext context)=>new AdminHome(
      
                )
              ));
            } 
            else{
              print('unAuthorized');
            }
              
            }}
            );
        }
      
      getCurrentUser() async {
         FirebaseUser user = await FirebaseAuth.instance.currentUser();
         
    return user.uid;
}

