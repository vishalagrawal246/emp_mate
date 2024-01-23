part of 'fetch_data_bloc.dart';

abstract class FetchDataState extends Equatable {
  const FetchDataState();

  @override
  List<Object> get props => [];
}

class FetchDataInitial extends FetchDataState {}

class FetchDataLoading extends FetchDataState {}

class FetchDataSuccess extends FetchDataState {
  final EmpData empData;
  const FetchDataSuccess(this.empData);
  @override
  List<Object> get props => [empData];
}

class FetchDataFailed extends FetchDataState {
  final String error;
  const FetchDataFailed(this.error);
}
