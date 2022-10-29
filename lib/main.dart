import 'package:bloc_complexity/bloc/student/student_bloc.dart';
import 'package:bloc_complexity/bloc/students/students_bloc.dart';
import 'package:bloc_complexity/repo/data_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  final StudentDataRepo studentDataRepo = StudentDataRepo();
  runApp(MyApp(dataRepo: studentDataRepo));
}

class MyApp extends StatelessWidget {
  final StudentDataRepo dataRepo;
  const MyApp({super.key, required this.dataRepo});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<StudentsBloc>(
      create: (context) => StudentsBloc(dataRepo)..add(const StudentsFetched()),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: 'Bloc Demo'),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    StudentsState studentsState =
        context.select((StudentsBloc bloc) => bloc.state);
    return Scaffold(
      body: studentsState is StudentsComplete
          ? ListView.builder(
              shrinkWrap: true,
              itemCount: studentsState.students.length,
              itemBuilder: (context, index) {
                return CreateStudentTile(index, studentsState.students[index]);
              })
          : const Center(child: CircularProgressIndicator()),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          (studentsState as StudentsComplete)
              .students
              .sublist(0, 5)
              .forEach((e) => print((e as StudentComplete).student));
        },
        child: const Icon(Icons.print),
      ),
    );
  }
}

class CreateStudentTile extends StatelessWidget {
  final int index;
  final StudentState state;
  const CreateStudentTile(
    this.index,
    this.state, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    print('INNER---Build Student---');
    return BlocProvider(
      create: (context) => StudentBloc(StudentDataRepo())
        ..add(StudentAdd(state as StudentComplete)),
      child: Builder(builder: (context) {
        var studentstate = (context.select((StudentBloc bloc) => bloc.state));
        return studentstate is StudentComplete
            ? ListTile(
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Minor: '),
                    Switch(
                        value: studentstate.student.isMinor,
                        onChanged: (bool value) => context
                            .read<StudentBloc>()
                            .add(EditByIndex.isMinor(index, value)))
                  ],
                ),
                title: Text(studentstate.student.name),
                subtitle: Text(
                    'Rollno. ${studentstate.student.rollno}  |  Minor:${studentstate.student.isMinor}  |  Subjects ${studentstate.student.totalsubjects}'),
              )
            : const ListTile(
                title: LinearProgressIndicator(),
                subtitle: Text('Loading..'),
              );
      }),
    );
  }
}
