import 'dart:developer';
import 'dart:ui';

import 'package:express_test/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:express_test/widgets/cast_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class MovieDetailWidget extends StatefulWidget {
  final int? movieId;
  const MovieDetailWidget({Key? key, this.movieId}) : super(key: key);

  @override
  State<MovieDetailWidget> createState() => _MovieDetailWidgetState();
}

class _MovieDetailWidgetState extends State<MovieDetailWidget> {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieDetailBloc, MovieDetailState>(
        builder: (context, state) {
      if (state is MovieDetailLoadingState) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state is MovieDetailLoadedState) {
        return Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
          body: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Stack(
                  children: [
                    Container(
                      foregroundDecoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                            Theme.of(context).primaryColor.withOpacity(0.3),
                            Theme.of(context).primaryColor,
                          ])),
                      child: Image.network(
                          'https://image.tmdb.org/t/p/original/${state.movieDetail.poster}',
                          width: window.physicalSize.width /
                              window.devicePixelRatio),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: ListTile(
                        title: Text(
                          state.movieDetail.title.toUpperCase(),
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                        subtitle: Text(
                          state.movieDetail.releaseDate,
                          style: const TextStyle(color: Colors.white),
                        ),
                        trailing: Text(
                          state.movieDetail.rating.toString(),
                          style: const TextStyle(
                            color: Color(0xFF58C3BB),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 18,
                      right: 18,
                      top: 64,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: const Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                              size: 28,
                            ),
                          ),
                          const Icon(
                            Icons.favorite_border,
                            color: Colors.white,
                            size: 28,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 16,
                  ),
                  child: Text(
                    state.movieDetail.overview,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Text(
                    'Cast',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
                CastWidget(movieId: state.movieDetail.id,),
              ],
            ),
          ),
        );
      }
      return Center(
        child: Text('Нету детальной страницы'),
      );
    });
  }
}
