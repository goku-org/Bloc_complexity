part of 'student_bloc.dart';

abstract class StudentState {
  const StudentState();
}

class StudentLoading extends StudentState {}

class StudentError extends StudentState {
  final String msg;
  const StudentError(this.msg);
}

class StudentComplete extends StudentState {
  final Student student;
  const StudentComplete(this.student);
}
