import 'dart:developer';

import 'package:express_test/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:express_test/widgets/movie_detail_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieDetailScreen extends StatefulWidget {
  final int? movieId;

  const MovieDetailScreen({Key? key, this.movieId}) : super(key: key);

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  @override
  void initState() {
    final MovieDetailBloc movieBloc = BlocProvider.of<MovieDetailBloc>(context);
    if (movieBloc.state is! MovieDetailErrorState) {
      movieBloc.add(MovieDetailLoadEvent(widget.movieId));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MovieDetailBloc, MovieDetailState>(
          builder: (context, state) {
        if (state is MovieDetailLoadingState) {
          log("movie state ${state}");
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is MovieDetailLoadedState) {
          log("movie loaded ${state}");
          return MovieDetailWidget();
        }

        return const Text("Error");
      }),
    );
  }
}
