part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {
  final String loginSuccess;

  LoginSuccess(this.loginSuccess);
}

final class LoginError extends LoginState {
  final String loginErr;

  LoginError(this.loginErr);
}

final class LoginErrorUser extends LoginState {
  final String loginErrUser;

  LoginErrorUser(this.loginErrUser);
}

final class LogoutSuccess extends LoginState {
  final String logoutSuccess;

  LogoutSuccess(this.logoutSuccess);
}
