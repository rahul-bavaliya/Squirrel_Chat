import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    log(
      '*****Event : $event*****',
      name: this.runtimeType.toString(),
    );
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    log(
      '*****Transition : $transition*****',
      name: this.runtimeType.toString(),
    );
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    log('*****Error : $error*****',
        name: this.runtimeType.toString(),
        level: 1,
        sequenceNumber: 1,
        error: error);
    super.onError(bloc, error, stackTrace);
  }
}
