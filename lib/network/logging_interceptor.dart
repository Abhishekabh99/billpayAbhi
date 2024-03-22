import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../app_router.dart';

class Logging extends Interceptor {
  // String get _userId => GetStorage().read(keyUserId) ?? emptyString;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (kDebugMode) {
      // Logger.print(options);
      _CurlLogger.print(options);
    }

    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
      log('RESPONSE(${response.statusCode}) => ${response.requestOptions.baseUrl + response.requestOptions.path}'
          '\n'
          "api response: ${jsonEncode(response.data)}");
    }
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      debugPrint(
        'ERROR(${err.response?.statusCode}) => ${err.requestOptions.baseUrl + err.requestOptions.path}',
      );
    }
    return super.onError(err, handler);
  }
}

abstract class _SimpleLogger {
  static print(RequestOptions options) {
    debugPrint('REQUEST(${options.method}) => ${options.uri.toString()}');
    debugPrint('Headers: ${options.headers}');
    if (options.queryParameters.isNotEmpty) {
      log("queryParameters: ${options.queryParameters}");
    }

    if (options.data != null) {
      if (options.data is FormData) {
        debugPrint("data: ");
        for (var value in (options.data as FormData).fields) {
          log(value.toString());
        }

        debugPrint("files: ");
        for (var value in (options.data as FormData).files) {
          log("${value.key}: ${value.value.filename}");
        }
      } else {
        log("data: ${options.data}");
      }
    }
  }
}

abstract class _CurlLogger {
  static print(RequestOptions options) {
    String curl = 'curl';
    curl += " --location '${options.uri}'";
    if (options.data != null) {
      // Add the data

      if (options.data is FormData) {
        for (MapEntry entry in (options.data as FormData).fields) {
          curl += " --form '${entry.key}=\"${entry.value}\"'";
        }

        for (MapEntry<String, MultipartFile> entry
            in (options.data as FormData).files) {
          curl += " --form '${entry.key}=@\"${entry.value.filename}\"'";
        }
      } else {
        curl += ' --data \'${options.data}\'';
      }
    }

    if (options.headers.isNotEmpty) {
      // Add the headers
      options.headers.forEach((key, value) {
        curl += ' --header \'$key: $value\'';
      });
    }
    log(curl);
  }
}
