import 'package:essf/platform_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PlatformExceptionAlertDialog extends PlatformAlertDialog{
  PlatformExceptionAlertDialog({@required String title,
  @required PlatformException exception})

  : super(
    title: title,
    content: _message(exception),
    defaultActionText: 'ok',
    cancelActionText:null

  );
  static String _message(PlatformException exception){
    return _errors[exception.code]??exception.message;
  }

  static Map< String, String> _errors={
    'ERROR_WEAK_PASSWORD' : 'Check your password Strength',
  ///   • `ERROR_INVALID_EMAIL` - If the email address is malformed.
 'ERROR_EMAIL_ALREADY_IN_USE' : ' email is already in use by a different account',
  ///  ///   • `ERROR_INVALID_EMAIL` - If the [email] address is malformed.
  ///   • `ERROR_USER_NOT_FOUND` - If there is no user corresponding to the given [email] address.
  'ERROR_NOT_ALLOWED': 'Check if your email is authorised.',
  ///      accounts are not enabled. Enable them in the Auth section of the
  ///      Firebase console.
  ///   • `ERROR_DISABLED` - Indicates the user's account is disabled.
  ///   • `ERROR_INVALID` - Indicates the email address is invalid.
'ERROR_INVALID_CREDENTIAL' : 'Email address is malformed.' ,
'ERROR_INVALID_EMAIL': 'The email is not valid',
 
'ERROR_USER_NOT_FOUND':  'User not found',
  ///   • `ERROR_USER_DISABLED` - If the user has been disabled (for example, in the Firebase console)
  ///   • `ERROR_TOO_MANY_REQUESTS` - If there was too many attempts to sign in as this user.
  'ERROR_OPERATION_NOT_ALLOWED':  'Email and Password Accounts are not enabled',
  //ERROR_USER_DISABLED` - If the user has been disabled (for example, in the Firebase console)
 'ERROR_ACCOUNT_EXISTS_WITH_DIFFERENT_CREDENTIAL' : 'Please check your credential',
  ///       Resolve this case by calling [fetchSignInMethodsForEmail] and then asking the user to sign in using one of them.
  ///       This error will only be thrown if the "One account per email address" setting is enabled in the Firebase console (recommended).
  ///  * `ERROR_OPERATION_NOT_ALLOWED` - Indicates that Google accounts are not enabled.
  ///  * `ERROR_INVALID_ACTION_CODE` - If the action code in the link is malformed, expired, or has already been used.
  
  };
}
