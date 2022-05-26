import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:express_test/models/cast_detail.dart';
import 'package:meta/meta.dart';

import '../../services/repository.dart';

part 'cast_detail_event.dart';
part 'cast_detail_state.dart';

class CastDetailBloc extends Bloc<CastDetailEvent, CastDetailState> {
  MovieService repo = MovieService();

  CastDetailBloc(this.repo) : super(CastDetailInitialState()) {
    on<CastDetailLoadEvent>((event, emit) async {
      emit(CastDetailLoadingState());

      try {
        final castDetail = await repo.getCastDetail(event.id);
        emit(CastDetailLoadedState(castDetail: castDetail));
      } catch (e) {
        emit(CastDetailErrorState());
      }
    });
  }
}
