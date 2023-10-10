import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:phintraco_assesment/models/attendances.dart';
import 'package:phintraco_assesment/utils/db_helper.dart';

part 'data_attendances_state.dart';

class DataAttendancesCubit extends Cubit<DataAttendancesState> {
  DataAttendancesCubit() : super(DataAttendancesInitial());

  void fetchDataCheckInOut(int user) async {
    final db = await DBHelper().database;
    final List<Map<String, dynamic>> result = await db!.query('attendances');
    print(result);

    // result.map((map) => Attendance.fromJson(map)).toList();
    emit(DataAttendancesLoaded(checkInData: result));
  }
}
