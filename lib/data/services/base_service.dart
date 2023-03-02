import 'package:flutter/cupertino.dart';

abstract class BaseService {
  final String baseUrl = "api.openweathermap.org";
  final String apiKey = "2f9db73a7e06c0763afd84b5c4f128a3";

  final String getWeather = "data/2.5/weather";

  final headers = <String, String>{};

  Future<dynamic> getResponse(
    BuildContext context,
    String url, {
    Map<String, String>? headParams,
    Map<String, String>? queryParams,
  });
}
