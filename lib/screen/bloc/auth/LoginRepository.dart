import 'dart:async';
import 'dart:developer';

import 'package:google_sign_in/google_sign_in.dart';

class LoginRepository {
  final GoogleSignIn _googleSignIn;
  GoogleSignInAccount currentUser;

  LoginRepository({GoogleSignIn googleSignin})
      : _googleSignIn = googleSignin ?? GoogleSignIn();

  Future<GoogleSignInAccount> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    currentUser = googleUser;
    return currentUser;
  }

  Future<GoogleSignInAccount> signOut() async {
    return await _googleSignIn.signOut();
  }

  Future<bool> isSignedIn() async {
    return await _googleSignIn.isSignedIn();
  }

  Future<GoogleSignInAccount> getUser() async {
    if (isSignedIn() as bool) {
      if (currentUser == null)
        currentUser = await _googleSignIn.signInSilently();
    } else {
      currentUser = await _googleSignIn.signIn();
    }
    return currentUser;
  }

  Future<GoogleSignInAccount> isUserLoggedIn() async {
    GoogleSignInAccount _currentUser;
    try {
      _googleSignIn?.onCurrentUserChanged
          ?.listen((GoogleSignInAccount account) {
        if (account != null) {
          _currentUser = account;
        }
      });
      _currentUser = await _googleSignIn?.signInSilently();
    } catch (exception) {
      log('*****$exception*****',
          name: this?.runtimeType?.toString(), error: exception);
    }
    return _currentUser;
  }
}
