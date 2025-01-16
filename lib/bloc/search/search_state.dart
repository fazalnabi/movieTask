part of 'search_bloc.dart';

@immutable
sealed class SearchState {}

final class SearchInitial extends SearchState {}

final class SearchLoaded extends SearchState {
  final List<Movie> filteredMovies;

  SearchLoaded(this.filteredMovies);
}
