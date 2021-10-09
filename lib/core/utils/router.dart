import 'package:auto_route/auto_route_annotations.dart';

import '../../features/home/home_view.dart';
import '../../features/splash/splash_view.dart';

@AdaptiveAutoRouter(
  routes: <AutoRoute>[
    AdaptiveRoute(page: SplashView, name: 'splash_view', initial: true),
    AdaptiveRoute(page: HomeView, name: 'home_view'),
  ],
)
class $Router {}
