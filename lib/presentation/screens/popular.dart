import 'dart:developer';

import 'package:express_test/bloc/popular/movie_bloc.dart';
import 'package:express_test/presentation/screens/movie_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopularScreen extends StatefulWidget {
  static const routeName = "/popular";

  const PopularScreen({Key? key}) : super(key: key);

  @override
  State<PopularScreen> createState() => _PopularScreenState();
}

class _PopularScreenState extends State<PopularScreen> {

  @override
  void initState() {
    final MovieBloc bloc = BlocProvider.of<MovieBloc>(context);
    if (bloc.state is! MoviesLoadedState) bloc.add(MoviesLoadEvent());
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
          onRefresh: () {
        return Future.delayed(const Duration(seconds: 1), () {
          final MovieBloc bloc = BlocProvider.of<MovieBloc>(context);
          bloc.add(MoviesLoadEvent());
        });
      }, child: BlocBuilder<MovieBloc, MovieState>(
        builder: (context, state) {
          if (state is MoviesLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is MoviesLoadedState) {
            return Column(
              children: [
                Flexible(
                  child: ListView.builder(
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        var item = state.movies[index];

                        return Card(
                          margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                          elevation: 4,
                          clipBehavior: Clip.antiAlias,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Ink.image(
                                    image: NetworkImage(
                                        'https://image.tmdb.org/t/p/w500/${item.poster}'),
                                    height: 240,
                                    fit: BoxFit.cover,
                                    child: InkWell(onTap: () {
                                      log("${item.id}");
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => MovieDetailScreen(movieId: state.movies[index].id,)));
                                    }),
                                  ),
                                  Positioned(
                                    right: 10,
                                    top: 10,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(8, 0, 0, 0),
                                      child: SizedBox.fromSize(
                                        size: const Size(40, 40),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF081C22),
                                            border: Border.all(
                                              color: Colors.white,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                item.rating.toString(),
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 16,
                                    left: 16,
                                    bottom: 16,
                                    child: Text(
                                      item.name,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 24),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.all(12).copyWith(bottom: 0),
                                child: Text(
                                  item.description,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    child: Text(
                                      item.releaseDate,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                  ButtonBar(
                                    alignment: MainAxisAlignment.end,
                                    children: [
                                      TextButton(
                                        onPressed: () {},
                                        style: TextButton.styleFrom(
                                            primary: Colors.white,
                                            backgroundColor:
                                                const Color(0xFF032541),
                                            onSurface: Colors.grey),
                                        child: const Text('Watch'),
                                      ),
                                      TextButton(
                                        onPressed: () {},
                                        style: TextButton.styleFrom(
                                            primary: Colors.white,
                                            backgroundColor:
                                                const Color(0xFF032541),
                                            onSurface: Colors.grey),
                                        child: const Text('More'),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }),
                ),
              ],
            );
          }

          return const Center(
            child: Text("Нету попульрных фильмов"),
          );
        },
      )),
    );
  }
}
