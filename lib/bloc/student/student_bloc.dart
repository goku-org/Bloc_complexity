import 'dart:async';
import 'package:bloc/bloc.dart';
import '/repo/data_repo.dart';
import '/model/student.dart';
part 'student_event.dart';
part 'student_state.dart';

class StudentBloc extends Bloc<StudentEvent, StudentState> {
  final StudentDataRepo studentDataRepo;
  StudentBloc(this.studentDataRepo) : super(StudentLoading()) {
    on<EditByIndex>(_onEdit);
    on<StudentAdd>(
      (event, emit) {
        emit(event.state);
      },
    );
  }

  FutureOr<void> _onEdit(EditByIndex event, Emitter<StudentState> emit) async {
    if (state is StudentComplete) {
      StudentComplete oldstate = state as StudentComplete;
      // 1st - change the state of [index] item form list
      emit(StudentLoading());
      // 2st - wait for http request
      if (event.isMinor != null) {
        await studentDataRepo.changeMinorty(event.index, event.isMinor!);
      }
      if (event.name != null) {
        await studentDataRepo.changeStudentName(event.index, event.name!);
      }
      if (event.totalSubjects != null) {
        await studentDataRepo.changeTotalSubjects(
            event.index, event.totalSubjects!);
      }

      // 3st - change the state again.
      emit(StudentComplete(oldstate.student.copyWith(
          name: event.name,
          totalsubjects: event.totalSubjects,
          isMinor: event.isMinor)));
    }
  }
}
