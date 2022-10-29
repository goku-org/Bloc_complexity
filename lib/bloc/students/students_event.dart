part of 'students_bloc.dart';
// ignore_for_file: unused_element

abstract class StudentsEvent extends Equatable {
  const StudentsEvent();

  @override
  List<Object> get props => [];
}

class StudentsFetched extends StudentsEvent {
  const StudentsFetched();
}
