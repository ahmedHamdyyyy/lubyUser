import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../config/constants/api_constance.dart';
import '../../config/constants/constance.dart';
import '../../main.dart';
import '../../project/auth/view/Screen/auth/sign_in.dart';
import 'cach_services.dart';

class ApiService {
  ApiService(this._cacheServices);
  final CacheService _cacheServices;
  late Dio dio;

  static void Function()? onForceLogout;

  Future<bool> init() async {
    try {
      dio = Dio(
        BaseOptions(
          baseUrl: ApiConstance.baseUrl,
          connectTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
          sendTimeout: const Duration(seconds: 30),
          validateStatus: (status) => status! < 500,
          headers: {'Accept': '*/*', 'Content-Type': 'application/json', 'Connection': 'keep-alive'},
        ),
      );

      dio.interceptors.add(_ApiInterceptor(_cacheServices, dio));
      return true;
    } on DioException catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}

class _ApiInterceptor extends InterceptorsWrapper {
  _ApiInterceptor(this._cacheService, this._dio);
  final CacheService _cacheService;
  final Dio _dio;

  // Shared refresh lock/completer so only ONE refresh call happens at a time.
  static Completer<bool>? _refreshCompleter;

  Future<void> _forceLogout() async {
    // Remove cached tokens
    await _cacheService.storage.remove(AppConst.accessToken);
    await _cacheService.storage.remove(AppConst.refreshToken);

    // Call the custom callback if registered
    ApiService.onForceLogout?.call();

    // Navigate to signin screen
    final context = navigatorKey.currentContext;
    if (context != null && navigatorKey.currentState != null) {
      navigatorKey.currentState!.pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const SignInScreen()),
        (route) => false,
      );
    }
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint('REQUEST[${options.method}] => PATH: ${options.path}');
    final isMultipart = options.data is FormData;
    final accessToken = _cacheService.storage.getString(AppConst.accessToken);
    if (kDebugMode) {
      debugPrint('Auth header set: ${accessToken != null && accessToken.isNotEmpty}');
    }
    options.headers['Content-Type'] = isMultipart ? 'multipart/form-data' : 'application/json';
    if (isMultipart) options.headers['Accept-Encoding'] = 'gzip, deflate, br';
    if (accessToken != null && accessToken.isNotEmpty) options.headers['Authorization'] = 'Bearer $accessToken';
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    debugPrint('RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    if ([ApiConstance.signup, ApiConstance.resetpassword].contains(response.requestOptions.path)) {
      if (response.data != null && response.data['success']) {
        final accessToken = (response.data['data'] ?? {})['accessToken'];
        final refreshToken = (response.data['data'] ?? {})['refreshToken'];
        if (accessToken != null) await _cacheService.storage.setString(AppConst.accessToken, accessToken);
        if (refreshToken != null) await _cacheService.storage.setString(AppConst.refreshToken, refreshToken);
      }
    } else if (response.statusCode == 401) {
      // Don't attempt refresh for the refresh endpoint itself to avoid loops.
      if (response.requestOptions.path == ApiConstance.refreshToken ||
          response.requestOptions.extra['skipAuthRefresh'] == true) {
        await _forceLogout();
        return handler.next(response);
      }
      final opts = response.requestOptions;
      final alreadyRetried = opts.extra['retried'] == true;
      if (alreadyRetried) {
        await _forceLogout();
        return handler.next(response);
      }
      try {
        // START refresh coordination
        if (_refreshCompleter == null) {
          _refreshCompleter = Completer<bool>();
          try {
            final refreshToken = _cacheService.storage.getString(AppConst.refreshToken);
            if (refreshToken == null || refreshToken.isEmpty) {
              _refreshCompleter!.complete(false);
            } else {
              final accessToken = await getAccessToken(refreshToken);
              if (accessToken.isNotEmpty) {
                _refreshCompleter!.complete(true);
              } else {
                _refreshCompleter!.complete(false);
              }
            }
          } catch (e) {
            if (!(_refreshCompleter?.isCompleted ?? true)) {
              _refreshCompleter!.complete(false);
            }
          }
        }
        final succeeded = await _refreshCompleter!.future; // wait for ongoing refresh
        if (identical(_refreshCompleter?.future, _refreshCompleter?.future)) {
          // After awaiting, clear if this call initiated it (safe to clear regardless)
          if (_refreshCompleter?.isCompleted ?? false) {
            _refreshCompleter = null; // allow future refresh cycles
          }
        }
        if (!succeeded) {
          await _forceLogout();
          return handler.next(response);
        }
        // Apply new token and retry ONCE
        final token = _cacheService.storage.getString(AppConst.accessToken);
        if (token == null || token.isEmpty) {
          await _forceLogout();
          return handler.next(response);
        }
        opts.headers['Authorization'] = 'Bearer $token';
        opts.extra['retried'] = true;
        final cloneReq = await _dio.fetch(opts);
        return handler.resolve(cloneReq);
      } catch (e) {
        await _forceLogout();
        return handler.next(response);
      }
    }
    return handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      final opts = err.requestOptions;
      final alreadyRetried = opts.extra['retried'] == true;
      if (alreadyRetried) {
        await _forceLogout();
        return handler.next(err);
      }
      try {
        if (opts.path == ApiConstance.refreshToken || opts.extra['skipAuthRefresh'] == true) {
          await _forceLogout();
          return handler.next(err);
        }
        if (_refreshCompleter == null) {
          _refreshCompleter = Completer<bool>();
          try {
            final refreshToken = _cacheService.storage.getString(AppConst.refreshToken);
            if (refreshToken == null || refreshToken.isEmpty) {
              _refreshCompleter!.complete(false);
            } else {
              final accessToken = await getAccessToken(refreshToken);
              if (accessToken.isNotEmpty) {
                _refreshCompleter!.complete(true);
              } else {
                _refreshCompleter!.complete(false);
              }
            }
          } catch (e) {
            if (!(_refreshCompleter?.isCompleted ?? true)) {
              _refreshCompleter!.complete(false);
            }
          }
        }
        final succeeded = await _refreshCompleter!.future;
        if (_refreshCompleter?.isCompleted ?? false) {
          _refreshCompleter = null;
        }
        if (!succeeded) {
          await _forceLogout();
          return handler.next(err);
        }
        final token = _cacheService.storage.getString(AppConst.accessToken);
        if (token == null || token.isEmpty) {
          await _forceLogout();
          return handler.next(err);
        }
        opts.headers['Authorization'] = 'Bearer $token';
        opts.extra['retried'] = true;
        final cloneReq = await _dio.fetch(opts);
        return handler.resolve(cloneReq);
      } catch (e) {
        await _forceLogout();
        return handler.next(err);
      }
    }
    super.onError(err, handler);
  }

  Future<String> getAccessToken(String refreshToken) async {
    try {
      final response = await _dio.post(
        ApiConstance.refreshToken,
        data: {AppConst.refreshToken: refreshToken},
        options: Options(extra: {'skipAuthRefresh': true}),
      );
      final accessToken = response.data['data']['accessToken'];
      await _cacheService.storage.setString(AppConst.accessToken, accessToken);
      return accessToken;
    } catch (e) {
      return '';
    }
  }
}
