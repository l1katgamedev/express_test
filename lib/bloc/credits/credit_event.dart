part of 'credit_bloc.dart';

@immutable
abstract class CreditEvent {}

class CreditLoadEvent extends CreditEvent {
  dynamic id;
  CreditLoadEvent(this.id);
}