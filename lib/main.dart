import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:stacked_themes/stacked_themes.dart';

import 'core/service_ui/setup_bottom_sheet_ui.dart';
import 'core/service_ui/setup_dialog_ui.dart';
import 'core/utils/router.gr.dart' as route;
import 'locator.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  await ThemeManager.initialise();
  setupBottomSheetUi();
  setupDialogUi();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ThemeBuilder(
      defaultThemeMode: ThemeMode.light,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        backgroundColor: Colors.black,
        primaryColor: Colors.white,
        accentColor: Colors.white,
        indicatorColor: Colors.white24,
      ),
      lightTheme: ThemeData(
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        primaryColor: Colors.black,
        accentColor: Colors.black,
        indicatorColor: Colors.black26,
      ),
      builder: (context, regularTheme, darkTheme, themeMode) => MaterialApp(
        title: 'Weatherly',
        theme: regularTheme,
        darkTheme: darkTheme,
        themeMode: themeMode,
        navigatorKey: StackedService.navigatorKey,
        initialRoute: route.Routes.splash_view,
        onGenerateRoute: route.Router().onGenerateRoute,
      ),
    );
  }
}
