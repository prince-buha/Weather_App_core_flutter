import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app_flutter_api/modules/screen/homescreen/views/homescreen.dart';
import 'package:weather_app_flutter_api/utils/Routes/routes.dart';
import 'modules/screen/homescreen/Provider/platefrom.dart';
import 'modules/screen/homescreen/Provider/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  bool isvisited = preferences.getBool("isIntroVisited") ?? false;
  runApp(MultiProvider(
    providers: [
      ListenableProvider<platfrom>(
        create: (context) => platfrom(),
      ),
      ListenableProvider<themeprovider>(
        create: (context) => themeprovider(),
      ),
    ],
    builder: (context, _) =>
        (Provider.of<platfrom>(context, listen: true).isios == false)
            ? MaterialApp(
                theme: ThemeData.light(useMaterial3: true),
                darkTheme: ThemeData.dark(useMaterial3: true),
                themeMode: (Provider.of<themeprovider>(context, listen: true)
                            .theme
                            .isdark ==
                        true)
                    ? ThemeMode.light
                    : ThemeMode.dark,
                debugShowCheckedModeBanner: false,
                routes: Routes.myRoutes)
            : CupertinoApp(
                theme: (Provider.of<themeprovider>(context, listen: true)
                            .theme
                            .isdark ==
                        true)
                    ? const CupertinoThemeData(brightness: Brightness.dark)
                    : const CupertinoThemeData(brightness: Brightness.light),
                debugShowCheckedModeBanner: false,
              ),
  ));
}
