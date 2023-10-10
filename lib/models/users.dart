class UserResponse {
  final int? id;
  final String name;
  final String email;
  final String password;
  final String gender;
  final String religion;
  final String noHandphone;
  final String tanggalLahir;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;

  UserResponse({
    this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.gender,
    required this.religion,
    required this.noHandphone,
    required this.tanggalLahir,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      id: json['Id'],
      name: json['Name'],
      email: json['Email'],
      password: json['Password'],
      gender: json['Gender'],
      religion: json['Religion'],
      noHandphone: json['No_Handphone'],
      tanggalLahir: json['Tanggal_Lahir'],
      createdAt: DateTime.tryParse(json['Created_At'] ?? ''),
      updatedAt: DateTime.tryParse(json['Updated_At'] ?? ''),
      deletedAt: DateTime.tryParse(json['Deleted_At'] ?? ''),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'Name': name,
      'Email': email,
      'Password': password,
      'Gender': gender,
      'Religion': religion,
      'No_Handphone': noHandphone,
      'Tanggal_Lahir': tanggalLahir,
      'Created_At': createdAt?.toIso8601String(),
      'Updated_At': updatedAt?.toIso8601String(),
      'Deleted_At': deletedAt?.toIso8601String(),
    };
  }

  static String religionOption = '';

  static final List<String> agama = [
    'Islam',
    'Kristen',
    'Katholik',
    'Buddha',
    'Hindu',
    'Protestan'
  ];
}

class UserAttendance {
  final int? id;
  final String? name;

  UserAttendance({
    this.id,
    this.name,
  });

  factory UserAttendance.fromJson(Map<String, dynamic> json) {
    return UserAttendance(
      id: json['Id'],
      name: json['Name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'Name': name,
    };
  }
}
