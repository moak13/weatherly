import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../core/entity/location_model.dart';
import '../../../core/entity/weathers_model.dart';
import '../../../core/error/network_exceptions.dart';
import '../../../core/service_ui/setup_bottom_sheet_ui.dart';
import '../../../core/services/get_weather_service.dart';
import '../../../locator.dart';

class HomeViewModel extends BaseViewModel {
  final _dialogService = locator<DialogService>();
  final _sheetService = locator<BottomSheetService>();
  final _getWeatherService = locator<GetWeatherService>();

  bool _noData = true;

  /// This is a getter to help us track when to show an intial view
  bool get noData => _noData;

  bool _foundError = false;

  /// This getter helps us to know where an error has occured
  bool get foundError => _foundError;

  /// This helps to trigger a dialog which is used to perform settings operation like change temperature reading and theme
  triggerSettingsDialog() async {
    final response = await _dialogService.showDialog(
        title: 'settings', description: 'Just testing out');
  }

  /// This helps to trigger a bottom sheet that allows a user to perform a search operation
  triggerSearchSheet() async {
    final response = await _sheetService.showCustomSheet(
      variant: BottomSheetType.searchCity,
    );
    if (response.confirmed == true) {
      _searchCity(cityName: response.responseData);
    }
  }

  /// This helps a user to search for a city and get a result back
  _searchCity({String cityName}) async {
    setBusy(true);
    final response = await _getWeatherService.searchCity(cityName: cityName);
    response.when(
      success: (LocationModel success) {
        setBusy(false);
        if (success.woeid == 0) {
          _noData = false;
          _foundError = true;
          notifyListeners();
        } else {
          _getCityWeathers(woeId: success.woeid);
          _noData = false;
          _foundError = false;
          notifyListeners();
        }
      },
      failure: (NetworkExceptions error) {},
    );
  }

  /// This is the function to get the list of weather for an supported location
  _getCityWeathers({int woeId}) async {
    final response = await _getWeatherService.getWeather(woeId: woeId);
    response.when(
      success: (WeathersModel success) {},
      failure: (NetworkExceptions error) {},
    );
  }
}
