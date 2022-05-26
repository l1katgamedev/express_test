import 'dart:developer';

import 'package:express_test/screens/cast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/cast/cast_bloc.dart';

class CastWidget extends StatefulWidget {
   final int? movieId;

  const CastWidget({Key? key, required this.movieId}) : super(key: key);

  @override
  State<CastWidget> createState() => _CastWidgetState();
}

class _CastWidgetState extends State<CastWidget> {

  @override
  void initState() {
    final CastBloc bloc = BlocProvider.of<CastBloc>(context);
    if (bloc.state is! CastLoadedState) {
      bloc.add(CastLoadEvent(widget.movieId));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CastBloc, CastState>(
        builder: (context, state) {
          if (state is CastLoadingState) {
            return const Center(
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.vertical(
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
                                  padding: const EdgeInsets.fromLTRB(4, 2, 0, 2),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        castItem.name,
                                        overflow: TextOverflow.fade,
                                        maxLines: 1,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
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
        });
  }
}
