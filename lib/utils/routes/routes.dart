import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../view/home_view.dart';
import '../../view/dashboard_view.dart';

import 'routes_name.dart';

class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutesName.home:
        return MaterialPageRoute(
          builder: (BuildContext context) => const HomeView(),
        );

      case AppRoutesName.dashboard:
        return MaterialPageRoute(
          builder: (BuildContext context) => const DashboardView(),
        );

      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text('No route defined'),
            ),
          );
        });
    }
  }

  static navigateToHome(BuildContext context) {
    Navigator.pushNamed(
      context,
      AppRoutesName.home,
      arguments: const HomeView(),
    );
  }
}
