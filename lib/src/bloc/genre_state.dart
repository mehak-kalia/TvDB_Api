import 'package:equatable/equatable.dart';
import '../models/genre.dart';

abstract class GenreState extends Equatable {
  @override
  List<Object?> get props => [];
}

class GenreInitial extends GenreState {}

class GenreLoading extends GenreState {}

class GenreLoaded extends GenreState {
  final List<dynamic> genres;

  GenreLoaded(this.genres);

  @override
  List<Object?> get props => [genres];
}

class GenreError extends GenreState {
  final String message;

  GenreError(this.message);

  @override
  List<Object?> get props => [message];
}
