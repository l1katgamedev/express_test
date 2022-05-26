import 'package:express_test/bloc/upcoming/upcoming_bloc.dart';
import 'package:express_test/presentation/screens/movie_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpcomingScreen extends StatefulWidget {
  static const routeName = "/upcoming";

  const UpcomingScreen({Key? key}) : super(key: key);

  @override
  State<UpcomingScreen> createState() => _UpcomingScreenState();
}

class _UpcomingScreenState extends State<UpcomingScreen> {
  @override
  void initState() {
    final UpcomingBloc bloc = BlocProvider.of<UpcomingBloc>(context);
    if(bloc.state is! UpcomingLoadedState) bloc.add(UpcomingLoadEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<UpcomingBloc, UpcomingState>(
        builder: (context, state) {
          if (state is UpcomingLoadedState) {
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
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => MovieDetailScreen(movieId: item.id,)));
                                      },
                                    ),
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
                                                    fontWeight:
                                                    FontWeight.w600),
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
                                padding: const EdgeInsets.all(12)
                                    .copyWith(bottom: 0),
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
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
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

          if (state is UpcomingLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }

          return const Center(child: Text("Ошибка сети"));
        },
      ),
    );
  }
}
