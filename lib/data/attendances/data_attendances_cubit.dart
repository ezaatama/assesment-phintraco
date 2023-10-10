import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:phintraco_assesment/models/attendances.dart';
import 'package:phintraco_assesment/utils/db_helper.dart';

part 'data_attendances_state.dart';

class DataAttendancesCubit extends Cubit<DataAttendancesState> {
  DataAttendancesCubit() : super(DataAttendancesInitial());

  Future<Attendance?> fetchDataCheckInOut(int userId) async {
    final db = await DBHelper().database;
    final List<Map<String, dynamic>> result =
        await db!.query('attendances', where: 'id = ?', whereArgs: [userId]);

    // result.map((map) => Attendance.fromJson(map)).toList();
    // print(result);
    if (result.isNotEmpty) {
      Attendance att = Attendance.fromJson(result.first);
      emit(DataAttendancesLoaded(checkInData: att));
    } else {
      emit(DataAttendancesEmpty());
    }

    return null;
  }
}
