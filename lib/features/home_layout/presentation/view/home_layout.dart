import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hisksa/features/home_layout/presentation/controller/home_layout_cubit.dart';
import 'package:hisksa/features/home_layout/presentation/controller/home_layout_state.dart';
import 'package:hisksa/utils/helper/hive_helper.dart';

import '../../../home_screen/presentation/view/home_screen.dart';

class HomeLayout extends StatelessWidget {
  static const routeName = '/HomeLayout';

   HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeLayoutCubit, HomeLayoutState>(
      builder: (context, state) {
        var cubit = HomeLayoutCubit.get(context);
        return Scaffold(
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: cubit.currentIndex,
            onTap: (index){
              cubit.changeNavBarIndex(index);
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(IconlyBroken.home),
                label: 'الرئيسية',
              ),
              BottomNavigationBarItem(
                icon: Icon(IconlyBroken.category),
                label: 'العيادات',
              ),
              BottomNavigationBarItem(
                icon: Icon(Entypo.lab_flask),
                label: 'نتائج الفحوصات',
              ),
              BottomNavigationBarItem(
                icon: Icon(IconlyBroken.profile),
                label: 'الصفحة الشخصية',
              ),
            ],
          ),
        );
      }
    );
  }
}
