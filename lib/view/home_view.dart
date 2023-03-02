import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../view/dashboard_view.dart';
import '../components/custom_button.dart';
import '../utils/routes/routes_name.dart';
import '../res/app_colors.dart';
import '../res/app_strings.dart';
import '../res/app_styles.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              AppStrings.WELCOME_LABEL,
              style: AppStyles.globalTextStyle,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 50.0,
                vertical: 20.0,
              ),
              child: CustomButton(
                textColor: AppColors.whiteColor,
                textHoverColor: AppColors.whiteColor,
                hasBorder: false,
                color: AppColors.blueColor,
                hoverColor: AppColors.blackColor,
                title: AppStrings.ENTRER_LABEL,
                onClick: () {
                  _onButtonPressed();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  _onButtonPressed() {
    Navigator.pushNamed(
      context,
      AppRoutesName.dashboard,
      arguments: const DashboardView(),
    );
  }
}
