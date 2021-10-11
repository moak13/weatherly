import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stacked/stacked.dart';
import 'package:intl/intl.dart';
import 'package:weatherly/core/utils/helper_functions.dart';

import '../../../locator.dart';
import '../view_model/home_viewmodel.dart';
import '../widgets/weather_card.dart';

class HomeLandscapeView extends StatelessWidget {
  const HomeLandscapeView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return ViewModelBuilder<HomeViewModel>.reactive(
      disposeViewModel: false,
      onModelReady: (model) => model.fetchOnInit(),
      fireOnModelReadyOnce: true,
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: theme.backgroundColor,
          appBar: AppBar(
            centerTitle: true,
            elevation: 0.0,
            title: Text(
              DateFormat(DateFormat.WEEKDAY)
                  .format(HelperFunctions.convertStringDate(
                      model.weather.applicableDate))
                  .toUpperCase(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: theme.primaryColor,
              ),
            ),
          ),
          body: model.isBusy
              ? Center(
                  child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(theme.accentColor),
                  ),
                )
              : model.foundError
                  ? Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'ERROR',
                            style: TextStyle(
                              color: theme.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          InkWell(
                            onTap: () {
                              model.fetchOnInit();
                            },
                            child: Container(
                              height: 50,
                              width: 250,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: theme.primaryColor,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                'Retry',
                                style: TextStyle(
                                  color: theme.backgroundColor,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  : RefreshIndicator(
                      onRefresh: () => model.fetchOnInit(),
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                height: 300,
                                width: 250,
                                padding: const EdgeInsets.all(5),
                                margin: const EdgeInsets.only(top: 30),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      model.weather.weatherStateName,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 25,
                                    ),
                                    Row(
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
                                          width: 15,
                                        ),
                                        Text(
                                          HelperFunctions.cOrFConverter(
                                            value: model.tempState,
                                            temp: model.weather.theTemp,
                                          ),
                                          style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 50,
                                    ),
                                    Text(
                                      'Humidity: ${model.weather.humidity}%',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'Pressure: ${model.weather.airPressure} hPa',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'Wind: ${model.weather.windSpeed.toStringAsPrecision(2)} km/h',
                                      style: TextStyle(
                                        fontSize: 15,
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
                                shrinkWrap: true,
                                padding: const EdgeInsets.only(top: 20),
                                itemBuilder: (context, index) {
                                  return WeatherCard(
                                    onTap: () {
                                      model.setWeatherDetails(
                                          model.resultWeathers[index]);
                                    },
                                    day:
                                        '${DateFormat(DateFormat.ABBR_WEEKDAY).format(HelperFunctions.convertStringDate(model.resultWeathers[index].applicableDate)).toUpperCase()}',
                                    isSelected: model.weather ==
                                        model.resultWeathers[index],
                                    iconName: model
                                        .resultWeathers[index].weatherStateAbbr,
                                    minTemp: HelperFunctions.cOrFConverter(
                                      value: model.tempState,
                                      temp: model.weather.minTemp,
                                    ),
                                    maxTemp: HelperFunctions.cOrFConverter(
                                      value: model.tempState,
                                      temp: model.weather.maxTemp,
                                    ),
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
          floatingActionButton: SpeedDial(
            animatedIcon: AnimatedIcons.menu_close,
            animatedIconTheme: IconThemeData(color: theme.backgroundColor),
            backgroundColor: theme.primaryColor,
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
              ),
              SpeedDialChild(
                child: Icon(
                  Icons.switch_left,
                ),
                onTap: () {
                  model.switchTheme();
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
