import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/foundation.dart';

import '../utils/access_point.dart';

const _defaultConnectTimeout = Duration.millisecondsPerHour;
const _defaultReceiveTimeout = Duration.millisecondsPerHour;

class DioClient {
  Dio _dio;

  final List<Interceptor> interceptors;

  DioClient({
    this.interceptors,
  }) {
    _dio = Dio();
    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    _dio
      ..options.baseUrl = AccessPoint.baseUrl
      ..options.connectTimeout = _defaultConnectTimeout
      ..options.receiveTimeout = _defaultReceiveTimeout
      ..httpClientAdapter;
    if (interceptors?.isNotEmpty ?? false) {
      _dio.interceptors.add(DioCacheManager(CacheConfig(
        defaultMaxAge: Duration(days: 10),
        maxMemoryCacheCount: 3,
      )).interceptor);
      _dio.interceptors.addAll(interceptors);
    }
    if (kDebugMode) {
      _dio.interceptors.add(LogInterceptor(
          responseBody: true,
          error: true,
          requestHeader: true,
          responseHeader: false,
          request: false,
          requestBody: true));
    }
  }

  Future get(
    String uri, {
    Map<String, dynamic> queryParameters,
    CancelToken cancelToken,
    ProgressCallback onReceiveProgress,
  }) async {
    try {
      var response = await _dio.get(
        uri,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } catch (e) {
      throw e;
    }
  }
}
