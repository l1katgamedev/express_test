import 'dart:developer';
import 'dart:ui';

import 'package:express_test/bloc/cast_detail/cast_detail_bloc.dart';
import 'package:express_test/bloc/credits/credit_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CastDetailScreen extends StatelessWidget {
  final int castId;

  const CastDetailScreen({Key? key, required this.castId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final castDetailBloc = BlocProvider.of<CastDetailBloc>(context);
    castDetailBloc.add(CastDetailLoadEvent(castId));

    final creditBloc = BlocProvider.of<CreditBloc>(context);
    creditBloc.add(CreditLoadEvent(castId));

    return BlocBuilder<CastDetailBloc, CastDetailState>(
        builder: (context, state) {
      if (state is CastDetailLoadingState) {
        log("first $state");
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state is CastDetailLoadedState) {
        log(" second $state");
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
                BlocBuilder<CreditBloc, CreditState>(builder: (context, state) {
                  if (state is CreditLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is CreditLoadedState) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                      child: SizedBox(
                        height: 200,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: state.credits.length,
                            itemBuilder: (context, index) {
                              final castItem = state.credits[index];
                              return GestureDetector(
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
                                              'https://image.tmdb.org/t/p/original/${castItem.poster}',
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
                                                castItem.title,
                                                overflow: TextOverflow.fade,
                                                maxLines: 1,
                                                style: const TextStyle(
                                                    fontWeight:
                                                    FontWeight.bold),
                                              ),
                                              Text(
                                                castItem.character,
                                                overflow: TextOverflow.ellipsis,
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
                  return Center(
                    child: Text('Нету детальной страницы'),
                  );
                }),
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
