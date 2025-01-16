part of 'details_bloc.dart';

@immutable
sealed class DetailsState {}

final class DetailsInitial extends DetailsState {}

class MovieDetailsLoadingState extends DetailsState {}

class MovieDetailsLoadedState extends DetailsState {
  MovieDetailsResponse movieDetails;
  MovieDetailsLoadedState(this.movieDetails);
}

class MovieDetailsErrorState extends DetailsState {
  String errorMessage;
  MovieDetailsErrorState(this.errorMessage);
}
