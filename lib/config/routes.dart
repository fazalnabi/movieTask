import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tentwentytask/config/RoutesName.dart';
import 'package:tentwentytask/models/movie/Movie.dart';
import 'package:tentwentytask/models/movie_details/MovieDetailsResponse.dart';
import 'package:tentwentytask/screens/detail/DetailsScreen.dart';
import 'package:tentwentytask/screens/home/HomeScreen.dart';
import 'package:tentwentytask/screens/review/ReviewScreen.dart';
import 'package:tentwentytask/screens/search/SearchScreen.dart';
import 'package:tentwentytask/screens/select_seat/SelectSeatScreen.dart';
import 'package:tentwentytask/screens/ticket/TicketScreen.dart';
import 'package:tentwentytask/screens/video_player/VideoPlayerScreen.dart';
import 'package:tentwentytask/screens/watch/WatchScreen.dart';

class Routes {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.homeScreen:
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      case RoutesName.detailsScreen:
        {
          var movie = settings.arguments as Movie;
          return MaterialPageRoute(
              builder: (context) => DetailsScreen(
                    movie: movie,
                  ));
        }
      case RoutesName.reviewScreen:
        return MaterialPageRoute(builder: (context) => const ReviewScreen());
      case RoutesName.searchScreen:
        return MaterialPageRoute(builder: (context) => const SearchScreen());
      case RoutesName.selectSeatScreen:
        {
          var movie = settings.arguments as Movie;
          return MaterialPageRoute(
              builder: (context) => SelectSeatScreen(
                    movie: movie,
                  ));
        }

      case RoutesName.watchScreen:
        return MaterialPageRoute(builder: (context) => const WatchScreen());
      case RoutesName.videoPlayerScreen:
        {
          var movieID = settings.arguments as int;
          return MaterialPageRoute(
              builder: (context) => VideoPlayerScreen(
                    movieID: movieID,
                  ));
        }
      case RoutesName.ticketScreen:
        {
          var movie = settings.arguments as Movie;
          return MaterialPageRoute(
              builder: (context) => TicketScreen(
                    movie: movie,
                  ));
        }
    }
  }
}
