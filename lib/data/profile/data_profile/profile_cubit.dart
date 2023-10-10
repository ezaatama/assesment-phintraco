import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:phintraco_assesment/models/users.dart';
import 'package:phintraco_assesment/utils/db_helper.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  Future<UserResponse?> getDataProfile(int userId) async {
    try {
      final db = await DBHelper().database;
      final List<Map<String, dynamic>> users =
          await db!.query('users', where: 'id = ?', whereArgs: [userId]);
      if (users.isNotEmpty) {
        UserResponse user = UserResponse.fromJson(users.first);
        emit(ProfileLoaded(user));
      } else {
        emit(ProfileEmpty());
      }
    } catch (e) {
      emit(ProfileError("Gagal mendapatkan data profile!"));
    }
    return null;
  }
}
