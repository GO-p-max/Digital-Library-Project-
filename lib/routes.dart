import 'package:flutter/material.dart';

import 'screen/login_screen.dart';
import 'screen/register_screen.dart';
import 'common_widgets/invalid_route.dart';
import 'list_co/app_routes.dart';

class Routes {
  const Routes._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    Route<dynamic> getRoute({
      required Widget widget,
      bool fullscreenDialog = false,
    }) {
      return MaterialPageRoute<void>(
        builder: (context) => widget,
        settings: settings,
        fullscreenDialog: fullscreenDialog,
      );
    }

    switch (settings.name) {
      case AppRoutes.login:           // ** تسجيل الدخول **
        return getRoute(widget: const LoginPage());

      case AppRoutes.register:        // ** انشاء حساب **
        return getRoute(widget: const RegisterPage());

      /// An invalid route. User shouldn't see this,
      default:
        return getRoute(widget: const InvalidRoute());
    }
  }
}
