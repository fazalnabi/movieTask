part of 'watch_bloc.dart';

@immutable
sealed class WatchEvent {}

class FetchMovieEvent extends WatchEvent {}
