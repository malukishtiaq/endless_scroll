import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    if (kDebugMode) {
      print('State changed: ${change.nextState} -> ${change.currentState}');
    }
    super.onChange(bloc, change);
  }
}
