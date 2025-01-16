part of 'details_bloc.dart';

@immutable
sealed class DetailsEvent {}

class FetchMovieDetailsEvent extends DetailsEvent {
  int movieID;
  FetchMovieDetailsEvent(this.movieID);
}
