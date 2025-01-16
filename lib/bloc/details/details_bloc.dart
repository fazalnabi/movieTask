import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tentwentytask/bloc/watch/watch_bloc.dart';
import 'package:tentwentytask/models/movie_details/MovieDetailsResponse.dart';
import 'package:tentwentytask/network_manager/repository.dart';

part 'details_event.dart';
part 'details_state.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  DetailsBloc() : super(DetailsInitial()) {
    on<DetailsEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<FetchMovieDetailsEvent>((event, emit) async {
      emit(MovieDetailsLoadingState());

      await Repository()
          .getMovieDetails(event.movieID)
          .then((movieResponse) async {
        emit(MovieDetailsLoadedState(movieResponse));
      }).onError((error, stackTrace) {
        print(error);
        emit(MovieDetailsErrorState(
            'Error occurred while fetching movie details'));
      });
    });
  }
}
