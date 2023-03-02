import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppStyles {
  static const globalTextStyle = TextStyle(
    color: AppColors.blackColor,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w600,
    fontSize: 17.0,
  );
  static const boldTextStyle = TextStyle(
    color: AppColors.blackColor,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.bold,
    fontSize: 17.0,
  );
  static const greyTextStyle = TextStyle(
    color: Colors.black54,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w600,
    fontSize: 17.0,
  );

  static const globalButtonStyle = TextStyle(
    color: AppColors.whiteColor,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w500,
    fontSize: 18.0,
  );
  static const buttonTitleStyle = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.w500,
  );
}
