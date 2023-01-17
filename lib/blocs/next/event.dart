import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'bloc.dart';

abstract class NextEvent extends Equatable {
  const NextEvent();

  @override
  // TODO: implement props
  List<int> get props => [];
}

class NextSubmitEvent extends NextEvent {
  int index =0;
  bool buttonFalse = false, buttonTrue =false;
  var reponse =  Map<int, bool>();

  NextSubmitEvent(index,this.buttonFalse,this.buttonTrue,this.reponse){
    if (buttonFalse){
      reponse [index] = false;
      buttonFalse = false;
    }
    if(buttonTrue){
      reponse [index] = true;
      buttonTrue = false;
    }

    this.index = index + 1;

    print("s");
    print(this.index);
  }

  @override
  List<int> get props => [
    index,
  ];


}