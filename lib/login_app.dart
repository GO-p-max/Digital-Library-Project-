import 'package:flutter/material.dart';

import 'routes.dart';
import 'helpers/navigation_helper.dart';
import 'helpers/snackbar_helper.dart';
import 'list_co/app_routes.dart';
import 'list_co/app_strings.dart';
import 'list_co/app_theme.dart';

class LoginApp extends StatefulWidget {
  const LoginApp({super.key});

  @override
  State<LoginApp> createState() => _LoginAppState();
}

class _LoginAppState extends State<LoginApp> {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
     debugShowCheckedModeBanner: false,
      title: AppStrings.loginAndRegister,
      theme: AppTheme.themeData,
      initialRoute: AppRoutes.login, 
      scaffoldMessengerKey: SnackbarHelper.key,
      navigatorKey: NavigationHelper.key,
      onGenerateRoute: Routes.generateRoute,
    );
  }
}