part of 'movie_bloc.dart';

@immutable
abstract class MovieState {}

class MoviesInitialState extends MovieState {}

class MoviesLoadingState extends MovieState {}

class MoviesLoadedState extends MovieState {
  List<Movie> movies;

  MoviesLoadedState({required this.movies});
}

class MoviesErrorState extends MovieState {}
