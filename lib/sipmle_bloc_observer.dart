import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SipmleBlocObserver implements BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    //
    debugPrint(
      '- $bloc : Current State => ${change.currentState} | Next State => ${change.nextState}',
    );
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    //
    debugPrint(
      '- $bloc : Current State => ${transition.currentState} | Next State => ${transition.nextState}',
    );
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    //
    debugPrint('- $bloc : The Error => $error => $stackTrace');
  }

  @override
  void onCreate(BlocBase bloc) {
    //
    debugPrint('- Created => $bloc');
  }

  @override
  void onClose(BlocBase bloc) {
    //
    debugPrint('- Closed => $bloc');
  }
  @override
  void onEvent(Bloc bloc, Object? event) {
    //
    debugPrint(
      '- $bloc : Event => $event ',
    );
  }
}
