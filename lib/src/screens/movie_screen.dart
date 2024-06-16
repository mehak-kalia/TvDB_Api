import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../bloc/movie_bloc.dart';
import '../bloc/movie_event.dart';
import '../bloc/movie_state.dart';
import 'favorite_screen.dart'; // Import the FavoriteMoviesScreen

class MoviesScreen extends StatefulWidget {
  final int genreId;

  MoviesScreen({required this.genreId});

  @override
  _MoviesScreenState createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  final ScrollController _scrollController = ScrollController();
  late MovieBloc _movieBloc;
  late SharedPreferences _preferences; // SharedPreferences instance
  bool _preferencesLoaded = false; // Track if SharedPreferences is loaded

  @override
  void initState() {
    super.initState();
    _movieBloc = BlocProvider.of<MovieBloc>(context);
    _movieBloc.add(FetchMoviesByGenre(widget.genreId));

    _scrollController.addListener(_onScroll);

    // Initialize SharedPreferences instance
    SharedPreferences.getInstance().then((prefs) {
      _preferences = prefs;
      setState(() {
        _preferencesLoaded = true; // Mark SharedPreferences as loaded
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      _movieBloc.add(FetchMoreMoviesByGenre(widget.genreId));
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    return currentScroll >= maxScroll - 200;
  }

  // Method to toggle movie favorite status
  Future<void> _toggleFavorite(String movieId) async {
    if (!_preferencesLoaded) return; // Ensure SharedPreferences is loaded

    List<String> favorites = _preferences.getStringList('favorites') ?? [];

    if (favorites.contains(movieId)) {
      favorites.remove(movieId);
    } else {
      favorites.add(movieId);
    }

    await _preferences.setStringList('favorites', favorites);
    setState(() {}); // Refresh UI after favorites update
  }

  // Method to check if a movie is favorite
  bool _isFavorite(String movieId) {
    if (!_preferencesLoaded) return false; // Ensure SharedPreferences is loaded

    List<String> favorites = _preferences.getStringList('favorites') ?? [];
    return favorites.contains(movieId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movies by Genre'),
        backgroundColor: Colors.green,
      ),
      body: BlocBuilder<MovieBloc, MovieState>(
        builder: (context, state) {
          if (state is MovieInitial) {
            return Center(child: CircularProgressIndicator(color: Colors.green));
          } else if (state is MovieLoading) {
            return Center(child: CircularProgressIndicator(color: Colors.green));
          } else if (state is MovieLoaded) {
            return ListView.builder(
              controller: _scrollController,
              itemCount: state.hasReachedEnd ? state.movies.length : state.movies.length + 1,
              itemBuilder: (context, index) {
                if (index < state.movies.length) {
                  final movie = state.movies[index];
                  String movieUrl =
                      "https://image.tmdb.org/t/p/w370_and_h556_bestv2/aMpyrCizvSdc0UIMblJ1srVgAEF.jpg";
                  String movieId = movie['id'].toString(); // Assuming movie['id'] exists
                  return ListTile(
                    leading: movie['image'] != null
                        ? Image.network(movieUrl, width: 50, height: 75, fit: BoxFit.cover)
                        : Icon(Icons.movie),
                    title: Text(movie['name'] ?? 'No name'),
                    subtitle: Text('Year: ${movie['year'] ?? 'No year'}'),
                    trailing: IconButton(
                      icon: _isFavorite(movieId) ? Icon(Icons.favorite, color: Colors.red) : Icon(Icons.favorite_border),
                      onPressed: () => _toggleFavorite(movieId),
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text(movie['name'] ?? 'No name'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                movie['image'] != null
                                    ? Image.network("https://image.tmdb.org/t/p/w370_and_h556_bestv2/aMpyrCizvSdc0UIMblJ1srVgAEF.jpg")
                                    : Icon(Icons.movie, size: 100),
                                SizedBox(height: 10),
                                Text('Score: ${movie['score'] ?? 'No score'}'),
                                SizedBox(height: 10),
                                Text('Overview: ${movie['overviewTranslations']?.first ?? 'No overview'}'),
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text('Close'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  );
                } else {
                  return Center(child: CircularProgressIndicator(color: Colors.green));
                }
              },
            );
          } else if (state is MovieError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FavoriteMoviesScreen(),
            ),
          );
        },
        child: Icon(Icons.favorite),
        backgroundColor: Colors.red,
      ),
    );
  }
}
