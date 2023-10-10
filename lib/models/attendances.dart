class Attendance {
  final int? id;
  final int userId;
  final DateTime? date;
  final DateTime? dateIn;
  final DateTime? checkIn;
  final DateTime? dateOut;
  final DateTime? checkOut;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;

  Attendance({
    this.id,
    required this.userId,
    this.date,
    this.dateIn,
    this.checkIn,
    this.dateOut,
    this.checkOut,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory Attendance.fromJson(Map<String, dynamic> json) {
    return Attendance(
      id: json['Id'],
      userId: json['User_Id'],
      date: DateTime.tryParse(json['Date'] ?? ''),
      dateIn: DateTime.tryParse(json['Date_In'] ?? ''),
      checkIn: DateTime.tryParse(json['Check_In'] ?? ''),
      dateOut: DateTime.tryParse(json['Date_Out'] ?? ''),
      checkOut: DateTime.tryParse(json['Check_Out'] ?? ''),
      createdAt: DateTime.tryParse(json['Created_At'] ?? ''),
      updatedAt: DateTime.tryParse(json['Updated_At'] ?? ''),
      deletedAt: DateTime.tryParse(json['Deleted_At'] ?? ''),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'User_Id': userId,
      'Date': date?.toIso8601String(),
      'Date_In': dateIn?.toIso8601String(),
      'Check_In': checkIn.toString(),
      'Date_Out': dateOut?.toIso8601String(),
      'Check_Out': checkOut?.toString(),
      'Created_At': createdAt?.toIso8601String(),
      'Updated_At': updatedAt?.toIso8601String(),
      'Deleted_At': deletedAt?.toIso8601String(),
    };
  }
}
