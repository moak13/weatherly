import '../entity/location_model.dart';
import '../entity/weathers_model.dart';
import '../utils/access_point.dart';
import '../utils/api_result.dart';
import 'base_service.dart';

abstract class GetWeatherService {
  Future<ApiResult<LocationModel>> searchCity({String cityName});
  Future<ApiResult<WeathersModel>> getWeather({int woeId});
}

class GetWeatherServiceImpl extends BaseService implements GetWeatherService {
  @override
  Future<ApiResult<WeathersModel>> getWeather({int woeId}) {
    return get<WeathersModel>(
      url: '${AccessPoint.getWoeId}$woeId/',
      converter: (json) => WeathersModel.fromJson(json),
    );
  }

  @override
  Future<ApiResult<LocationModel>> searchCity({String cityName}) {
    return get<LocationModel>(
      url: AccessPoint.getCityOneTimeData,
      queryParameters: {'query': cityName},
      converter: (json) => LocationModel.fromJson(json),
    );
  }
}
