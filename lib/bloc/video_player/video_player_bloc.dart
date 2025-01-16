import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tentwentytask/models/movie_video/MovieVideoResponse.dart';
import 'package:tentwentytask/network_manager/repository.dart';

part 'video_player_event.dart';
part 'video_player_state.dart';

class VideoPlayerBloc extends Bloc<VideoPlayerEvent, VideoPlayerState> {
  VideoPlayerBloc() : super(VideoPlayerInitial()) {
    on<VideoPlayerEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<LoadVideoEvent>((event, emit) async {
      emit(VideoLoadingState());

      await Repository()
          .getMovieVideos(event.movieId)
          .then((movieResponse) async {
        emit(VideoLoadedState(movieResponse));
      }).onError((error, stackTrace) {
        emit(VideoFailedState('Error occurred while fetching movie videos'));
      });
    });
  }
}
