import 'package:Squirrel_Chat/utils/colors.dart';
import 'package:Squirrel_Chat/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'screen/bloc/auth/AuthenticationBloc.dart';
import 'screen/bloc/auth/AuthenticationState.dart';
import 'screen/bloc/auth/LoginRepository.dart';
import 'screen/login_screen.dart';
import 'utils/palette.dart';

class SquirrelChat extends StatefulWidget {
  @override
  State<SquirrelChat> createState() => _SquirrelChatState();
}

class _SquirrelChatState extends State<SquirrelChat> {
  final LoginRepository _loginRepo = LoginRepository();
  AuthenticationBloc _authBloc;

  @override
  Widget build(BuildContext context) => MaterialApp(
      title: "Squirrel Chat",
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      routes: Routes.mainRoute,
      theme: ThemeData(
        primarySwatch: generateMaterialColor(Palette.primary),
      ),
      home: BlocProvider(create: (_) => _authBloc, child: LoginScreen()));

  @override
  void initState() {
    super.initState();
    _authBloc = AuthenticationBloc(
        initialState: AuthenticationUninitialized(),
        loginRepository: _loginRepo);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
