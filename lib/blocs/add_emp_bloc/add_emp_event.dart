part of 'add_emp_bloc.dart';

abstract class AddEmpEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddNewEmp extends AddEmpEvent {
  final Map<String, dynamic> empData;
  final String? keyy;
  AddNewEmp({required this.empData, this.keyy,});

  @override
  List<Object> get props => [empData];
}
