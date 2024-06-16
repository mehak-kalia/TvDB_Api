// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:tv_db/src/screens/home.dart';
// import 'package:tv_db/src/screens/movie_screen.dart';
//
//
// class App extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
//       statusBarColor: Colors.transparent,
//       statusBarIconBrightness: Brightness.dark,
//     ));
//
//     return MaterialApp(home: MoviesScreen(), debugShowCheckedModeBanner: false);
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tv_db/src/bloc/theme_bloc.dart';
import 'package:tv_db/src/screens/home.dart';
import 'package:tv_db/src/screens/movie_screen.dart';
import 'package:tv_db/src/bloc/movie_bloc.dart';
import 'package:tv_db/src/bloc/genre_bloc.dart';

import 'package:tv_db/src/providers/tvdb_api.dart';
import 'package:tv_db/src/screens/genres_screen.dart';
import 'package:tv_db/src/screens/splash_screen.dart';

import 'bloc/search_bloc.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider<GenreBloc>(
          create: (context) => GenreBloc(TvdbApi()),
        ),
        BlocProvider<MovieBloc>(
          create: (context) => MovieBloc(TvdbApi()),
        ),
        BlocProvider<SearchBloc>(
          create: (context) => SearchBloc(searchService: SearchService()),
        ),
        BlocProvider<ThemeBloc>(
          create: (context) => ThemeBloc()
        ),      ],
      child: MaterialApp(
        title: 'TVDB Movies',
        home: SplashScreen(), // Start with SplashScreen
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
