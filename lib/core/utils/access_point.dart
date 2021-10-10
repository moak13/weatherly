class AccessPoint {
  /// Base endpoint for meta weather
  static String baseUrl = 'https://www.metaweather.com';

  /// Url to get city data
  static String getCityOneTimeData = '/api/location/search';

  /// Url to get list of weather data via woeid
  static String getWoeId = '/api/location/';

  /// Url to get weather svg image
  static String getWeatherImage = baseUrl + '/static/img/weather/';
}
