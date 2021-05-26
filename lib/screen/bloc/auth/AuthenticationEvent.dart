import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class AuthenticationEvent extends Equatable {
  AuthenticationEvent([List props = const []]) : super();
}

class LoginWithGooglePressed extends AuthenticationEvent {
  @override
  String toString() => 'LoginWithGooglePressed';

  @override
  get props => throw UnimplementedError();
}

class LogoutGooglePressed extends AuthenticationEvent {
  @override
  String toString() => 'LogoutGooglePressed';

  @override
  get props => throw UnimplementedError();
}

class LoginUserAuthentication extends AuthenticationEvent {
  @override
  String toString() => 'LoginUserAuthentication';

  @override
  get props => throw UnimplementedError();
}
