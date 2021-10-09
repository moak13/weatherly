import 'package:stacked_services/stacked_services.dart';

import '../../features/home/widgets/search_city_sheet.dart';
import '../../locator.dart';

enum BottomSheetType { searchCity }

void setupBottomSheetUi() {
  final bottomSheetService = locator<BottomSheetService>();

  final builders = {
    BottomSheetType.searchCity: (context, sheetRequest, completer) =>
        SearchCitySheet(
          request: sheetRequest,
          completer: completer,
        ),
  };

  bottomSheetService.setCustomSheetBuilders(builders);
}
