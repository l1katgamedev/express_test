part of 'upcoming_bloc.dart';

@immutable
abstract class UpcomingState {}

class UpcomingInitialState extends UpcomingState {}

class UpcomingLoadingState extends UpcomingState {}

class UpcomingLoadedState extends UpcomingState {
  List<Movie> movies;

  UpcomingLoadedState({required this.movies});
}

class UpcomingErrorState extends UpcomingState {}

