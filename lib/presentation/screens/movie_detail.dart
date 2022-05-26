import 'dart:ui';

import 'package:express_test/bloc/cast/cast_bloc.dart';
import 'package:express_test/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:express_test/presentation/screens/cast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieDetailScreen extends StatelessWidget {
  final int? movieId;

  const MovieDetailScreen({super.key, this.movieId});

  @override
  Widget build(BuildContext context) {
    final movieDetailBloc = BlocProvider.of<MovieDetailBloc>(context);
    movieDetailBloc.add(MovieDetailLoadEvent(movieId));

    final castBloc = BlocProvider.of<CastBloc>(context);
    castBloc.add(CastLoadEvent(movieId));

    return Scaffold(
      body: BlocBuilder<MovieDetailBloc, MovieDetailState>(
          builder: (context, state) {
        if (state is MovieDetailLoadingState) {
          return Center(
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
                  BlocBuilder<CastBloc, CastState>(builder: (context, state) {
                    if (state is CastLoadingState) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (state is CastLoadedState) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                        child: SizedBox(
                          height: 200,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: state.cast.length,
                              itemBuilder: (context, index) {
                                final castItem = state.cast[index];
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => CastDetailScreen(
                                                  castId: state.cast[index].id,
                                                ),
                                              ),
                                            );
                                  },
                                  child: SizedBox(
                                    height: 80,
                                    width: 140,
                                    child: Card(
                                      elevation: 1,
                                      margin: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.vertical(
                                                top: Radius.circular(8),
                                              ),
                                              child: Image.network(
                                                'https://image.tmdb.org/t/p/original/${castItem.profileImg}',
                                                fit: BoxFit.fitWidth,
                                                height: 80,
                                                width: 140,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                4, 2, 0, 2),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  castItem.name,
                                                  overflow: TextOverflow.fade,
                                                  maxLines: 1,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  castItem.character,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  style: const TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                      );
                    }

                    return Center(child: Text("Cast error"));
                  })
                ],
              ),
            ),
          );
        }

        return const Text("Error");
      }),
    );
  }
}
