import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/genre_bloc.dart';
import '../bloc/genre_event.dart';
import '../bloc/genre_state.dart';
import 'package:tv_db/src/screens/movie_screen.dart';


class GenresScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<GenreBloc, GenreState>(
          builder: (context, state) {
            if (state is GenreInitial) {
              context.read<GenreBloc>().add(FetchGenres());
              return Center(child: CircularProgressIndicator(color: Colors.green,));
            } else if (state is GenreLoading) {
              return Center(child: CircularProgressIndicator(color: Colors.green,));
            } else if (state is GenreLoaded) {
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // Changed to 3 columns
                  childAspectRatio: 1.0, // Ensures square tiles
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: state.genres.length,
                itemBuilder: (context, index) {
                  final genre = state.genres[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MoviesScreen(genreId: genre['id']),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(
                            200, 230, 201, 0.6392156862745098), // Pastel color
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        genre['name'].toUpperCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              );
            } else if (state is GenreError) {
              return Center(child: Text('Error: ${state.message}'));
            }
            return Container();
          },
        ),
      ),
    );
  }
}
