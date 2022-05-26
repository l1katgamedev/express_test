import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:express_test/models/movie.dart';
import 'package:express_test/services/repository.dart';
import 'package:meta/meta.dart';

part 'trending_event.dart';
part 'trending_state.dart';

class TrendingBloc extends Bloc<TrendingEvent, TrendingState> {
  MovieService repo = MovieService();

  TrendingBloc(this.repo) : super(TrendingInitialState()) {
    on<TrendingLoadEvent>((event, emit) async {
      emit(TrendingLoadingState());

      try {
        final List<Movie> _movies = await repo.getTrendingMovies();
        emit(TrendingLoadedState(movies: _movies));
      } catch (e) {
        emit(TrendingErrorState());
      }
    });
  }
}
