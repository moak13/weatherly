import 'dart:async';

import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../core/utils/router.gr.dart';
import '../../../locator.dart';

class SplashViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  _moveToHome() {
    _navigationService.clearStackAndShow(Routes.home_view);
  }

  handleStartupLogic() async {
    final _duration = Duration(seconds: 2);
    Timer(_duration, _moveToHome);
  }
}
