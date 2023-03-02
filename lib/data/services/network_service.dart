import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/io_client.dart' as http;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'dart:io';

import 'base_service.dart';
import 'app_exception.dart';
import '../../utils/alert_dialog.dart';
import '../../res/app_strings.dart';

class NetworkService extends BaseService {
  @override
  Future getResponse(
    BuildContext context,
    String url, {
    Map<String, String>? headParams,
    Map<String, String>? queryParams,
  }) async {
    dynamic responseJson;

    final ioClient = HttpClient();
    ioClient.connectionTimeout = const Duration(seconds: 30);
    final client = http.IOClient(ioClient);

    var urlGet = queryParams != null
        ? Uri.https(baseUrl, url, queryParams)
        : Uri.parse(baseUrl + url);

    if (headParams != null) headers.addAll(headParams);

    if (kDebugMode) {
      print("urlGet: $urlGet");
      print("Headers: $headers");
    }
    try {
      final response = await client
          .get(
            urlGet,
            headers: headers,
          )
          .timeout(
            const Duration(seconds: 30),
          );

      responseJson = returnResponse(response, context);
    } on FormatException catch (e) {
      debugPrint("FormatException=$e");
      return ALertDialog.showSimpleAlert(
        context,
        AppStrings.FORMAT_EXP_LABEL,
        AppStrings.OK_LABEL,
        () {
          Navigator.of(context).pop();
        },
      );
    } catch (e) {
      debugPrint("catch=$e");
      //ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return ALertDialog.showSimpleAlert(
        context,
        AppStrings.ERREUR_MSG,
        AppStrings.OK_LABEL,
        () {
          Navigator.of(context).pop();
        },
      );
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response, context) {
    debugPrint("statusCode: ${response.statusCode}");
    debugPrint("body: ${response.body}");

    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        return ALertDialog.showSimpleAlert(
          context,
          AppStrings.ERREUR_MSG,
          AppStrings.OK_LABEL,
          () {
            Navigator.of(context).pop();
          },
        );
      case 401:
        return ALertDialog.showSimpleAlert(
          context,
          AppStrings.ERREUR_MSG,
          AppStrings.OK_LABEL,
          () {
            Navigator.of(context).pop();
          },
        );

      case 403:
      case 404:
        throw UnauthorisedException(response.body.toString());
      case 500:
        return ALertDialog.showSimpleAlert(
          context,
          AppStrings.ERREUR_MSG,
          AppStrings.OK_LABEL,
          () {
            Navigator.of(context).pop();
          },
        );
      default:
        throw FetchDataException(
          'Error occured while communication with server' +
              ' with status code : ${response.statusCode}',
        );
    }
  }

  final snackBar = SnackBar(
    content: const Text(AppStrings.FAILURE_LABEL),
    backgroundColor: (Colors.black),
    action: SnackBarAction(
      label: AppStrings.REFRESH_LABEL,
      onPressed: () {},
    ),
  );
}
