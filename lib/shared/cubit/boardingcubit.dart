import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../states/boardingstates.dart';

class BoardingCubit extends Cubit<BoardingStates> {
  BoardingCubit() : super(BoardingInitialState());
  int currentpage = 0;

  changePage(PageController pc) {
    if (currentpage == 0) {
      currentpage = 1;
      pc.animateToPage(1, duration: Duration(seconds: 1), curve: Curves.easeIn);
      emit(BoardingPageViewChangeState());

    } else if (currentpage == 1) {

      currentpage = 0;
      pc.animateToPage(2, duration: Duration(seconds: 1), curve: Curves.easeIn);
      emit(BoardingPageViewChangeState());
    }
  }
}
