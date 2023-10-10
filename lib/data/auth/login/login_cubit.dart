import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:phintraco_assesment/models/users.dart';
import 'package:phintraco_assesment/utils/db_helper.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  bool isLogin = false;
  UserResponse? user;

  Future<void> loginUser(String email, String password) async {
    try {
      final db = await DBHelper().database;
      final users = await db!.query('users',
          where: 'Email = ? AND Password = ?', whereArgs: [email, password]);
      if (users.isNotEmpty) {
        user = UserResponse.fromJson(users.first);
        isLogin = true;
        emit(LoginSuccess("Login Berhasil"));
      } else {
        emit(LoginErrorUser("User tidak ditemukan!"));
      }
    } catch (e) {
      emit(LoginError("Login Gagal"));
    }
  }

  void logout() {
    emit(LogoutSuccess("Berhasil logout"));
  }
}
