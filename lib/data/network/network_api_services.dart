import 'dart:convert';
import 'dart:io';

import 'package:movie_stars/data/app_exceptions.dart';
import 'package:movie_stars/data/network/base_api_services.dart';
import 'package:http/http.dart' as http;

class NetworkApiServices extends BaseApiServices {
  @override
  Future<dynamic> getGetApiResponse(String url) async {
    dynamic responseJson;
    try {
      final response =
          await http.get(Uri.parse(url)).timeout(Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      // socketException is then when there is no internet connection or broken internet connection
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  @override
  Future<dynamic> getPostApiResponse(String url, dynamic data) async {
    dynamic responseJson;
    try {
      final response = await http
          .post(Uri.parse(url), body: data)
          .timeout(Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      // socketException is then when there is no internet connection or broken internet connection
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException();
      case 404:
        throw UnauthorisedException();
      case 500:
        throw UnauthorisedException();
      default:
        throw FetchDataException(
            'Error occured while communicating with server' +
                'with status code' +
                response.statusCode.toString());
    }
  }
}
