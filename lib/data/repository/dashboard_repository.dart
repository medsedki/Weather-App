import 'package:flutter/material.dart';

import '../services/base_service.dart';
import '../services/network_service.dart';
import '../../model/WeatherResponse.dart';
import '../../utils/alert_dialog.dart';
import '../../res/app_strings.dart';

class DashboardRepository {
  final BaseService _apiServices = NetworkService();

  Future<WeatherResponse> getWeather(
    BuildContext mContext,
    String lat,
    long,
  ) async {
    try {
      Map<String, String> queryParams = {
        'lat': lat,
        'lon': long,
        'appid': _apiServices.apiKey,
      };

      dynamic response = await _apiServices.getResponse(
        mContext,
        _apiServices.getWeather,
        queryParams: queryParams,
      );

      var responseJson = WeatherResponse.fromJson(response);
      return responseJson;
    } on FormatException catch (e) {
      debugPrint("FormatException=$e");
      return ALertDialog.showSimpleAlert(
        mContext,
        AppStrings.FORMAT_EXP_LABEL,
        AppStrings.OK_LABEL,
        () {
          Navigator.of(mContext).pop();
        },
      );
    } catch (e) {
      debugPrint("catch=$e");
      return ALertDialog.showSimpleAlert(
        mContext,
        AppStrings.ERREUR_MSG,
        AppStrings.OK_LABEL,
        () {
          Navigator.of(mContext).pop();
        },
      );
    }
  }
}
