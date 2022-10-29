part of 'student_bloc.dart';

abstract class StudentEvent {
  const StudentEvent();
}

class StudentAdd extends StudentEvent {
  final StudentComplete state;

  StudentAdd(this.state);
}

class EditByIndex extends StudentEvent {
  final int index;
  final String? name;
  final int? totalSubjects;
  final bool? isMinor;
  const EditByIndex._(this.index,
      {this.name, this.totalSubjects, this.isMinor});

  const EditByIndex.name(int index, String name) : this._(index, name: name);

  const EditByIndex.totalSubjects(int index, int totalSubjects)
      : this._(index, totalSubjects: totalSubjects);

  const EditByIndex.isMinor(int index, bool isMinor)
      : this._(index, isMinor: isMinor);
}
