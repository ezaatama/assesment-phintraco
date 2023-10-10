part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileLoading extends ProfileState {}

final class ProfileLoaded extends ProfileState {
  final UserResponse user;

  ProfileLoaded(this.user);
}

final class ProfileError extends ProfileState {
  final String errProfile;

  ProfileError(this.errProfile);
}

final class ProfileEmpty extends ProfileState {}
