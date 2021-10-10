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
  final _snackService = locator<SnackbarService>();
  final _getWeatherService = locator<GetWeatherService>();

  bool _noData = true;

  /// This is a getter to help us track when to show an initial view
  bool get noData => _noData;

  bool _foundError = false;

  /// This getter helps us to know where an error has occured
  bool get foundError => _foundError;

  /// This holds the resulting list of weathers
  List<ConsolidatedWeather> _resultWeather = [];
  List<ConsolidatedWeather> get resultWeathers => _resultWeather;

  /// This helps us to hold asigned weather
  ConsolidatedWeather _weather;
  ConsolidatedWeather get weather => _weather;

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
        if (success.woeid == 0) {
          setBusy(false);
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
      failure: (NetworkExceptions error) {
        setBusy(false);
        _snackService.showSnackbar(
          message: NetworkExceptions.getErrorMessage(error),
        );
      },
    );
  }

  /// This is the function to get the list of weather for an supported location
  _getCityWeathers({int woeId}) async {
    final response = await _getWeatherService.getWeather(woeId: woeId);
    response.when(
      success: (WeathersModel success) {
        setBusy(false);
        _resultWeather = success.consolidatedWeather;
        _weather = success.consolidatedWeather.first;
        notifyListeners();
      },
      failure: (NetworkExceptions error) {
        setBusy(false);
        _snackService.showSnackbar(
          message: NetworkExceptions.getErrorMessage(error),
        );
      },
    );
  }

  /// This helps to set selected weatherDeatails
  setWeatherDetails(ConsolidatedWeather weather) {
    _weather = weather;
    notifyListeners();
  }
}
