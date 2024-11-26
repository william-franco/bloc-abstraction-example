import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

abstract interface class HttpService {
  Future<Response> getData({required String path});
}

class HttpServiceImpl implements HttpService {
  final _httpClient = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
      headers: {'Content-Type': 'application/json'},
    ),
  );

  HttpServiceImpl() {
    _httpClient.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          debugPrint('Sending request to: ${options.uri}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          debugPrint('Received response: ${response.statusCode}');
          return handler.next(response);
        },
        onError: (DioException e, handler) async {
          int retryCount = 0;
          int maxRetries = 3;
          while (retryCount < maxRetries &&
              e.type == DioExceptionType.connectionTimeout) {
            retryCount++;
            try {
              debugPrint('Connection timeout, retrying...');
              final res = await _httpClient.request(e.requestOptions.path);
              return handler.resolve(res);
            } catch (e) {
              debugPrint('$e');
            }
          }
          return handler.next(e);
        },
      ),
    );
  }

  @override
  Future<Response> getData({required String path}) async {
    try {
      _httpClient.options;
      final response = await _httpClient.get(path);
      return response;
    } catch (error) {
      throw Exception(error);
    }
  }
}
