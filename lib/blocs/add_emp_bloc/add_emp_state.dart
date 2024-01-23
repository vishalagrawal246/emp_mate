part of 'add_emp_bloc.dart';

@immutable
abstract class AddEmpState extends Equatable {}

class AddEmpInitial extends AddEmpState {
  @override
  List<Object?> get props => [];
}

class AddEmpLoading extends AddEmpState {
  @override
  List<Object?> get props => [];
}

class AddEmpSuccess extends AddEmpState {
  @override
  List<Object?> get props => [];
}

class AddEmpFailed extends AddEmpState {
  final String error;
  AddEmpFailed(this.error);
  @override
  List<Object?> get props => [];
}
