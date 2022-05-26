import 'package:express_test/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:express_test/bloc/popular/movie_bloc.dart';
import 'package:express_test/bloc/trending/trending_bloc.dart';
import 'package:express_test/bloc/upcoming/upcoming_bloc.dart';
import 'package:express_test/screens/home.dart';
import 'package:express_test/screens/movie_detail.dart';
import 'package:express_test/screens/popular.dart';
import 'package:express_test/services/repository.dart';
import 'package:express_test/screens/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import 'bloc/cast/cast_bloc.dart';
import 'bloc/cast_detail/cast_detail_bloc.dart';
import 'bloc/credits/credit_bloc.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<MovieBloc>(
            create: (BuildContext context) => MovieBloc(MovieService()..getPopularMovies(),),
          ),
          BlocProvider<TrendingBloc>(
            create: (BuildContext context) => TrendingBloc(MovieService()..getTrendingMovies(),),
          ),
          BlocProvider<UpcomingBloc>(
            create: (BuildContext context) => UpcomingBloc(MovieService()..getUpcomingMovies(),),
          ),
          BlocProvider<MovieDetailBloc>(
            create: (BuildContext context) => MovieDetailBloc(MovieService()),
          ),
          BlocProvider<CastBloc>(
            create: (BuildContext context) => CastBloc(MovieService()),
          ),
          BlocProvider<CastDetailBloc>(
            create: (BuildContext context) => CastDetailBloc(MovieService()),
          ),
          BlocProvider<CreditBloc>(
            create: (BuildContext context) => CreditBloc(MovieService()),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Express Test',
          theme: ThemeData(
              fontFamily: 'MainFont',
              primaryColor: Colors.blue,
              appBarTheme: AppBarTheme(
                color: Colors.teal,
                // foregroundColor: primaryColor,
                foregroundColor: Colors.grey[700],
              ),
              scaffoldBackgroundColor: Colors.tealAccent
          ),
          initialRoute: SplashScreen.routeName,
          builder: EasyLoading.init(),
          routes: {
            SplashScreen.routeName: (context) => const SplashScreen(),
            HomePage.routeName: (context) => const HomePage(),
            '/movieDetail': (context) => MovieDetailScreen(),
          },
        ),
      );
  }
}
