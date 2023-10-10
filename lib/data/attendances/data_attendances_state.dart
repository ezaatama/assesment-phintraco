part of 'data_attendances_cubit.dart';

@immutable
sealed class DataAttendancesState {}

final class DataAttendancesInitial extends DataAttendancesState {}

final class DataAttendancesLoading extends DataAttendancesState {}

final class DataAttendancesLoaded extends DataAttendancesState {
  final List<Map<String, dynamic>> checkInData;

  DataAttendancesLoaded({required this.checkInData});
}

final class DataAttendancesError extends DataAttendancesState {}

final class DataAttendancesEmpty extends DataAttendancesState {}
