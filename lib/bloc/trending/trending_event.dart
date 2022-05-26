part of 'trending_bloc.dart';

@immutable
abstract class TrendingEvent {}

class TrendingLoadEvent extends TrendingEvent {
  TrendingLoadEvent();
}
