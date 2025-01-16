import 'package:tentwentytask/models/movie/MovieResponse.dart';
import 'package:tentwentytask/models/movie_details/MovieDetailsResponse.dart';
import 'package:tentwentytask/models/movie_video/MovieVideoResponse.dart';

import 'dio_helper.dart';

class Repository {
  static final DioHelper _dioHelper = DioHelper();

  static const String baseUrl = 'https://api.themoviedb.org/3/movie/';
  static const String apiKey = 'bb9d394b090e7b17020a321dafe1d5f9';
  static const String imageBaseUrl = 'https://image.tmdb.org/t/p/';

  // Future<LogInModel> userLogin (Object requestBody) async {
  //   Map<String, dynamic> response = await _dioHelper.post(url: '$baseUrl/api/v1/auth/login', requestBody: requestBody);
  //   return LogInModel.fromJson(response);
  // }
  //
  //
  // Future<AutoCompletePlace> autoCompletePlaces (String placeName) async {
  //   Map<String, dynamic> response = await _dioHelper.get(url: 'https://geocoding-api.open-meteo.com/v1/search?name=$placeName&count=5');
  //   return AutoCompletePlace.fromJson(response);
  // }
  //
  //
  // Future<UserProfileModel> userProfile () async {
  //   Map<String, dynamic> response = await _dioHelper.get(url: '$baseUrl/api/v1/auth/profile', isAuthRequired: true);
  //   return UserProfileModel.fromJson(response);
  // }
  //
  // Future<ChangeProfileModel> changeProfile (Object requestBody) async {
  //   Map<String, dynamic> response = await _dioHelper.uploadFile(
  //       url: '$baseUrl/api/v1/files/upload', requestBody: requestBody);
  //   return ChangeProfileModel.fromJson(response);
  // }
  //
  //
  Future<MovieResponse> getMoviesList() async {
    Map<String, dynamic> response =
        await _dioHelper.get(url: '${baseUrl}upcoming?api_key=$apiKey');
    return MovieResponse.fromJson(response);
  }

  Future<MovieDetailsResponse> getMovieDetails(int movieID) async {
    Map<String, dynamic> response =
        await _dioHelper.get(url: '${baseUrl}$movieID?api_key=$apiKey');
    return MovieDetailsResponse.fromJson(response);
  }

  Future<MovieVideoResponse> getMovieVideos(int movieID) async {
    Map<String, dynamic> response =
        await _dioHelper.get(url: '${baseUrl}$movieID/videos?api_key=$apiKey');
    return MovieVideoResponse.fromJson(response);
  }
}
