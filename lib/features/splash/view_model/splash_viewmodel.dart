import 'dart:async';

import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../locator.dart';
import '../../home/home_view.dart';

class SplashViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  _moveToHome() {
    _navigationService.navigateToView(HomeView());
  }

  handleStartupLogic() async {
    final _duration = Duration(seconds: 2);
    Timer(_duration, _moveToHome);
  }
}
