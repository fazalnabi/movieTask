part of 'search_bloc.dart';

@immutable
sealed class SearchEvent {}

final class SearchQueryChanged extends SearchEvent {
  final String query;

  SearchQueryChanged(this.query);
}
