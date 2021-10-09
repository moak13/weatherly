import '../error/network_exceptions.dart';
import '../network/dio_client.dart';
import '../utils/api_result.dart';

class BaseService {
  final _dioClient = DioClient();

  Future<ApiResult<T>> get<T>({
    String url,
    Map<String, dynamic> queryParameters,
    Function converter,
  }) async {
    try {
      final response = await _dioClient.get(
        url,
        queryParameters: queryParameters,
      );
      return ApiResult.success(
        data: converter(response),
      );
    } catch (e) {
      return ApiResult.failure(
        error: NetworkExceptions.getDioException(e),
      );
    }
  }
}
