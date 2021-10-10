import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stacked/stacked.dart';
import 'package:intl/intl.dart';

import '../../../locator.dart';
import '../view_model/home_viewmodel.dart';
import '../widgets/weather_card.dart';

class HomePortraitView extends StatelessWidget {
  const HomePortraitView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      disposeViewModel: false,
      builder: (context, model, child) {
        return Scaffold(
          body: SafeArea(
            child: model.isBusy
                ? Center(child: CircularProgressIndicator())
                : model.noData
                    ? Center(
                        child: Text('Initial'),
                      )
                    : Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: model.foundError
                            ? Text('Error')
                            : Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Align(
                                    alignment: Alignment.topCenter,
                                    child: Text(
                                      DateFormat(DateFormat.WEEKDAY)
                                          .format(DateTime.now())
                                          .toUpperCase(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Container(
                                      height: 200,
                                      width: 350,
                                      padding: const EdgeInsets.all(5),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            model.weather.weatherStateName,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 35,
                                          ),
                                          Align(
                                            alignment: Alignment.center,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                SvgPicture.network(
                                                  'https://www.metaweather.com/static/img/weather/${model.weather.weatherStateAbbr}.svg',
                                                  height: 100,
                                                  width: 100,
                                                  fit: BoxFit.cover,
                                                ),
                                                SizedBox(
                                                  height: 15,
                                                ),
                                                Text(
                                                  '${model.weather.theTemp} C',
                                                  style: TextStyle(
                                                    fontSize: 30,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 100,
                                          ),
                                          Text(
                                            'Humidity: ${model.weather.humidity}%',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            'Pressure: ${model.weather.airPressure} hPa',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            'Wind: ${model.weather.windSpeed} km/h',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: ListView.builder(
                                      itemCount: model.resultWeathers.length,
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        return WeatherCard(
                                          onTap: () {
                                            model.setWeatherDetails(
                                                model.resultWeathers[index]);
                                          },
                                          isSelected: model.weather ==
                                              model.resultWeathers[index],
                                          iconName: model.resultWeathers[index]
                                              .weatherStateAbbr,
                                        );
                                      },
                                    ),
                                  ),
                                  // Text(model.weather.weatherStateName),
                                  // SvgPicture.network(
                                  //   'https://www.metaweather.com/static/img/weather/${model.weather.weatherStateAbbr}.svg',
                                  //   height: 100,
                                  //   width: 100,
                                  //   fit: BoxFit.cover,
                                  // ),
                                  // SizedBox(
                                  //   height: 25,
                                  // ),
                                  // Container(
                                  //   height: 200,
                                  //   width: double.infinity,
                                  //   margin: const EdgeInsets.only(left: 20),
                                  //   child: ListView.builder(
                                  //     itemCount: model.resultWeathers.length,
                                  //     scrollDirection: Axis.horizontal,
                                  //     shrinkWrap: true,
                                  //     itemBuilder: (context, index) {
                                  //       return WeatherCard(
                                  //         onTap: () {
                                  //           model.setWeatherDetails(
                                  //               model.resultWeathers[index]);
                                  //         },
                                  //         isSelected: model.weather ==
                                  //             model.resultWeathers[index],
                                  //         iconName: model
                                  //             .resultWeathers[index]
                                  //             .weatherStateAbbr,
                                  //       );
                                  //     },
                                  //   ),
                                  // )
                                ],
                              ),
                      ),
          ),
          floatingActionButton: SpeedDial(
            animatedIcon: AnimatedIcons.menu_close,
            animatedIconTheme: IconThemeData(color: Colors.white),
            backgroundColor: Colors.black,
            overlayColor: Colors.white,
            overlayOpacity: 0.4,
            children: [
              SpeedDialChild(
                child: Icon(
                  Icons.search,
                ),
                onTap: () {
                  model.triggerSearchSheet();
                },
              ),
              SpeedDialChild(
                child: Icon(
                  Icons.settings,
                ),
                onTap: () {
                  model.triggerSettingsDialog();
                },
              )
            ],
          ),
        );
      },
      viewModelBuilder: () => locator<HomeViewModel>(),
    );
  }
}
