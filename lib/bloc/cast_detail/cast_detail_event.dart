part of 'cast_detail_bloc.dart';

@immutable
abstract class CastDetailEvent {}

class CastDetailLoadEvent extends CastDetailEvent {
  dynamic id;
  CastDetailLoadEvent(this.id);
}