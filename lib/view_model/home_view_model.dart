import 'package:flutter/material.dart';
import 'package:movie_stars/data/response/api_response.dart';
import 'package:movie_stars/model/movies_model.dart';
import 'package:movie_stars/repositories/home_repo.dart';

class HomeViewViewModel with ChangeNotifier {
  final _movieRepo = HomeRepository();
  ApiResponse<MovieListModel> moviesList = ApiResponse.loading();

  setMoviesList(ApiResponse<MovieListModel> response) {
    moviesList = response;
    notifyListeners();
  }

  Future<void> fetchMoviesListApi() async {
    setMoviesList(ApiResponse.loading());

    _movieRepo.fetchApi().then((value) {
      ApiResponse.completed(value);
    }).onError((error, stackTrace) {
      setMoviesList(ApiResponse.error(error.toString()));
    });
  }
}
