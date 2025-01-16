import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:tentwentytask/bloc/video_player/video_player_bloc.dart';
import 'package:tentwentytask/config/AppStyles.dart';
import 'package:tentwentytask/models/movie_details/MovieDetailsResponse.dart';
import 'package:tentwentytask/widgets/CustomButton.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerScreen extends StatefulWidget {
  int movieID;
  VideoPlayerScreen({super.key, required this.movieID});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  // String key = 'H7F8_8QfadY';
  YoutubePlayerController? _controller;
  var videoBloc;
  @override
  void initState() {
    super.initState();
    videoBloc = BlocProvider.of<VideoPlayerBloc>(context);
    videoBloc.add(LoadVideoEvent(widget.movieID));
  }

  @override
  void dispose() {
    super.dispose();
    _controller!
        .dispose(); // Dispose the controller when the widget is disposed
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VideoPlayerBloc, VideoPlayerState>(
        builder: (context, state) {
      if (state is VideoLoadingState) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is VideoFailedState) {
        return Center(
          child: Text(state.message),
        );
      } else if (state is VideoLoadedState) {
        final videoKey = state.response.results[0].key;
        print(videoKey);
        // Initialize the controller when a valid video key is available
        if (_controller == null) {
          _controller = YoutubePlayerController(
            initialVideoId: videoKey,
            flags: const YoutubePlayerFlags(
              autoPlay: true,
              mute: false,
            ),
          );
          _controller!.addListener(() {
            if (_controller!.value.playerState == PlayerState.ended) {
              Navigator.pop(context);
            }
          });
        } else if (_controller!.initialVideoId != videoKey) {
          _controller!.load(videoKey); // Dynamically load the new video
        }
        return Scaffold(
          appBar: AppBar(
            title: const Text("Trailer"),
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 12.sp),
                child: SizedBox(
                  width: 100,
                  height: 30,
                  child: CustomButton(
                      isEnabled: true,
                      onClick: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Done',
                        style: kButtonTextStyle,
                      )),
                ),
              )
            ],
          ),
          body: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                YoutubePlayer(
                  controller: _controller!,
                  showVideoProgressIndicator: true, // Show progress bar
                ),
              ],
            ),
          ),
        );
      } else {
        return Container();
      }
    });
  }
}
