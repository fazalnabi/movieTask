part of 'ticket_bloc.dart';

@immutable
sealed class TicketEvent {}

class MovieDateEvent extends TicketEvent{}
