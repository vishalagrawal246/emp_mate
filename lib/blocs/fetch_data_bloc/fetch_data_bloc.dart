import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../repositories/fetch_data.dart';

part 'fetch_data_event.dart';
part 'fetch_data_state.dart';

class FetchDataBloc extends Bloc<FetchDataEvent, FetchDataState> {
  FetchDataBloc() : super(FetchDataInitial()) {
    on<FetchSavedEvent>((event, emit) async {
      emit(FetchDataLoading());
      try {
        await FetchData.fetchSavedData()
            .then((value) => emit(FetchDataSuccess(value)));
      } catch (e) {
        emit(const FetchDataFailed('Something went wrong!'));
      }
    });
  }
}
