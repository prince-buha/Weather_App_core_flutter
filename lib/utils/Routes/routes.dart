import 'package:flutter/cupertino.dart';
import 'package:weather_app_flutter_api/modules/screen/homescreen/views/homescreen.dart';

import '../../modules/screen/spleshscreen/splesh_screen.dart';

class Routes {
  static String spleshscreen = '/';
  static String homescreen = 'home_screen';

  static Map<String, WidgetBuilder> myRoutes = {
    spleshscreen: (context) => const SplashScreen(),
    homescreen: (context) => const HomeScreen(),
  };
}
