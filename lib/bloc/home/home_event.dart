part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class BottomBarTapEvent extends HomeEvent {
  int index;
  BottomBarTapEvent(this.index);
}
