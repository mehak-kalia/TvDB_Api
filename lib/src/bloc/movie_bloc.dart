import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../providers/tvdb_api.dart';
import 'movie_event.dart';
import 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final TvdbApi api;

  MovieBloc(this.api) : super(MovieInitial());

  @override
  Stream<MovieState> mapEventToState(MovieEvent event) async* {
    if (event is FetchMoviesByGenre) {
      yield* _mapFetchMoviesByGenreToState(event);
    } else if (event is FetchMoreMoviesByGenre) {
      yield* _mapFetchMoreMoviesByGenreToState(event);
    }
  }

  Stream<MovieState> _mapFetchMoviesByGenreToState(FetchMoviesByGenre event) async* {
    yield MovieLoading();
    try {
      final movies = await api.fetchMoviesByGenre(event.genreId);
      yield MovieLoaded(movies: movies, hasReachedEnd: false);
    } catch (e) {
      yield MovieError(e.toString());
    }
  }
// Pagination Logic
  Stream<MovieState> _mapFetchMoreMoviesByGenreToState(FetchMoreMoviesByGenre event) async* {
    final currentState = state;
    if (currentState is MovieLoaded) {
      try {
        final currentPage = currentState.movies.length ~/ 20 + 1; // Assuming itemsPerPage is 20
        final newMovies = await api.fetchMoviesByGenre(event.genreId, page: currentPage);
        yield newMovies.isEmpty
            ? currentState.copyWith(hasReachedEnd: true)
            : MovieLoaded(
          movies: currentState.movies + newMovies,
          hasReachedEnd: false,
        );
      } catch (e) {
        yield MovieError(e.toString());
      }
    }
  }
}
