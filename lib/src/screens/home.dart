import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_db/src/screens/favorite_screen.dart';
import '../bloc/theme_bloc.dart'; // Import your theme bloc file

import 'search_screen.dart';
import 'genres_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    GenresScreen(),
    SearchScreen(),
    FavoriteMoviesScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeBloc(),
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: themeState.themeData,
            home: Scaffold(
              appBar: AppBar(
                title: Text('TVDB Movies'),
                backgroundColor: Colors.green,
                actions: [
                  IconButton(
                    icon: Icon(Icons.lightbulb),
                    onPressed: () {
                      // Dispatch an event to toggle the theme
                      context.read<ThemeBloc>().add(ThemeEvent());
                    },
                  ),
                ],
              ),
              body: Center(
                child: _widgetOptions.elementAt(_selectedIndex),
              ),
              bottomNavigationBar: BottomNavigationBar(
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.category),
                    label: 'Genres',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.search),
                    label: 'Search',
                  ),

                  BottomNavigationBarItem(
                    icon: Icon(Icons.favorite),
                    label: 'Favorites',
                  ),
                ],
                currentIndex: _selectedIndex,
                selectedItemColor: Colors.green,
                onTap: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
