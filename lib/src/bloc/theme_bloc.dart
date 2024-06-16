import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum ThemeType { Light, Dark }

class ThemeEvent {}

class ThemeState {
  final ThemeData themeData;

  ThemeState(this.themeData);
}

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState(ThemeData.light()));

  @override
  Stream<ThemeState> mapEventToState(ThemeEvent event) async* {
    if (event is ThemeEvent) {
      yield ThemeState(state.themeData.brightness == Brightness.light
          ? ThemeData.dark()
          : ThemeData.light());
    }
  }
}
