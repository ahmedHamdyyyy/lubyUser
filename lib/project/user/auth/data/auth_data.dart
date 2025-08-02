import 'package:dio/dio.dart';

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
      data: {
        AppConst.refreshToken: _cacheServices.storage.getString(
          AppConst.refreshToken,
        ),
      },
    );
    if (response.data['success'] == false) throw _responseException(response);
    await _cacheServices.storage.remove(AppConst.accessToken);
    //await _cacheServices.storage.remove(AppConst.user);
    await _cacheServices.storage.remove(AppConst.refreshToken);
    return response.data['data']['message'];
  }

  Future<UserModel> signup({required UserModel user}) async {
    final response = await _apiServices.dio.post(
      ApiConstance.signup,
      data: await user.signUp(),
    );
    final data = response.data['data'];
    if (data == null || data['user'] == null) {
      throw _responseException(response);
    }
    final addedUser = user.copyWith(
      id: data['user'][AppConst.id],
      profilePicture: data['user'][AppConst.profilePicture],
    );
    await _cacheServices.storage.setString(
      AppConst.accessToken,
      data['accessToken'],
    );
    await _cacheServices.storage.setString(
      AppConst.refreshToken,
      data['refreshToken'],
    );
    //await _saveUser(addedUser);
    return addedUser;
  }

  Future<UserModel> signin({
    required String email,
    required String password,
  }) async {
    final loginData = {AppConst.email: email, AppConst.password: password};
    final response = await _apiServices.dio.post(
      ApiConstance.signin,
      data: loginData,
    );
    final data = response.data['data'];
    if (data == null || data['user'] == null) {
      throw _responseException(response);
    }

    final user = UserModel.fromJson(data['user']);
    await _cacheServices.storage.setString(
      AppConst.accessToken,
      data['accessToken'],
    );
    await _cacheServices.storage.setString(
      AppConst.refreshToken,
      data['refreshToken'],
    );

    //await _saveUser(user);
    return user;
  }
/* 
  Future<void> _saveUser(UserModel user) async =>
      await _cacheServices.storage.setString(AppConst.user, user.toCache()); */

  Exception _responseException(Response response) => DioException(
    requestOptions: response.requestOptions,
    response: response,
    error: response.data['error'],
  );

 /*  bool _hasException(Response response) =>
      ![200, 201, 202, 203].contains(response.statusCode) ||
      !(response.data['success'] ?? false); */
}
