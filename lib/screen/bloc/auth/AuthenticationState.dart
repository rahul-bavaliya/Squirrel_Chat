import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthenticationState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class AuthenticationUninitialized extends AuthenticationState {}

class GoogleLoginFailureState extends AuthenticationState {
  final bool isUserLoggedIn;
  final String error;

  GoogleLoginFailureState({this.error, this.isUserLoggedIn});

  @override
  String toString() {
    return 'GoogleLoginFailureState{isUserLoggedIn: $isUserLoggedIn, error: $error}';
  }
}

class GoogleLoginSuccessState extends AuthenticationState {
  final bool isUserLoggedIn;
  final GoogleSignInAccount googleUser;

  GoogleLoginSuccessState(
      {@required this.googleUser, @required this.isUserLoggedIn});

  @override
  String toString() {
    return 'GoogleLoginSuccessState{isUserLoggedIn: $isUserLoggedIn, googleUser: $googleUser}';
  }
}

class GoogleLogoutSuccessState extends AuthenticationState {
  final bool isUserLoggedIn;
  final GoogleSignInAccount googleUser;

  GoogleLogoutSuccessState({this.googleUser, @required this.isUserLoggedIn});

  @override
  String toString() {
    return 'GoogleLogoutSuccessState{isUserLoggedIn: $isUserLoggedIn, googleUser: $googleUser}';
  }
}

class GoogleAuthCheckState extends AuthenticationState {
  final bool isUserLoggedIn;
  final GoogleSignInAccount googleUser;

  GoogleAuthCheckState({this.googleUser, @required this.isUserLoggedIn});

  @override
  String toString() {
    return 'GoogleAuthCheckState{isUserLoggedIn: $isUserLoggedIn, googleUser: $googleUser}';
  }
}
