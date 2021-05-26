import 'dart:developer';

import 'package:Squirrel_Chat/screen/bloc/auth/AuthenticationBloc.dart';
import 'package:Squirrel_Chat/screen/bloc/auth/AuthenticationState.dart';
import 'package:Squirrel_Chat/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'bloc/auth/AuthenticationEvent.dart';
import 'bloc/auth/AuthenticationState.dart';
import 'widgets/dialog.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isUserLoggedIn;

  @override
  void initState() {
    super.initState();
    //Check User is logged in or not.
    context.read<AuthenticationBloc>().add(LoginUserAuthentication());
  }

  @override
  void dispose() {
    super.dispose();
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) => Scaffold(
        key: scaffoldKey,
        body: SafeArea(
          child: Align(
            alignment: Alignment(0, 0),
            child: Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Align(
                      alignment: Alignment(0, 0),
                      child: Container(
                        child: SvgPicture.asset(
                          assetAppLogo,
                        ),
                      ),
                    ),
                    _googleSignInWidget(),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

  Widget _googleSignInWidget() {
    log(
      '*****_googleSignInWidget*****',
      name: this?.runtimeType?.toString(),
    );
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is GoogleLoginSuccessState) {
          _showSnackBar(
              snackMessage: 'Login as ${state?.googleUser?.displayName}',
              snackColor: Colors.green);
          Navigator.of(context).pop();
          setState(() {
            isUserLoggedIn = true;
          });
        } else {
          setState(() {
            isUserLoggedIn = false;
          });
        }
      },
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          log(
            '*****${state.toString()}*****',
            name: this?.runtimeType?.toString(),
          );

          if (state is GoogleLoginSuccessState && state.isUserLoggedIn) {
            log(
              '***** DisplayName : ${state?.googleUser?.displayName}*****',
              name: this?.runtimeType?.toString(),
            );

            return _logoutButton();
          } else if (state is GoogleLogoutSuccessState &&
              !state.isUserLoggedIn) {
            log(
              '***** User logged out successfully.*****',
              name: this?.runtimeType?.toString(),
            );
            return _authWidget();
          } else if (state is GoogleAuthCheckState && state.isUserLoggedIn) {
            log(
              '***** User is already logged in..*****',
              name: this?.runtimeType?.toString(),
            );
            log(
              '***** DisplayName : ${state?.googleUser?.displayName}*****',
              name: this?.runtimeType?.toString(),
            );
            return _authWidget();
          } else {
            return _authWidget();
          }
        },
      ),
    );
  }

  SnackBar _showSnackBar(
      {@required String snackMessage, @required MaterialColor snackColor}) {
    SnackBar snackBar = SnackBar(
      content: Text(snackMessage),
      backgroundColor: snackColor,
    );
    log(
      '***** context : $context*****',
      name: this?.runtimeType?.toString(),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    return snackBar;
  }

  Widget _authWidget() {
    return Align(
      alignment: Alignment(0, 0),
      child: Container(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 7, bottom: 7),
        margin: const EdgeInsets.only(left: 10, right: 10, top: 70, bottom: 7),
        child: googleSignInElevatedButton(),
      ),
    );
  }

  Widget googleSignInElevatedButton() {
    return ElevatedButton(
      onPressed: () {
        _showCustomDialog();
        log(
          '***** IsUserLoggedIn : $isUserLoggedIn*****',
          name: this?.runtimeType?.toString(),
        );
        !isUserLoggedIn
            ? context.read<AuthenticationBloc>().add(LoginWithGooglePressed())
            : context.read<AuthenticationBloc>().add(LogoutGooglePressed());
      },
      style: ElevatedButton.styleFrom(
        primary: Colors.white,
        onPrimary: Colors.black,
        onSurface: Colors.orange,
        shadowColor: Colors.black,
        elevation: 4.0,
        textStyle: TextStyle(fontFamily: 'roboto'),
        padding: const EdgeInsets.only(left: 10, right: 10, top: 7, bottom: 7),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7.0)),
        animationDuration: Duration(milliseconds: 100),
        alignment: Alignment.bottomCenter,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 20,
            height: 20,
            child: SvgPicture.asset(
              assetGLogo,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            signInWithGoogle,
            style: TextStyle(
              fontSize: 17,
            ),
          ),
        ],
      ),
    );
  }

  Widget _logoutButton() {
    return ElevatedButton(
      onPressed: () {
        context.read<AuthenticationBloc>().add(LogoutGooglePressed());
      },
      style: ElevatedButton.styleFrom(
        primary: Colors.white,
        onPrimary: Colors.black,
        onSurface: Colors.orange,
        shadowColor: Colors.black,
        elevation: 4.0,
        textStyle: TextStyle(fontFamily: 'roboto'),
        padding: const EdgeInsets.only(left: 10, right: 10, top: 7, bottom: 7),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7.0)),
        animationDuration: Duration(milliseconds: 100),
        alignment: Alignment.bottomCenter,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 20,
            height: 20,
            child: Icon(Icons.logout),
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            'Logout',
            style: TextStyle(
              fontSize: 17,
            ),
          ),
        ],
      ),
    );
  }

  _showCustomDialog() async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomDialogBox(
              text: progressLoading, widget: LinearProgressIndicator());
        });
  }
}
