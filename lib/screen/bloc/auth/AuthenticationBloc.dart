import 'dart:developer';

import 'package:Squirrel_Chat/screen/bloc/auth/AuthenticationEvent.dart';
import 'package:Squirrel_Chat/screen/bloc/auth/AuthenticationState.dart';
import 'package:Squirrel_Chat/screen/bloc/auth/LoginRepository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final LoginRepository loginRepository;

  AuthenticationBloc(
      {@required AuthenticationState initialState,
      @required this.loginRepository})
      : assert(loginRepository != null),
        super(initialState);

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is LoginWithGooglePressed) {
      yield* _mapLoginWithGooglePressedToState();
    } else if (event is LogoutGooglePressed) {
      yield* _mapLogoutGooglePressedToState();
    } else if (event is LoginUserAuthentication) {
      yield* _mapLoginUserAuthenticationToState();
    }
  }

  Stream<AuthenticationState> _mapLoginWithGooglePressedToState() async* {
    try {
      GoogleSignInAccount _loginUser = await loginRepository.signInWithGoogle();
      if (_loginUser != null) {
        yield GoogleLoginSuccessState(
            isUserLoggedIn: true, googleUser: _loginUser);
      } else {
        yield GoogleLoginFailureState(
            error: 'User is null', isUserLoggedIn: false);
      }
    } catch (exc) {
      yield GoogleLoginFailureState(
          error: exc.toString(), isUserLoggedIn: false);
    }
  }

  Stream<AuthenticationState> _mapLogoutGooglePressedToState() async* {
    try {
      GoogleSignInAccount logoutUser = await loginRepository.signOut();

      log(
        '***** Logout User : ${logoutUser.toString()}*****',
        name: this.runtimeType.toString(),
      );

      yield GoogleLogoutSuccessState(isUserLoggedIn: false);
    } catch (exc) {
      yield GoogleLoginFailureState(
          isUserLoggedIn: false, error: exc.toString());
    }
  }

  Stream<AuthenticationState> _mapLoginUserAuthenticationToState() async* {
    try {
      GoogleSignInAccount loggedInUser = await loginRepository.isUserLoggedIn();

      if (loggedInUser != null) {
        log(
          '***** LoggedIn User : ${loggedInUser.displayName}*****',
          name: this.runtimeType.toString(),
        );
        yield GoogleAuthCheckState(
            isUserLoggedIn: true, googleUser: loggedInUser);
      } else {
        log(
          '***** LoggedIn User : ${loggedInUser?.displayName}*****',
          name: this.runtimeType.toString(),
        );
        yield GoogleAuthCheckState(isUserLoggedIn: false);
      }
    } catch (exc) {
      yield GoogleLoginFailureState(
          isUserLoggedIn: false, error: exc.toString());
    }
  }
}
