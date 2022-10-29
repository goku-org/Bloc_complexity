import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bloc_complexity/bloc/student/student_bloc.dart';
import 'package:bloc_complexity/repo/data_repo.dart';
import 'package:equatable/equatable.dart';

part 'students_event.dart';
part 'students_state.dart';

class StudentsBloc extends Bloc<StudentsEvent, StudentsState> {
  final StudentDataRepo studentDataRepo;
  StudentsBloc(this.studentDataRepo) : super(StudentsLoading()) {
    on<StudentsFetched>(_onFetched);
  }

  FutureOr<void> _onFetched(event, Emitter<StudentsState> emit) async {
    var list = await studentDataRepo.fetchData();
    emit(StudentsComplete(list.map((e) => StudentComplete(e)).toList()));
  }
}
