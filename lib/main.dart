import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewmodel/dashboard_view_model.dart';
import '../../utils/routes/routes.dart';
import '../../utils/routes/routes_name.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: DashboardViewModel()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutesName.home,
        onGenerateRoute: AppRoutes.generateRoute,
      ),
    );
  }
}
