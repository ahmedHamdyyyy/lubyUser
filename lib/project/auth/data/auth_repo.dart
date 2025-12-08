import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/error/dio_error.dart';
import '../../models/user.dart';
import 'auth_data.dart';

class AuthRepo {
  const AuthRepo(this._authData);
  final AuthData _authData;

  Future<UserModel> signup({required UserModel user}) async {
    try {
      return await _authData.signup(user: user);
    } on DioException catch (e) {
      throw ApiExceptionHandler.handle(e);
    } catch (e) {
      debugPrint(e.toString());
      throw Exception('An unexpected error occurred');
    }
  }

  Future<void> initiateSignin({required String phone}) async {
    try {
      return await _authData.initiateSignin(phone: phone);
    } on DioException catch (e) {
      throw ApiExceptionHandler.handle(e);
    } catch (e) {
      throw Exception('An unexpected error occurred. Please try again later.');
    }
  }

  Future<UserModel> verifySignin({required String phone, required String code}) async {
    try {
      return await _authData.verifySignin(phone: phone, code: code);
    } on DioException catch (e) {
      throw ApiExceptionHandler.handle(e);
    } catch (e) {
      throw Exception('An unexpected error occurred. Please try again later.');
    }
  }

  Future<String> signout() async {
    try {
      return await _authData.signout();
    } on DioException catch (e) {
      debugPrint(e.response?.data.toString());
      throw Exception(e.response?.data['error']);
    } catch (e) {
      debugPrint(e.toString());
      throw Exception('An unexpected error occurred');
    }
  }

  Future<void> verifyPhone({required String phone}) async {
    try {
      await _authData.verifyPhone(phone: phone);
    } on DioException catch (e) {
      debugPrint(e.response?.data.toString());
      throw Exception(e.response?.data['error']);
    } catch (e) {
      debugPrint(e.toString());
      throw Exception('An unexpected error occurred');
    }
  }

  Future<void> confirmOtp(String phone, String otp, bool willSignup) async {
    try {
      await _authData.confirmOtpSignUp(phone, otp, willSignup);
    } on DioException catch (e) {
      debugPrint(e.response?.data.toString());
      throw Exception(e.response?.data['error']);
    } catch (e) {
      debugPrint(e.toString());
      throw Exception('An unexpected error occurred');
    }
  }

  Future<String> resetPassword(String email, String newPassword) async {
    try {
      return await _authData.resetPassword(email, newPassword);
    } on DioException catch (e) {
      debugPrint(e.response?.data.toString());
      throw Exception(e.response?.data['error']);
    } catch (e) {
      debugPrint(e.toString());
      throw Exception('An unexpected error occurred');
    }
  }
}
