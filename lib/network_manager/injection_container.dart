import 'dart:convert';
import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:tentwentytask/config/print_value.dart';
import '../main.dart';

Dio getDio() {
  Dio dio = Dio();

  dio.interceptors
      .add(InterceptorsWrapper(onRequest: (RequestOptions options, handler) {
    printValue(tag: 'API URL:', '${options.uri}');
    printValue(tag: 'HEADER:', options.headers);

    try {
      printValue(tag: 'REQUEST BODY: ', jsonEncode(options.data));
    } catch (e) {
      printValue(tag: 'REQUEST BODY ERROR: ', e.toString());
    }

    return handler.next(options);
  }, onResponse: (Response response, ResponseInterceptorHandler handler) {
    printValue(tag: 'API RESPONSE:', response.data);
    return handler.next(response);
  }, onError: (DioException e, handler) {
    printValue(tag: 'STATUS CODE:', "${e.response?.statusCode ?? ""}");
    printValue(tag: 'ERROR DATA :', e.response?.data ?? "");
    if (e.response?.statusCode == 401) {
      // Navigate here
    } else if (e.response?.statusCode == 400) {
      // toast
    }

    return handler.next(e);
  }));
  return dio;
}
