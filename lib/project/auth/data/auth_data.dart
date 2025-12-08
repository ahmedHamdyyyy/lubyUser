import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../../../../config/constants/api_constance.dart';
import '../../../../../config/constants/constance.dart';
import '../../../../../core/services/api_services.dart';
import '../../../../../core/services/cach_services.dart';
import '../../models/user.dart';

class AuthData {
  const AuthData(this._apiServices, this._cacheServices);
  final ApiService _apiServices;
  final CacheService _cacheServices;

  Future<String> signout() async {
    final response = await _apiServices.dio.post(
      ApiConstance.logout,
      data: {AppConst.refreshToken: _cacheServices.storage.getString(AppConst.refreshToken)},
    );
    if (response.data['success'] == false) throw _responseException(response);
    await _cacheServices.storage.clear();
    return response.data['data']['message'];
  }

  Future<UserModel> signup({required UserModel user}) async {
    final mapData = await user.signUp();
    final response = await _apiServices.dio.post(ApiConstance.signup, data: mapData);
    final data = response.data['data'];
    if (data == null || data['user'] == null) throw _responseException(response);
    final addedUser = user.copyWith(id: data['user'][AppConst.id], profilePicture: data['user'][AppConst.profilePicture]);
    await _cacheServices.storage.setString(AppConst.accessToken, data['accessToken']);
    await _cacheServices.storage.setString(AppConst.refreshToken, data['refreshToken']);
    return addedUser;
  }

  Future<void> initiateSignin({required String phone}) async {
    final deviceId = await getDeviceId();
    final response = await _apiServices.dio.post(
      ApiConstance.initiateSignin,
      data: {AppConst.phone: phone},
      options: Options(headers: {'X-Device-ID': deviceId}),
    );
    if (response.statusCode != 200) throw _responseException(response);
  }

  Future<UserModel> verifySignin({required String phone, required String code}) async {
    final loginData = {AppConst.phone: phone, 'code': code};
    try {
      final fcmToken = await FirebaseMessaging.instance.getToken();
      if (fcmToken != null && fcmToken.isNotEmpty) loginData['fcmToken'] = fcmToken;
    } catch (_) {
      // ignore token failures silently for login
    }
    final response = await _apiServices.dio.post(ApiConstance.verifySignin, data: loginData);
    final data = response.data['data'];
    if (data == null || data['user'] == null) throw _responseException(response);
    final user = UserModel.fromJson(data['user']);
    await _cacheServices.storage.setString(AppConst.accessToken, data['accessToken']);
    await _cacheServices.storage.setString(AppConst.refreshToken, data['refreshToken']);
    return user;
  }

  Exception _responseException(Response response) =>
      DioException(requestOptions: response.requestOptions, response: response, error: response.data['error']);

  Future<void> verifyPhone({required String phone}) async {
    final response = await _apiServices.dio.post(
      ApiConstance.initiateSignup,
      data: {AppConst.phone: phone},
      options: Options(headers: {'X-Device-ID': 256454}),
    );
    if (response.statusCode != 200) throw _responseException(response);
  }

  Future<String> confirmOtpSignUp(String phone, String otp, bool willSignup) async {
    final response = await _apiServices.dio.post(
      willSignup ? ApiConstance.confirmOtpSignUp : ApiConstance.confirmOtpResetPassword,
      data: {AppConst.phone: phone, 'code': otp},
    );
    if (response.data['success'] == false) throw _responseException(response);
    return response.data['data']['message'];
  }

  Future<String> getDeviceId() async {
    final deviceInfo = DeviceInfoPlugin();
    if (await deviceInfo.deviceInfo is AndroidDeviceInfo) {
      final androidInfo = await deviceInfo.androidInfo;
      return androidInfo.id;
    } else if (await deviceInfo.deviceInfo is IosDeviceInfo) {
      final iosInfo = await deviceInfo.iosInfo;
      return iosInfo.identifierForVendor ?? '';
    } else {
      return '';
    }
  }

  Future<String> resetPassword(String email, String newPassword) async {
    final response = await _apiServices.dio.post(ApiConstance.forgetPasswordReset, data: {'newPassword': newPassword});
    if (response.data['success'] == false) throw _responseException(response);
    return response.data['data']['message'];
  }
}
