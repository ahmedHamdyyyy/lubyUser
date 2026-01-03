part of 'auth_cubit.dart';

class AuthState extends Equatable {
  final String msg;
  final Status signupStatus,
      initiateSigninStatus,
      verifySigninStatus,
      resendOtpStatus,
      signoutStatus,
      initiateSignupStatus,
      resetPasswordStatus,
      confirmOtpStatus;
  final UserModel user;

  const AuthState({
    this.msg = '',
    this.signupStatus = Status.initial,
    this.initiateSigninStatus = Status.initial,
    this.verifySigninStatus = Status.initial,
    this.resendOtpStatus = Status.initial,
    this.signoutStatus = Status.initial,
    this.initiateSignupStatus = Status.initial,
    this.resetPasswordStatus = Status.initial,
    this.confirmOtpStatus = Status.initial,
    this.user = UserModel.initial,
  });
  AuthState copyWith({
    String? msg,
    Status? signupStatus,
    Status? initiateSigninStatus,
    Status? verifySigninStatus,
    Status? resendOtpStatus,
    Status? signoutStatus,
    Status? initiateSignupStatus,
    UserModel? user,
    Status? resetPasswordStatus,
    Status? confirmOtpStatus,
  }) => AuthState(
    msg: msg ?? this.msg,
    signupStatus: signupStatus ?? this.signupStatus,
    initiateSigninStatus: initiateSigninStatus ?? this.initiateSigninStatus,
    verifySigninStatus: verifySigninStatus ?? this.verifySigninStatus,
    resendOtpStatus: resendOtpStatus ?? this.resendOtpStatus,
    signoutStatus: signoutStatus ?? this.signoutStatus,
    initiateSignupStatus: initiateSignupStatus ?? this.initiateSignupStatus,
    resetPasswordStatus: resetPasswordStatus ?? this.resetPasswordStatus,
    confirmOtpStatus: confirmOtpStatus ?? this.confirmOtpStatus,
    user: user ?? this.user,
  );

  @override
  List<Object?> get props => [
    msg,
    signupStatus,
    initiateSigninStatus,
    verifySigninStatus,
    resendOtpStatus,
    signoutStatus,
    initiateSignupStatus,
    user,
    confirmOtpStatus,
    resetPasswordStatus,
  ];
}
