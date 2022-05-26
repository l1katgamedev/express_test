part of 'credit_bloc.dart';

@immutable
abstract class CreditState {}

class CreditInitialState extends CreditState {}

class CreditLoadingState extends CreditState {}

class CreditLoadedState extends CreditState {
  List<Credits> credits;

  CreditLoadedState({required this.credits});
}

class CreditErrorState extends CreditState {}