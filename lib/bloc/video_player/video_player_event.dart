part of 'video_player_bloc.dart';

@immutable
sealed class VideoPlayerEvent {}

class LoadVideoEvent extends VideoPlayerEvent {
  int movieId;
  LoadVideoEvent(this.movieId);
}
