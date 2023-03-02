import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import '../data/repository/dashboard_repository.dart';
import '../model/WeatherResponse.dart';

class DashboardViewModel with ChangeNotifier {
  DashboardRepository dashboardRepository = DashboardRepository();

  WeatherResponse? weatherResponse;

  Future<void> getWeatherDetails(context, String lat, long) async {
    weatherResponse = null;

    weatherResponse = await dashboardRepository.getWeather(
      context,
      lat,
      long,
    );

    notifyListeners();
  }
}
