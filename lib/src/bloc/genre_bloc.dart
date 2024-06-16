import 'package:bloc/bloc.dart';
import 'genre_event.dart';
import 'genre_state.dart';
import '../providers/tvdb_api.dart';

class GenreBloc extends Bloc<GenreEvent, GenreState> {
  final TvdbApi api;

  GenreBloc(this.api) : super(GenreInitial()) {
    on<FetchGenres>(_onFetchGenres);
  }

  void _onFetchGenres(FetchGenres event, Emitter<GenreState> emit) async {
    emit(GenreLoading());
    try {
      final genres = await api.fetchGenres();
      emit(GenreLoaded(genres));
    } catch (e) {
      emit(GenreError(e.toString()));
    }
  }
}
