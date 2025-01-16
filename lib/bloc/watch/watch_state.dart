part of 'watch_bloc.dart';

@immutable
sealed class WatchState {}

final class WatchInitial extends WatchState {}

class MovieLoadingState extends WatchState {}

class MovieLoadedState extends WatchState {
  List<Movie> moviesList;
  MovieLoadedState(this.moviesList);
}

class MovieLoadedFailureState extends WatchState {
  String failureMessage;

  MovieLoadedFailureState(this.failureMessage);
}
