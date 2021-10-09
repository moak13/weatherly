import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'orientation/home_landscape_view.dart';
import 'orientation/home_portrait_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: OrientationLayoutBuilder(
        portrait: (context) => HomePortraitView(),
        landscape: (context) => HomeLandscapeView(),
      ),
    );
  }
}
