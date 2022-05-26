import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/cast.dart';
import '../../services/repository.dart';

part 'cast_event.dart';
part 'cast_state.dart';

class CastBloc extends Bloc<CastEvent, CastState> {
  MovieService repo = MovieService();

  CastBloc(this.repo) : super(CastInitialState()) {
    on<CastLoadEvent>((event, emit) async {
      emit(CastLoadingState());
      try {
        final List<Cast> _cast = await repo.getCast(event.id);
        emit(CastLoadedState(cast: _cast));
      } catch (e) {
        emit(MoviesErrorState());
      }
    });
  }
}
