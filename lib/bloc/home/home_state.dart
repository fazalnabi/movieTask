part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}
class BottomBarClickState extends HomeState {
  int index;
  BottomBarClickState(this.index);
}