import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object?> get props => [];
}

class FetchSearchResults extends SearchEvent {
  final String language;
  final String country;

  FetchSearchResults({
    required this.language,
    required this.country,
  });

  @override
  List<Object?> get props => [language, country];
}

class FetchNextPage extends SearchEvent {
  final String language;
  final String country;
  final int nextPage;

  FetchNextPage({
    required this.language,
    required this.country,
    required this.nextPage,
  });

  @override
  List<Object?> get props => [language, country, nextPage];
}
