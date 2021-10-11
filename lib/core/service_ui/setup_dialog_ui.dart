import 'package:stacked_services/stacked_services.dart';

import '../../features/home/widgets/settings_dialog.dart';
import '../../locator.dart';

enum DialogType { settings }

void setupDialogUi() {
  final bottomSheetService = locator<DialogService>();

  final builders = {
    DialogType.settings: (context, sheetRequest, completer) => SettingsDialog(
          request: sheetRequest,
          completer: completer,
        ),
  };

  bottomSheetService.registerCustomDialogBuilders(builders);
}
