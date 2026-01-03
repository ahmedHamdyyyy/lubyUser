import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/constants/constance.dart';
import '../../models/user.dart';
import '../data/auth_repo.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._repo) : super(const AuthState());
  final AuthRepo _repo;

  Future<void> signup(UserModel user) async {
    emit(state.copyWith(signupStatus: Status.loading));
    try {
      final addedUser = await _repo.signup(user: user);
      emit(state.copyWith(signupStatus: Status.success, msg: 'Signup successful', user: addedUser));
    } catch (e) {
      final msg = AppConst.normalizeError(e);
      emit(
        state.copyWith(
          signupStatus: Status.error,
          msg: msg == 'email already registered' ? 'Email already registered' : msg,
        ),
      );
    }
    emit(state.copyWith(signupStatus: Status.initial));
  }

  Future<void> initiateSignin({required String phone}) async {
    emit(state.copyWith(initiateSigninStatus: Status.loading));
    try {
      await _repo.initiateSignin(phone: phone);
      emit(state.copyWith(msg: 'OTP sent successfully', initiateSigninStatus: Status.success));
    } catch (e) {
      emit(state.copyWith(initiateSigninStatus: Status.error, msg: AppConst.normalizeError(e)));
    }
    emit(state.copyWith(initiateSigninStatus: Status.initial));
  }

  Future<void> verifySignin({required String phone, required String code}) async {
    emit(state.copyWith(verifySigninStatus: Status.loading));
    try {
      final user = await _repo.verifySignin(phone: phone, code: code);
      emit(state.copyWith(msg: 'Authentication successful', verifySigninStatus: Status.success, user: user));
    } catch (e) {
      emit(state.copyWith(verifySigninStatus: Status.error, msg: AppConst.normalizeError(e)));
    }
    emit(state.copyWith(verifySigninStatus: Status.initial));
  }

  void signout() async {
    emit(state.copyWith(signoutStatus: Status.loading));
    try {
      final message = await _repo.signout();
      emit(state.copyWith(signoutStatus: Status.success, msg: message, user: UserModel.initial));
    } catch (e) {
      emit(state.copyWith(signoutStatus: Status.error, msg: AppConst.normalizeError(e)));
    }
    emit(state.copyWith(signoutStatus: Status.initial));
  }

  void initiateSignup(UserModel user) async {
    emit(state.copyWith(initiateSignupStatus: Status.loading));
    try {
      await _repo.verifyUserData(user);
      await _repo.verifyPhone(phone: user.phone);
      emit(state.copyWith(initiateSignupStatus: Status.success, msg: 'OTP sent to your phone'));
    } catch (e) {
      emit(state.copyWith(initiateSignupStatus: Status.error, msg: AppConst.normalizeError(e)));
    }
    emit(state.copyWith(initiateSignupStatus: Status.initial));
  }

  void confirmOtp(String phone, String otp, bool willSignup) async {
    emit(state.copyWith(confirmOtpStatus: Status.loading));
    try {
      await _repo.confirmOtp(phone, otp, willSignup);
      emit(state.copyWith(confirmOtpStatus: Status.success));
    } catch (e) {
      emit(state.copyWith(confirmOtpStatus: Status.error, msg: AppConst.normalizeError(e)));
    }
    emit(state.copyWith(confirmOtpStatus: Status.initial));
  }

  void resetPassword(String email, String newPassword) async {
    emit(state.copyWith(resetPasswordStatus: Status.loading));
    try {
      final message = await _repo.resetPassword(email, newPassword);
      emit(state.copyWith(resetPasswordStatus: Status.success, msg: message));
    } catch (e) {
      emit(state.copyWith(resetPasswordStatus: Status.error, msg: AppConst.normalizeError(e)));
    }
    emit(state.copyWith(resetPasswordStatus: Status.initial));
  }

  Future<void> resendOtp(UserModel user, bool willSignup) async {
    emit(state.copyWith(resendOtpStatus: Status.loading));
    try {
      if (willSignup) {
        await _repo.verifyPhone(phone: user.phone);
      } else {
        await _repo.initiateSignin(phone: user.phone);
      }
      emit(state.copyWith(resendOtpStatus: Status.success, msg: 'OTP resent successfully'));
    } catch (e) {
      emit(state.copyWith(resendOtpStatus: Status.error, msg: AppConst.normalizeError(e)));
    }
    emit(state.copyWith(resendOtpStatus: Status.initial));
  }
}
