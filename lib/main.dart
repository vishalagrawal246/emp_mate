import 'package:employee_mate/blocs/add_emp_bloc/add_emp_bloc.dart';
import 'package:employee_mate/blocs/fetch_data_bloc/fetch_data_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'views/emp_list.dart';

Future<void> main() async {
  runApp(const MyApp());
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  final path = appDocumentDirectory.path;
  final collection = await BoxCollection.open(
    'ListOfEmp', // Name of your database
    {'currentEmp', 'previousEmp'},
    path: path, // Names of your boxes
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AddEmpBloc>(create: (context) => AddEmpBloc()),
        BlocProvider<FetchDataBloc>(create: (context) => FetchDataBloc()),
      ],
      child: MaterialApp(
        title: 'Employee Mate',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const EmpListPage(title: 'Employee List'),
      ),
    );
  }
}
