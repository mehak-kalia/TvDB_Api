import 'package:equatable/equatable.dart';

abstract class MovieEvent extends Equatable {
  const MovieEvent();

  @override
  List<Object> get props => [];
}

class FetchMoviesByGenre extends MovieEvent {
  final int genreId;

  const FetchMoviesByGenre(this.genreId);

  @override
  List<Object> get props => [genreId];
}

class FetchMoreMoviesByGenre extends MovieEvent {
  final int genreId;

  const FetchMoreMoviesByGenre(this.genreId);

  @override
  List<Object> get props => [genreId];
}
