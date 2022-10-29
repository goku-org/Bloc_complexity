part of 'students_bloc.dart';

abstract class StudentsState {
  const StudentsState();
}

class StudentsLoading extends StudentsState {}

class StudentsError extends StudentsState {
  final String msg;

  const StudentsError(this.msg);
}

class StudentsComplete extends StudentsState {
  final List<StudentState> students;

  const StudentsComplete(this.students);
}
