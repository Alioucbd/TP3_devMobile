import 'package:equatable/equatable.dart';

import 'bloc.dart';

abstract class NextState extends Equatable {
  const NextState();

  @override
  // TODO: implement props
  List<int> get props => [];
}

class NextStateInit extends NextState {
  int index = 0;
  NextStateInit(this.index);

  @override
  List<int> get props => [
    index,
  ];

}