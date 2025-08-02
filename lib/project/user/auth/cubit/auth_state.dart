part of 'auth_cubit.dart';

class AuthState extends Equatable {
  final String msg;
  final Status signupStatus;
  final Status signinStatus;
  final Status signoutStatus;
  final UserModel user;

  const AuthState({
    this.msg = '',
    this.signupStatus = Status.initial,
    this.signinStatus = Status.initial,
    this.signoutStatus = Status.initial,
    this.user = UserModel.non,
  });
  AuthState copyWith({String? msg, Status? signupStatus, Status? signinStatus, Status? signoutStatus, UserModel? user}) => AuthState(
    msg: msg ?? this.msg,
    signupStatus: signupStatus ?? this.signupStatus,
    signinStatus: signinStatus ?? this.signinStatus,
    signoutStatus: signoutStatus ?? this.signoutStatus,
    user: user ?? this.user,
  );

  @override
  List<Object?> get props => [msg, signupStatus, signinStatus, signoutStatus, user];
}
