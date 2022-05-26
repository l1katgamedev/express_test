import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:express_test/models/cast_detail.dart';
import 'package:express_test/models/movie_detail.dart';
import 'package:http/http.dart' as http;
import '../models/cast.dart';
import '../models/credits.dart';
import '../models/movie.dart';
import '../utils.dart';

class MovieService {
  Future<List<Movie>> getPopularMovies() async {
    final params = {
      "api_key": apiKey,
      "language": "en-US",
    };

    final uri = Uri.parse(getPopularMoviesApi).replace(queryParameters: params);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final List<dynamic> movieJson = json.decode(response.body)['results'];
      return movieJson.map((json) => Movie.fromJson(json)).toList();
    } else {
      throw Exception('Error');
    }
  }

  Future<List<Movie>> getTrendingMovies() async {
    final params = {
      "api_key": apiKey,
      "language": "en-US",
    };

    final uri =
        Uri.parse(getTopRatedMoviesApi).replace(queryParameters: params);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final List<dynamic> movieJson = json.decode(response.body)['results'];
      return movieJson.map((json) => Movie.fromJson(json)).toList();
    } else {
      throw Exception('Error');
    }
  }

  Future<List<Movie>> getUpcomingMovies() async {
    final params = {
      "api_key": apiKey,
      "language": "en-US",
    };

    final uri =
        Uri.parse(getUpcomingMoviesApi).replace(queryParameters: params);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final List<dynamic> movieJson = json.decode(response.body)['results'];
      return movieJson.map((json) => Movie.fromJson(json)).toList();
    } else {
      throw Exception('Error');
    }
  }

  Future<MovieDetail> getMovieDetail(dynamic id) async {
    final params = {
      "api_key": apiKey,
      "language": "en-US",
    };

    final uri = Uri.parse("$movieUrl/$id").replace(queryParameters: params);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final movieJson = MovieDetail.fromJson(json.decode(response.body));
      return movieJson;
    } else {
      throw Exception('Error');
    }
  }

  Future<List<Cast>> getCast(dynamic id) async {
    final params = {
      "api_key": apiKey,
      "language": "en-US",
    };

    final uri =
        Uri.parse("$movieUrl/$id/credits").replace(queryParameters: params);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final List<dynamic> castJson = json.decode(response.body)['cast'];
      return castJson.map((json) => Cast.fromJson(json)).toList();
    } else {
      throw Exception('Error');
    }
  }

  Future<CastDetail> getCastDetail(dynamic id) async {
    final params = {
      "api_key": apiKey,
      "language": "en-US",
    };

    final uri =
        Uri.parse("$getPersonsUrl/$id").replace(queryParameters: params);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final castDetailJson = CastDetail.fromJson(json.decode(response.body));

      return castDetailJson;
    } else {
      throw Exception('Error');
    }
  }

  Future<List<Credits>> getCredits(dynamic id) async {
    final params = {
      "api_key": apiKey,
      "language": "en-US",
    };

    final uri = Uri.parse("$getPersonsUrl/$id/movie_credits")
        .replace(queryParameters: params);
    final response = await http.get(uri);

    log("nuuu $uri");

    if (response.statusCode == 200) {
      final List<dynamic> creditJson = json.decode(response.body)['cast'];
      return creditJson.map((json) => Credits.fromJson(json)).toList();
    } else {
      throw Exception('Error');
    }
  }
}
