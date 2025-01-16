import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tentwentytask/bloc/details/details_bloc.dart';
import 'package:tentwentytask/bloc/home/home_bloc.dart';
import 'package:tentwentytask/bloc/search/search_bloc.dart';
import 'package:tentwentytask/bloc/ticket/ticket_bloc.dart';
import 'package:tentwentytask/bloc/video_player/video_player_bloc.dart';
import 'package:tentwentytask/bloc/watch/watch_bloc.dart';

class BlocProviders {
  static List<BlocProvider> getBlocs() {
    return [
      BlocProvider<WatchBloc>(create: (BuildContext context) => WatchBloc()),
      BlocProvider<HomeBloc>(create: (BuildContext context) => HomeBloc()),
      BlocProvider<DetailsBloc>(
          create: (BuildContext context) => DetailsBloc()),
      BlocProvider<VideoPlayerBloc>(
          create: (BuildContext context) => VideoPlayerBloc()),
      BlocProvider<TicketBloc>(create: (BuildContext context) => TicketBloc()),
      BlocProvider<SearchBloc>(create: (BuildContext context) => SearchBloc()),
    ];
  }
}
