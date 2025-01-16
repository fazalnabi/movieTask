import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tentwentytask/models/movie_dates/MovieDateModel.dart';
import 'package:tentwentytask/repository/date_repo/DatesRepository.dart';

part 'ticket_event.dart';
part 'ticket_state.dart';

class TicketBloc extends Bloc<TicketEvent, TicketState> {
  TicketBloc() : super(TicketInitial()) {
    on<TicketEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<MovieDateEvent>((event, emit) {
      emit(MovieDateState(List.of(DatesRepository().getDateList())));
    });
  }
}
