import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteMoviesScreen extends StatefulWidget {
  @override
  _FavoriteMoviesScreenState createState() => _FavoriteMoviesScreenState();
}

class _FavoriteMoviesScreenState extends State<FavoriteMoviesScreen> {
  late SharedPreferences _preferences;
  List<String> _favoriteMovies = [];
  bool _preferencesLoaded = false; // Track if SharedPreferences is loaded

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      _preferences = prefs;
      _favoriteMovies = _preferences.getStringList('favorites') ?? [];
      setState(() {
        _preferencesLoaded = true; // Mark SharedPreferences as loaded
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Movies'),
        backgroundColor: Colors.red,
      ),
      body: !_preferencesLoaded
          ? Center(child: CircularProgressIndicator(color: Colors.red))
          : _favoriteMovies.isEmpty
          ? Center(child: Text('No favorite movies found'))
          : ListView.builder(
        itemCount: _favoriteMovies.length,
        itemBuilder: (context, index) {
          // You can fetch details of each favorite movie from your API or local storage
          String movieId = _favoriteMovies[index];
          return ListTile(
            title: Text('Favorite Movie $movieId'),
            // Example content, replace with actual movie details
          );
        },
      ),
    );
  }
}
