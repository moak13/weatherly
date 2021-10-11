// import 'package:mockito/mockito.dart';
// import 'package:stacked_services/stacked_services.dart';
// import 'package:weatherly/core/services/get_weather_service.dart';
// import 'package:weatherly/locator.dart';

// /// Navigation Service Mock Class
// class MockNavigationService extends Mock implements NavigationService {}

// /// Get Weather Service Mock Class
// class MockGetWeatherService extends Mock implements GetWeatherService {}

// /// Navigation Service registration for Mocking
// MockNavigationService getAndRegisterNavigationService() {
//   _removeRegistrationIfExists<NavigationService>();
//   final service = MockNavigationService();
//   locator.registerSingleton<NavigationService>(service);
//   return service;
// }

// /// Get Weather Service registration for Mocking
// MockGetWeatherService getAndRegisterGetWeatherService() {
//   _removeRegistrationIfExists<GetWeatherService>();
//   final service = MockGetWeatherService();
//   locator.registerSingleton<GetWeatherService>(service);
//   return service;
// }

// // Helps to register all the services needed for testing
// void registerServices() {
//   getAndRegisterNavigationService();
//   getAndRegisterGetWeatherService();
// }

// /// Helps to unregister the services when not in use
// void unRegisterServices() {
//   locator.unregister<NavigationService>();
//   locator.unregister<GetWeatherService>();
// }

// /// This function helps us to check if a service is already registered if it is, unregisters else, it sets it
// void _removeRegistrationIfExists<T extends Object>() {
//   if (locator.isRegistered<T>()) {
//     locator.unregister<T>();
//   }
// }
