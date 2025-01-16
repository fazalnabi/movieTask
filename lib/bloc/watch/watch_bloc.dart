import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tentwentytask/config/NetworkConnectivity.dart';
import 'package:tentwentytask/models/movie/Movie.dart';
import 'package:tentwentytask/network_manager/repository.dart';
import 'package:tentwentytask/repository/database_repo/DatabaseRepo.dart';

import '../../main.dart';

part 'watch_event.dart';
part 'watch_state.dart';

class WatchBloc extends Bloc<WatchEvent, WatchState> {
  List<Movie> movieList = [];
  final DatabaseRepo repository = getIt<DatabaseRepo>();

  WatchBloc() : super(WatchInitial()) {
    on<WatchEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<FetchMovieEvent>((event, emit) async {
      emit(MovieLoadingState());
      try {
        List<Movie> tempList = await repository.getAllMovies();
        print('fazal ${tempList.length}');
      } catch (e) {
        print('error');
      }
      if (await NetworkConnectivity.isConnected()) {
        await Repository().getMoviesList().then((movieResponse) async {
          movieList.addAll(movieResponse.results);
          await repository.addMovies(movieList);
          emit(MovieLoadedState(movieList));
        }).onError((error, stackTrace) {
          emit(MovieLoadedFailureState(
              'Error occurred while fetching movie List'));
        });
      } else {
        movieList.addAll(await repository.getAllMovies());
        emit(MovieLoadedState(movieList));
      }
    });
  }
}
