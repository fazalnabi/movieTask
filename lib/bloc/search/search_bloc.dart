import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tentwentytask/models/movie/Movie.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  List<Movie> allMovies = [];

  SearchBloc() : super(SearchInitial()) {
    on<SearchEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<SearchQueryChanged>((event, emit) {
      final filteredMovies = allMovies
          .where((movie) =>
              movie.title.toLowerCase().contains(event.query.toLowerCase()))
          .toList();

      emit(SearchLoaded(filteredMovies));
    });
  }
}
