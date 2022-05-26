import 'package:express_test/bloc/credits/credit_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class CastMovieList extends StatefulWidget {
  final int? castId;

  const CastMovieList({Key? key, this.castId}) : super(key: key);

  @override
  State<CastMovieList> createState() => _CastMovieListState();
}

class _CastMovieListState extends State<CastMovieList> {

  @override
  void initState() {
    final CreditBloc bloc = BlocProvider.of<CreditBloc>(context);
    if (bloc.state is! CreditLoadedState) {
      bloc.add(CreditLoadEvent(widget.castId));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreditBloc, CreditState>(
        builder: (context, state) {
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.vertical(
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
                                  padding: const EdgeInsets.fromLTRB(4, 2, 0, 2),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        castItem.title,
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
