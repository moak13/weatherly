import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../view_model/home_viewmodel.dart';

class HomeLandscapeView extends StatelessWidget {
  const HomeLandscapeView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: Colors.yellow,
          body: SafeArea(
            child: model.isBusy
                ? Center(child: CircularProgressIndicator())
                : model.noData
                    ? Center(
                        child: Text('Initial'),
                      )
                    : Center(
                        child:
                            model.foundError ? Text('Error') : Text('No Error'),
                      ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              model.triggerSearchSheet();
            },
            child: Icon(Icons.search),
          ),
        );
      },
      viewModelBuilder: () => HomeViewModel(),
    );
  }
}