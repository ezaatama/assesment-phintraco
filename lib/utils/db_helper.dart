import 'package:phintraco_assesment/models/attendances.dart';
import 'package:phintraco_assesment/models/users.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();

  factory DBHelper() => _instance;

  DBHelper._internal();

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await initDatabase();
    return _database;
  }

  Future<Database?> initDatabase() async {
    final path = await getDatabasesPath();
    final databasePath = join(path, 'assesment_phintraco');
    return await openDatabase(databasePath, version: 1, onCreate: _createDb);
  }

  void _createDb(Database db, int version) async {
    //create table users
    await db.execute('''
          CREATE TABLE IF NOT EXISTS users (
            Id INTEGER PRIMARY KEY AUTOINCREMENT,
            Name TEXT NOT NULL,
            Email TEXT NOT NULL UNIQUE,
            Password TEXT NOT NULL,
            Gender TEXT NOT NULL CHECK(Gender IN ("PRIA", "WANITA")),
            Religion TEXT NOT NULL CHECK(Religion IN ("Islam", "Kristen Protestan", "Kristen Katholik", "Hindu", "Buddha")),
            No_Handphone TEXT NOT NULL,
            Tanggal_Lahir DATE NOT NULL,
            Created_At DATETIME,
            Updated_At DATETIME,
            Deleted_At DATETIME
          )
        ''');
    //create table attendance
    await db.execute('''
          CREATE TABLE IF NOT EXISTS attendances (
            Id INTEGER PRIMARY KEY AUTOINCREMENT,
            User_Id INTEGER NOT NULL,
            Date DATE NOT NULL,
            Date_In DATE NOT NULL,
            Check_In DATETIME NOT NULL,
            Date_Out DATE,
            Check_Out DATETIME,
            Created_At DATETIME,
            Updated_At DATETIME,
            Deleted_At DATETIME,
            FOREIGN KEY(User_Id) REFERENCES users(Id)
          )
        ''');
  }

  Future<void> createUser(UserResponse user) async {
    final db = await database;
    await db!.insert('users', user.toJson());
  }

  Future<void> updateUserAttendance(
      UserResponse user, Attendance attendances) async {
    final db = await database;

    if (attendances.id == null) {
      await db!.insert('attendances', attendances.toJson());
    } else {
      await db!.update('attendances', attendances.toJson(),
          where: 'id = ?', whereArgs: [attendances.id]);
    }
    await db.insert('attendances', attendances.toJson());

    await db.update('users', {'updated_at': DateTime.now().toIso8601String()},
        where: 'id = ?', whereArgs: [user.id]);
  }

  Future<void> updateAttendanceCheckout(
      UserResponse user, Attendance attendance) async {
    final db = await database;

    if (attendance.id != null) {
      await db!.update('attendances', attendance.toJson(),
          where: 'id = ?', whereArgs: [attendance.id]);
    }
    await db!.update('users', {'updated_at': DateTime.now().toIso8601String()},
        where: 'id = ?', whereArgs: [user.id]);
  }
}
