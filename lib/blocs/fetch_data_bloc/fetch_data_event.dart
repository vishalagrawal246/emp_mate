part of 'fetch_data_bloc.dart';

abstract class FetchDataEvent extends Equatable {
  const FetchDataEvent();

  @override
  List<Object> get props => [];
}

class FetchSavedEvent extends FetchDataEvent {}
