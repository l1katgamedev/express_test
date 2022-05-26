part of 'trending_bloc.dart';

@immutable
abstract class TrendingState {}

class TrendingInitialState extends TrendingState {}

class TrendingLoadingState extends TrendingState {}

class TrendingLoadedState extends TrendingState {
  List<Movie> movies;

  TrendingLoadedState({required this.movies});
}

class TrendingErrorState extends TrendingState {}
