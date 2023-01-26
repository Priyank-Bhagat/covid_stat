
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/covid_model.dart';
import '../repositories/api_repository.dart';

part 'covid_event.dart';
part 'covid_state.dart';

class CovidBloc extends Bloc<CovidEvent, CovidState> {
  CovidBloc() : super(CovidInitial()) {
    final ApiRepository _apiRepository = ApiRepository();

    on<GetCovidList>((event, emit)async {
     try{
       emit(CovidLoading());
       final mList = await _apiRepository.fetchCovidList();
       emit(CovidLoaded(mList));
       if (mList.error != null) {
         emit(CovidError(mList.error));
       }
     }
     on NetworkError{
       emit(const CovidError("Failed to fetch data. is your device online?"));
     }
    });
  }
}