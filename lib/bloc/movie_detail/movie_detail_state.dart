part of 'movie_detail_bloc.dart';

@immutable
abstract class MovieDetailState {}

class MovieDetailInitialState extends MovieDetailState {}

class MovieDetailLoadingState extends MovieDetailState {}

class MovieDetailLoadedState extends MovieDetailState {
  MovieDetail movieDetail;

  MovieDetailLoadedState({required this.movieDetail});
}

class MovieDetailErrorState extends MovieDetailState {}
