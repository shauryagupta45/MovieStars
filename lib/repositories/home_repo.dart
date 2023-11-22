import 'package:flutter/material.dart';
import 'package:movie_stars/data/network/base_api_services.dart';
import 'package:movie_stars/data/network/network_api_services.dart';
import 'package:movie_stars/resources/app_url.dart';

import '../model/movies_model.dart';

class HomeRepository {
  BaseApiServices _apiServices = NetworkApiServices();
  Future<MovieListModel> fetchApi() async {
    try {
      dynamic response =
          await _apiServices.getGetApiResponse(AppUrl.moviesListEndPoint);
      return response = MovieListModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
