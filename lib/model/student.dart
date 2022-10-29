import 'dart:convert' show json;

import 'package:equatable/equatable.dart';

class Student extends Equatable {
  const Student({
    required this.name,
    required this.rollno,
    required this.totalsubjects,
    required this.isMinor,
  });

  final String name;
  final int rollno;
  final int totalsubjects;
  final bool isMinor;

  Student copyWith({
    String? name,
    int? rollno,
    int? totalsubjects,
    bool? isMinor,
  }) =>
      Student(
        name: name ?? this.name,
        rollno: rollno ?? this.rollno,
        totalsubjects: totalsubjects ?? this.totalsubjects,
        isMinor: isMinor ?? this.isMinor,
      );

  factory Student.fromJson(String str) => Student.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Student.fromMap(Map<String, dynamic> json) => Student(
        name: json["name"],
        rollno: json["rollno"],
        totalsubjects: json["totalsubjects"],
        isMinor: json["isMinor"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "rollno": rollno,
        "totalsubjects": totalsubjects,
        "isMinor": isMinor,
      };

  @override
  List<Object?> get props => [
        name,
        rollno,
        totalsubjects,
        isMinor,
      ];
}
