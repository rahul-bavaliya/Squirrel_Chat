import 'package:Squirrel_Chat/screen/home_screen.dart';
import 'package:Squirrel_Chat/screen/login_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static final mainRoute = <String, WidgetBuilder>{
    route_login: (context) => LoginScreen(), // LoginScreen
    route_home: (context) => HomeScreen(), // HomeScreen
  };
}

const route_login = '/login';
const route_home = '/home';
