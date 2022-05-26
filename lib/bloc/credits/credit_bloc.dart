import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:express_test/models/credits.dart';
import 'package:meta/meta.dart';

import '../../services/repository.dart';

part 'credit_event.dart';
part 'credit_state.dart';

class CreditBloc extends Bloc<CreditEvent, CreditState> {
  MovieService repo = MovieService();

  CreditBloc(this.repo) : super(CreditInitialState()) {
    on<CreditLoadEvent>((event, emit) async {

      emit(CreditLoadingState());

      try {
        final List<Credits> credit = await repo.getCredits(event.id);
        log("credit $credit");
        emit(CreditLoadedState(credits: credit));
      } catch (e) {
        emit(CreditErrorState());
      }
    });
  }
}
