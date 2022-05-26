import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:express_test/services/repository.dart';
import 'package:meta/meta.dart';

import '../../models/movie.dart';

part 'movie_event.dart';

part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  MovieService repo = MovieService();

  MovieBloc(this.repo) : super(MoviesInitialState()) {
    on<MoviesLoadEvent>((event, emit) async {
      emit(MoviesLoadingState());

      try {
        final List<Movie> _movies = await repo.getPopularMovies();
        emit(MoviesLoadedState(movies: _movies));
      } catch (e) {
        emit(MoviesErrorState());
      }
    });
  }
}
