part of 'movie_detail_bloc.dart';

@immutable
abstract class MovieDetailEvent {}

class MovieDetailLoadEvent extends MovieDetailEvent {
  dynamic id;
  MovieDetailLoadEvent(this.id);
}