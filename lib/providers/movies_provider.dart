import 'dart:convert';
import 'dart:ffi';

import 'package:cartelera/models/upcoming_response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cartelera/models/models.dart';

class MoviesProvider extends ChangeNotifier {
  MoviesProvider() {
    this.getOnDisplayMovies();
  }
  final String _apiKey = "830892c9afa9829d326fb223f949a787";
  final String _baseUrl = "api.themoviedb.org";
  final String _language = "es-ES";
  final String _sessionId = "5a520b4e940c45767f77d1778b96471b";

  //Future obtener async
  Future<NowPlayingResponse> getOnDisplayMovies() async {
    //Llamado al API
    final url =
        Uri.https(_baseUrl, '3/movie/now_playing', //'3/movie/580489', //
            {'api_key': _apiKey, 'language': _language, 'page': '1'});
    final response = await http.get(url);
    if (response.statusCode == 200) {
      //ok
      return NowPlayingResponse.fromJson(response.body);
    } else {
      print(response.statusCode);
      throw Exception("Fail");
    }
  }

  Future<TopRatedResponse> getOnTopMovies() async {
    //Llamado al API
    final url = Uri.https(_baseUrl, '3/movie/top_rated', //'3/movie/580489', //
        {'api_key': _apiKey, 'language': _language, 'page': '1'});
    final response = await http.get(url);
    if (response.statusCode == 200) {
      //ok
      return TopRatedResponse.fromJson(response.body);
    } else {
      print(response.statusCode);
      throw Exception("Fail");
    }
  }

  Future<SimilarMoviesResponse> getSimilarMovie(int index) async {
    //Llamado al API
    final url = Uri.https(
        _baseUrl, '3/movie/$index/similar', //'3/movie/now_playing', //
        {'api_key': _apiKey, 'language': _language, 'page': '1'});
    final response = await http.get(url);
    if (response.statusCode == 200) {
      //ok
      return SimilarMoviesResponse.fromJson(response.body);
    } else {
      print(response.statusCode);
      throw Exception("Fail");
    }
  }

  Future<CreditsResponse> getCastingMovie(int index) async {
    //Llamado al API
    final url = Uri.https(
        _baseUrl, '3/movie/$index/credits', //'3/movie/now_playing', //
        {'api_key': _apiKey, 'language': _language, 'page': '1'});
    final response = await http.get(url);
    if (response.statusCode == 200) {
      //ok
      return CreditsResponse.fromJson(response.body);
    } else {
      print(response.statusCode);
      throw Exception("Fail");
    }
  }

  Future<UpcomingResponse> getUpcomingMovies() async {
    //Llamado al API
    final url = Uri.https(_baseUrl, '3/movie/upcoming', //'3/movie/580489', //
        {'api_key': _apiKey, 'language': _language, 'page': '1'});
    final response = await http.get(url);
    if (response.statusCode == 200) {
      //ok
      return UpcomingResponse.fromJson(response.body);
    } else {
      print(response.statusCode);
      throw Exception("Fail");
    }
  }

  Future<ImagesResponse> getImages(int index) async {
    //Llamado al API
    final url =
        Uri.https(_baseUrl, '3/movie/$index/images', //'3/movie/now_playing', //
            {'api_key': _apiKey});
    final response = await http.get(url);
    if (response.statusCode == 200) {
      //ok
      return ImagesResponse.fromJson(response.body);
    } else {
      print(response.statusCode);
      throw Exception("Fail");
    }
  }

  void setRating(int index, double rate) async {
    final url = Uri.https(_baseUrl, '3/movie/$index/rating',
        {'api_key': _apiKey, 'guest_session_id': _sessionId});
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({"value": rate}),
    );
    if (response.statusCode == 201) {
      print('Se logro el cometido');
    } else {
      print(response.statusCode);
      //throw Exception('Fallamos en la mision');
    }
  }

  void getNowMovies() async {
    //Llamado al API
    final url = Uri.https(_baseUrl, '3/movie/580489', //'3/movie/now_playing',
        {'api_key': _apiKey, 'language': _language, 'page': '1'});
    final response = await http.get(url);
    print(response.body);
    final movie = MovieF.fromJson(response.body);
    print(movie.productionCompanies);
    //print(nowPlayingResponse.results[0].title);
    //notifyListeners();
  }

  Future<MovieF> getMovieDetails(int index) async {
    //Llamado al API
    final url =
        Uri.https(_baseUrl, '3/movie/$index', //'3/movie/now_playing', //
            {'api_key': _apiKey});
    final response = await http.get(url);
    if (response.statusCode == 200) {
      //ok
      return MovieF.fromJson(response.body);
    } else {
      print(response.statusCode);
      throw Exception("Fail");
    }
  }

  Future<CompanyImageResponse> getLogo(int index) async {
    //Llamado al API
    final url = Uri.https(
        _baseUrl, '3/company/$index/images', //'3/movie/now_playing', //
        {'api_key': _apiKey});
    final response = await http.get(url);
    if (response.statusCode == 200) {
      //ok
      return CompanyImageResponse.fromJson(response.body);
    } else {
      print(response.statusCode);
      throw Exception("Fail");
    }
  }

  Future<Companies> getCompany(int index) async {
    //Llamado al API
    final url =
        Uri.https(_baseUrl, '3/company/$index', //'3/movie/now_playing', //
            {'api_key': _apiKey});
    final response = await http.get(url);
    if (response.statusCode == 200) {
      //ok
      return Companies.fromJson(response.body);
    } else {
      print(response.statusCode);
      throw Exception("Fail");
    }
  }
}
