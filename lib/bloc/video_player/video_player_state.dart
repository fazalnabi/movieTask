part of 'video_player_bloc.dart';

@immutable
sealed class VideoPlayerState {}

final class VideoPlayerInitial extends VideoPlayerState {}

class VideoLoadingState extends VideoPlayerState {}

class VideoLoadedState extends VideoPlayerState {
  MovieVideoResponse response;
  VideoLoadedState(this.response);
}

class VideoFailedState extends VideoPlayerState {
  String message;
  VideoFailedState(this.message);
}
