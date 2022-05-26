import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:express_test/models/movie_detail.dart';
import 'package:express_test/services/repository.dart';
import 'package:meta/meta.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  MovieService repo = MovieService();

  MovieDetailBloc(this.repo) : super(MovieDetailInitialState()) {
    on<MovieDetailLoadEvent>((event, emit) async {
      emit(MovieDetailLoadingState());

      try {
        final moviesDetail = await repo.getMovieDetail(event.id);
        emit(MovieDetailLoadedState(movieDetail: moviesDetail));
      } catch (e) {
        emit(MovieDetailErrorState());
      }
    });
  }
}
