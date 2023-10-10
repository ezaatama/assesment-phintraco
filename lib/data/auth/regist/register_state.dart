part of 'register_cubit.dart';

@immutable
sealed class RegisterState {}

final class RegisterInitial extends RegisterState {}

final class RegisterLoading extends RegisterState {}

final class RegisterSuccess extends RegisterState {
  final String regisSuccess;

  RegisterSuccess(this.regisSuccess);
}

final class RegisterError extends RegisterState {
  final String registErr;

  RegisterError(this.registErr);
}
