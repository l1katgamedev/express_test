part of 'cast_bloc.dart';

@immutable
abstract class CastState {}

class CastInitialState extends CastState {}

class CastLoadingState extends CastState {}

class CastLoadedState extends CastState {
  List<Cast> cast;

  CastLoadedState({required this.cast});
}

class MoviesErrorState extends CastState {}
