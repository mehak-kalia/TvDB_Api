import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_db/src/bloc/search_event.dart';
import 'package:tv_db/src/bloc/search_state.dart';
import 'package:tv_db/src/providers/tvdb_api.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchService searchService;
  List<dynamic> allResults = [];
  int currentPage = 1;
  bool hasReachedEnd = false;

  SearchBloc({required this.searchService}) : super(SearchInitial());

  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    if (event is FetchSearchResults) {
      yield* _mapFetchSearchResultsToState(event);
    } else if (event is FetchNextPage) {
      yield* _mapFetchNextPageToState(event);
    }
  }

  Stream<SearchState> _mapFetchSearchResultsToState(
      FetchSearchResults event) async* {
    try {
      final results = await searchService.fetchSearchResults(
        language: event.language,
        country: event.country,
        page: 1,
        perPage: 20, // Example perPage value, adjust as needed
      );
      allResults = results['data'];
      currentPage = results['currentPage'];
      final totalPages = results['totalPages'];
      hasReachedEnd = currentPage >= totalPages;

      yield SearchLoaded(results: allResults);
    } catch (e) {
      yield SearchError(message: 'Failed to fetch results: $e');
    }
  }

  Stream<SearchState> _mapFetchNextPageToState(FetchNextPage event) async* {
    try {
      if (hasReachedEnd) {
        yield state;
        return;
      }

      final nextPage = event.nextPage;
      final results = await searchService.fetchSearchResults(
        language: event.language,
        country: event.country,
        page: nextPage,
        perPage: 20, // Example perPage value, adjust as needed
      );
      allResults.addAll(results['data']);
      currentPage = results['currentPage'];
      final totalPages = results['totalPages'];
      hasReachedEnd = currentPage >= totalPages;

      yield SearchLoaded(results: List.from(allResults));
    } catch (e) {
      yield SearchError(message: 'Failed to fetch next page: $e');
    }
  }
}
