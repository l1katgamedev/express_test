part of 'cast_detail_bloc.dart';

@immutable
abstract class CastDetailState {}

class CastDetailInitialState extends CastDetailState {}

class CastDetailLoadingState extends CastDetailState {}

class CastDetailLoadedState extends CastDetailState {
  CastDetail castDetail;

  CastDetailLoadedState({required this.castDetail});
}

class CastDetailErrorState extends CastDetailState {}
