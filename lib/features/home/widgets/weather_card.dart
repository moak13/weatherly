import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WeatherCard extends StatelessWidget {
  final String day;
  final String minTemp;
  final String maxTemp;
  final String iconName;
  final Function onTap;
  final bool isSelected;
  const WeatherCard({
    Key key,
    this.day,
    this.minTemp,
    this.maxTemp,
    this.iconName,
    this.onTap,
    this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    var theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      child: Container(
        height: orientation == Orientation.portrait ? 150 : 200,
        width: orientation == Orientation.portrait ? 200 : 150,
        margin: orientation == Orientation.portrait
            ? const EdgeInsets.symmetric(horizontal: 5, vertical: 20)
            : const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected
              ? theme.primaryColor.withOpacity(0.7)
              : theme.backgroundColor,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            isSelected
                ? BoxShadow(
                    color: theme.backgroundColor.withOpacity(0.9),
                    spreadRadius: -15,
                    blurRadius: 15.0,
                    offset: Offset(1, 20),
                  )
                : BoxShadow(
                    color: theme.primaryColor.withOpacity(0.9),
                    spreadRadius: -15,
                    blurRadius: 15.0,
                    offset: Offset(1, 20),
                  ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              day,
              style: TextStyle(
                color: isSelected ? theme.backgroundColor : theme.primaryColor,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            orientation == Orientation.portrait
                ? SvgPicture.network(
                    'https://www.metaweather.com/static/img/weather/$iconName.svg',
                    height: 50,
                    width: 50,
                    fit: BoxFit.contain,
                  )
                : SvgPicture.network(
                    'https://www.metaweather.com/static/img/weather/$iconName.svg',
                    height: 70,
                    width: 70,
                    fit: BoxFit.contain,
                  ),
            SizedBox(
              height: 5,
            ),
            Text(
              '$minTemp / $maxTemp',
              style: TextStyle(
                color: isSelected ? theme.backgroundColor : theme.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
