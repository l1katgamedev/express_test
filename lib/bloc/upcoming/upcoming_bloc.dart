import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:express_test/models/movie.dart';
import 'package:express_test/services/repository.dart';
import 'package:meta/meta.dart';

part 'upcoming_event.dart';
part 'upcoming_state.dart';

class UpcomingBloc extends Bloc<UpcomingEvent, UpcomingState> {
  MovieService repo = MovieService();
  UpcomingBloc(this.repo) : super(UpcomingInitialState()) {
    on<UpcomingLoadEvent>((event, emit) async {
      emit(UpcomingLoadingState());

      try {
        final List<Movie> _movies = await repo.getUpcomingMovies();
        emit(UpcomingLoadedState(movies: _movies));
      } catch (e) {
        emit(UpcomingErrorState());
      }
    });
  }
}
