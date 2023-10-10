import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:phintraco_assesment/models/users.dart';
import 'package:phintraco_assesment/utils/db_helper.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  bool isRegist = false;

  final DBHelper database = DBHelper();

  Future<void> createUser(UserResponse user) async {
    isRegist = true;
    try {
      await database.createUser(user);
      emit(RegisterSuccess("Registrasi Berhasil"));
    } catch (e) {
      emit(RegisterError("Registrasi Gagal"));
    }
    isRegist = false;
  }
}
