import 'package:bloc/bloc.dart';
import 'package:phintraco_assesment/models/attendances.dart';
import 'package:phintraco_assesment/models/users.dart';
import 'package:phintraco_assesment/utils/db_helper.dart';

part 'attendances_state.dart';

class AttendancesCubit extends Cubit<AttendancesState> {
  AttendancesCubit()
      : super(AttendancesState(isCheckIn: false, attendance: null));

  void checkIn(UserResponse user, Attendance attendances) async {
    await DBHelper().updateUserAttendance(user, attendances);
    emit(AttendancesState(isCheckIn: true, attendance: attendances));
  }

  void checkOut(UserResponse user, Attendance attendances) async {
    await DBHelper().updateAttendanceCheckout(user, attendances);
    emit(AttendancesState(isCheckIn: false, attendance: attendances));
  }
}
