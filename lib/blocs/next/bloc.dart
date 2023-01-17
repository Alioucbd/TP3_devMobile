import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';


import 'event.dart';
import 'state.dart';

class NextBloc extends Bloc<NextEvent, NextState> {
  NextBloc() : super(NextStateInit(0)){
    on<NextSubmitEvent>((event, emit) {
      print("object");
      //print(event.props.first);
      emit(NextStateInit(event.props.first));
    });
  }

}
