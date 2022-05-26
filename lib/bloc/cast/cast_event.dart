part of 'cast_bloc.dart';

@immutable
abstract class CastEvent {}

class CastLoadEvent extends CastEvent {
  dynamic id;
  CastLoadEvent(this.id);
}