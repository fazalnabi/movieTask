part of 'ticket_bloc.dart';

@immutable
sealed class TicketState {}

final class TicketInitial extends TicketState {}

class MovieDateState extends TicketState {
  List<MovieDateModel> list;
  MovieDateState(this.list);
}
