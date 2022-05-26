part of 'upcoming_bloc.dart';

@immutable
abstract class UpcomingEvent {}

class UpcomingLoadEvent extends UpcomingEvent {
  UpcomingLoadEvent();
}