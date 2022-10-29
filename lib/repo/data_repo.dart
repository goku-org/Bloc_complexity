import 'dart:math';

import 'package:bloc_complexity/model/student.dart';

Future wait() => Future.delayed(const Duration(milliseconds: 500));

class StudentDataRepo {
  final List<Student> _data = _jsonData.map((e) => Student.fromMap(e)).toList();
  Future<List<Student>> fetchData() async {
    await wait();
    return _data;
  }

  Future<void> changeMinorty(int index, bool value) async {
    await wait();
    _data[index] = _data[index].copyWith(isMinor: value);
  }

  Future<void> changeStudentName(int index, String name) async {
    await wait();
    _data[index] = _data[index].copyWith(name: name);
  }

  Future<void> changeTotalSubjects(int index, int value) async {
    await wait();
    _data[index] = _data[index].copyWith(totalsubjects: value);
  }
}

List<Map<String, dynamic>> _jsonData = List.generate(
    50,
    (e) => {
          "name": 'Student $e ',
          "rollno": Random().nextInt(100) + 50,
          "totalsubjects": Random().nextInt(10) + 5,
          "isMinor": Random().nextBool()
        }).toList();
