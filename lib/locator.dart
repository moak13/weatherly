import 'package:get_it/get_it.dart';
import 'package:stacked_services/stacked_services.dart';

import 'core/services/get_weather_service.dart';
import 'features/home/view_model/home_viewmodel.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => BottomSheetService());
  locator.registerLazySingleton(() => SnackbarService());
  locator.registerLazySingleton(() => StackedService());
  locator
      .registerLazySingleton<GetWeatherService>(() => GetWeatherServiceImpl());
  locator.registerLazySingleton(() => HomeViewModel());
}
