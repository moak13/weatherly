// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import 'package:weatherly/core/utils/router.gr.dart';
// import 'package:weatherly/features/splash/view_model/splash_viewmodel.dart';

// import '../helpers/test_helpers.dart';

// SplashViewModel _getModel() => SplashViewModel();

// void main() {
//   group('SplashViewModelTest -', () {
//     setUp(() => registerServices());
//     tearDown(() => unRegisterServices());

//     group('runStartUpLogic -', () {
//       test(
//           'When application starts, Should wait 2 secs then navigate to homeView',
//           () async {
//         // Arrange
//         final navigationService = getAndRegisterNavigationService();
//         final model = _getModel();

//         // Act
//         await model.handleStartupLogic();

//         // Assert
//         verify(navigationService.navigateTo(Routes.home_view));
//       });
//     });
//   });
// }
