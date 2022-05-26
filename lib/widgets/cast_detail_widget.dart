import 'dart:ui';

import 'package:express_test/widgets/cast_movie_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/cast_detail/cast_detail_bloc.dart';

class CastDetailWidget extends StatefulWidget {
  final int? castId;
  const CastDetailWidget({Key? key, this.castId}) : super(key: key);

  @override
  State<CastDetailWidget> createState() => _CastDetailWidgetState();
}

class _CastDetailWidgetState extends State<CastDetailWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CastDetailBloc, CastDetailState>(
        builder: (context, state) {
          if (state is CastDetailLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is CastDetailLoadedState) {
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
                              'https://image.tmdb.org/t/p/w500//${state.castDetail.profileImg}',
                              width: window.physicalSize.width /
                                  window.devicePixelRatio),
                        ),
                        Positioned(
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: ListTile(
                            title: Text(
                              state.castDetail.name.toUpperCase(),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                            subtitle: Text(
                              state.castDetail.birthday,
                              style: const TextStyle(color: Colors.grey),
                            ),
                            trailing: Text(
                              state.castDetail.rating.toString(),
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
                        state.castDetail.bio,
                        style: const TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      child: Text(
                        'Movies',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    CastMovieList(castId: state.castDetail.id,),
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
