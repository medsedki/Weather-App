import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';

import '../viewmodel/dashboard_view_model.dart';
import '../model/WeatherResponse.dart';
import '../components/custom_button.dart';
import '../utils/size_config.dart';
import '../res/app_strings.dart';
import '../res/app_styles.dart';
import '../res/app_colors.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  Timer? loadingTimer;
  Timer? periodicTimer;
  Timer? wordingTimer;
  double loaderValue = 0;
  bool isLoading = false;
  var cityName = AppStrings.CITY_NAME_1;
  var cityLongitude = "48.114700";
  var cityLatitude = "-1.679400";
  var loadingLabel = AppStrings.LOADING_LABEL_1;
  Color loadingLabelColor = AppColors.loadingLabelColor_1;

  WeatherResponse? weatherRennes,
      weatherParis,
      weatherNantes,
      weatherBordeaux,
      weatherLyon;

  @override
  void initState() {
    super.initState();

    determinateIndicator();
  }

  @override
  dispose() {
    loadingTimer?.cancel();
    periodicTimer?.cancel();
    wordingTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(AppStrings.DASHBOARD_LABEL),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.whiteColor,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          InkWell(
            onTap: () {
              setState(() {
                loadingTimer?.cancel();
                periodicTimer?.cancel();
                wordingTimer?.cancel();
                loaderValue = 0;
                isLoading = false;

                weatherRennes = null;
                weatherParis = null;
                weatherNantes = null;
                weatherBordeaux = null;
                weatherLyon = null;

                determinateIndicator();
              });
            },
            child: const Center(
              child: Icon(
                Icons.refresh,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          )
        ],
      ),
      body: _buildContent(),
    );
  }

  Widget _buildContent() {
    return Container(
      height: SizeConfig.screenHeight,
      color: AppColors.whiteF8Color,
      child: Column(
        children: [
          Expanded(
            child: !isLoading
                ? ListView(
                    children: [
                      _buildItemList_2(
                        AppStrings.CITY_NAME_1,
                        weatherRennes?.wind?.deg.toString(),
                        weatherRennes?.visibility.toString(),
                      ),
                      _buildItemList_2(
                        AppStrings.CITY_NAME_2,
                        weatherParis?.wind?.deg.toString(),
                        weatherParis?.visibility.toString(),
                      ),
                      _buildItemList_2(
                        AppStrings.CITY_NAME_3,
                        weatherNantes?.wind?.deg.toString(),
                        weatherNantes?.visibility.toString(),
                      ),
                      _buildItemList_2(
                        AppStrings.CITY_NAME_4,
                        weatherBordeaux?.wind?.deg.toString(),
                        weatherBordeaux?.visibility.toString(),
                      ),
                      _buildItemList_2(
                        AppStrings.CITY_NAME_5,
                        weatherLyon?.wind?.deg.toString(),
                        weatherLyon?.visibility.toString(),
                      ),
                    ],
                  )
                : const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Color(0xFF29B6F6),
                      ),
                      strokeWidth: 3.0,
                    ),
                  ),
          ),
          isLoading ? _buildProgress() : _buildRefreshButton(),
        ],
      ),
    );
  }

  Widget _buildItemList(cityName, temperature, couverture) {
    return Container(
      constraints: const BoxConstraints(
        minHeight: 120.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Expanded(
                  flex: 2,
                  child: Text(
                    AppStrings.CITY_NAME,
                    textAlign: TextAlign.start,
                    style: AppStyles.boldTextStyle,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    cityName ?? "---",
                    textAlign: TextAlign.start,
                    style: AppStyles.greyTextStyle,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Expanded(
                  flex: 2,
                  child: Text(
                    AppStrings.TEMPERATURE,
                    textAlign: TextAlign.start,
                    style: AppStyles.boldTextStyle,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    temperature ?? "---",
                    textAlign: TextAlign.start,
                    style: AppStyles.greyTextStyle,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Expanded(
                  flex: 2,
                  child: Text(
                    AppStrings.COUVERTURE,
                    textAlign: TextAlign.start,
                    style: AppStyles.boldTextStyle,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    couverture ?? "---",
                    textAlign: TextAlign.start,
                    style: AppStyles.greyTextStyle,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemList_2(cityName, temperature, couverture) {
    return Container(
      color: AppColors.greyHiddenColor,
      constraints: const BoxConstraints(
        maxHeight: 120.0,
        minHeight: 50,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Text(
                cityName,
                textAlign: TextAlign.start,
                style: AppStyles.greyTextStyle,
              ),
            ),
            Expanded(
              flex: 2,
              child: RichText(
                text: TextSpan(
                    text: AppStrings.TEMPERATURE,
                    style: AppStyles.boldTextStyle,
                    children: <TextSpan>[
                      TextSpan(
                        text: temperature ?? "---",
                        style: AppStyles.greyTextStyle,
                      ),
                    ]),
              ),
            ),
            Expanded(
              flex: 2,
              child: RichText(
                text: TextSpan(
                    text: AppStrings.COUVERTURE,
                    style: AppStyles.boldTextStyle,
                    children: <TextSpan>[
                      TextSpan(
                        text: couverture ?? "---",
                        style: AppStyles.greyTextStyle,
                      ),
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgress() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            loadingLabel,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: loadingLabelColor,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w600,
              fontSize: 15.0,
            ),
          ),
          Row(
            children: [
              Expanded(
                flex: 9,
                child: Container(
                  margin: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  child: LinearProgressIndicator(
                    backgroundColor: Colors.lightBlueAccent,
                    color: Colors.red,
                    minHeight: 15,
                    value: loaderValue / 60,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text("${((loaderValue * 100).toInt() / 60).round()} %"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRefreshButton() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: CustomButton(
        textColor: AppColors.whiteColor,
        textHoverColor: AppColors.whiteColor,
        hasBorder: false,
        color: AppColors.blueColor,
        hoverColor: AppColors.blackColor,
        title: AppStrings.REFRESH_LABEL,
        onClick: () {
          _onButtonPressed();
        },
      ),
    );
  }

  _onButtonPressed() {
    setState(() {
      weatherRennes = null;
      weatherParis = null;
      weatherNantes = null;
      weatherBordeaux = null;
      weatherLyon = null;

      determinateIndicator();
    });
  }

  void determinateIndicator() {
    setState(() {
      isLoading = true;
    });
    var weatherProvider =
        Provider.of<DashboardViewModel>(context, listen: false);
    loadingTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => addTimer());

    // change the loading text every 6s
    wordingTimer = Timer.periodic(
      const Duration(seconds: 6),
      (Timer t) {
        if (loadingLabel == AppStrings.LOADING_LABEL_1) {
          setState(() {
            loadingLabel = AppStrings.LOADING_LABEL_2;
            loadingLabelColor = AppColors.loadingLabelColor_2;
          });
        } else if (loadingLabel == AppStrings.LOADING_LABEL_2) {
          setState(() {
            loadingLabel = AppStrings.LOADING_LABEL_3;
            loadingLabelColor = AppColors.loadingLabelColor_1;
          });
        } else if (loadingLabel == AppStrings.LOADING_LABEL_3) {
          setState(() {
            loadingLabel = AppStrings.LOADING_LABEL_1;
            loadingLabelColor = AppColors.loadingLabelColor_2;
          });
        }
      },
    );

    // Call Api every 10s
    periodicTimer = Timer.periodic(
      const Duration(seconds: 10),
      (Timer t) {
        if (cityName == AppStrings.CITY_NAME_1) {
          setState(() {
            cityName = AppStrings.CITY_NAME_2;
            cityLongitude = "48.864716";
            cityLatitude = "2.349014";
            weatherParis = weatherProvider.weatherResponse;
          });
        } else if (cityName == AppStrings.CITY_NAME_2) {
          setState(() {
            cityName = AppStrings.CITY_NAME_3;
            cityLongitude = "47.21837";
            cityLatitude = "-1.55362";
            weatherNantes = weatherProvider.weatherResponse;
          });
        } else if (cityName == AppStrings.CITY_NAME_3) {
          setState(() {
            cityName = AppStrings.CITY_NAME_4;
            cityLongitude = "44.83779";
            cityLatitude = "-0.57918";
            weatherBordeaux = weatherProvider.weatherResponse;
          });
        } else if (cityName == AppStrings.CITY_NAME_4) {
          setState(() {
            cityName = AppStrings.CITY_NAME_5;
            cityLongitude = "45.76404";
            cityLatitude = "4.83566";
            weatherLyon = weatherProvider.weatherResponse;
          });
        } else if (cityName == AppStrings.CITY_NAME_5) {
          setState(() {
            cityName = AppStrings.CITY_NAME_1;
            cityLongitude = "48.114700";
            cityLatitude = "-1.679400";
            weatherRennes = weatherProvider.weatherResponse;
          });
        }
        weatherProvider.getWeatherDetails(context, cityLatitude, cityLongitude);
      },
    );
  }

  void addTimer() {
    var weatherProvider =
        Provider.of<DashboardViewModel>(context, listen: false);

    setState(() {
      if (loaderValue == 0) {
        cityName = AppStrings.CITY_NAME_1;
        weatherProvider
            .getWeatherDetails(context, "48.114700", "-1.679400")
            .then((value) => weatherRennes = weatherProvider.weatherResponse);
      }

      if (loaderValue == 60) {
        loaderValue = 0;
        isLoading = false;
        loadingTimer?.cancel();
        periodicTimer?.cancel();
        wordingTimer?.cancel();
      } else {
        loaderValue = loaderValue + 1;
      }
    });
  }
}
