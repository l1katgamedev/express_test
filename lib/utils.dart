import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

const String apiKey = "da53f3411c0acfd221b4bd8731bf2a5e";
const String baseUrl = "https://api.themoviedb.org/3";
final Dio dio = Dio();

var getPopularMoviesApi = "$baseUrl/movie/popular";
var getTopRatedMoviesApi = "$baseUrl/movie/top_rated";
var getUpcomingMoviesApi = "$baseUrl/movie/upcoming";
var getPersonsUrl = "$baseUrl/person";
var movieUrl = "$baseUrl/movie";

int pageIndex = 0;
PageController pageController = PageController(
  initialPage: pageIndex,
  keepPage: true,
);