import 'package:equatable/equatable.dart';

abstract class MovieState extends Equatable {
  const MovieState();

  @override
  List<Object> get props => [];
}

class MovieInitial extends MovieState {}

class MovieLoading extends MovieState {}

class MovieLoaded extends MovieState {
  final List<dynamic> movies;
  final bool hasReachedEnd;

  const MovieLoaded({
    required this.movies,
    required this.hasReachedEnd,
  });

  @override
  List<Object> get props => [movies, hasReachedEnd];

  MovieLoaded copyWith({
    List<dynamic>? movies,
    bool? hasReachedEnd,
  }) {
    return MovieLoaded(
      movies: movies ?? this.movies,
      hasReachedEnd: hasReachedEnd ?? this.hasReachedEnd,
    );
  }
}

class MovieError extends MovieState {
  final String message;

  const MovieError(this.message);

  @override
  List<Object> get props => [message];
}
