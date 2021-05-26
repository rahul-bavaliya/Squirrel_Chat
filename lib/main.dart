import 'package:Squirrel_Chat/app.dart';
import 'package:Squirrel_Chat/utils/AppBlocObserver.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    Bloc.observer = AppBlocObserver();
    runApp(SquirrelChat());
  });
}
