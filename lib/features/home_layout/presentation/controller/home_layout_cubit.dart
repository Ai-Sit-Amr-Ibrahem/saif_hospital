import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hisksa/features/clinics_screen/presentation/view/clinics_screen.dart';
import 'package:hisksa/features/home_screen/presentation/view/home_screen.dart';
import '../../../profile_screen/presentation/view/profile_screen.dart';
import '../../../radio_lab_screen/presentation/view/radio_lab_screen.dart';
import 'home_layout_state.dart';

class HomeLayoutCubit extends Cubit<HomeLayoutState> {
  HomeLayoutCubit() : super(HomeLayoutInitial());

  static HomeLayoutCubit get(context) => BlocProvider.of(context);

  List<Widget> screens = [
    const HomeScreen(),
    ClinicsScreen(),
    const RadioAndLabScreen(),
    const ProfileScreen(),
  ];
  int currentIndex = 0;
  void changeNavBarIndex(int index){
    currentIndex = index;
    emit(ChangeNavBarState());
  }
}
