import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hisksa/features/home_layout/presentation/controller/home_layout_state.dart';
import 'package:hisksa/features/home_screen/presentation/view/widgets/Home_clinic_list_widget.dart';
import 'package:hisksa/features/home_screen/presentation/view/widgets/dr_widget.dart';
import 'package:hisksa/features/notifications_screen/presentation/view/notifications_screen.dart';
import 'package:hisksa/features/search_screen/presentation/view/search_screen.dart';
import 'package:hisksa/utils/resources/app_colors.dart';
import 'package:hisksa/utils/resources/app_fonts.dart';
import 'package:hisksa/utils/resources/constants.dart';
import 'package:hisksa/widgets/headline_row.dart';
import 'package:hisksa/widgets/logo_progress.dart';

import '../../../../utils/resources/app_assets.dart';
import '../../../doctors_screen/presentation/view/all_doctors_screen.dart';
import '../../../doctors_screen/presentation/view/doctors_screen.dart';
import '../../../home_layout/presentation/controller/home_layout_cubit.dart';
import '../controller/cubit/home_cubit.dart';
import '../controller/cubit/home_states.dart';
import 'widgets/home_banners_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset(
          AppAssets.mainLogo,
          height: 30,
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  NotificationScreen.routeName,
                );
              },
              icon: const Icon(IconlyBroken.notification))
        ],
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(
              context,
              SearchScreen.routeName,
            );
          },
          icon: const Icon(
            EvilIcons.search,
          ),
        ),
      ),
      body: BlocBuilder<HomeCubit, HomeStates>(
        builder: (context, state) {
          var cubit = HomeCubit.get(context);
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                const SizedBox(height: 10,),
                const HomeBannersWidget(),
                const Divider(),
                BlocBuilder<HomeLayoutCubit, HomeLayoutState>(
                  builder: (context, state) {
                    return HeadLineRow(title: 'العيادات', fct: (){
                      HomeLayoutCubit.get(context).changeNavBarIndex(1);
                    });
                  }
                ),
                const SizedBox(
                  height: 10,
                ),
                const HomeClinicListWidget(),
                const Divider(),
                 HeadLineRow(title: 'ابرز الأطباء',fct: (){
                   Navigator.pushNamed(context, AllDoctorsScreen.routeName);
                }),
                state is GetAvailableDoctorsLoadingState || cubit.doctorModel == null? const LogoProgress() :  Padding(
                  padding: const EdgeInsets.symmetric( horizontal: AppConstants.pagePadding),
                  child: ListView.builder(
                      itemCount: cubit.doctorModel!.data!.take(5).length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return DrWidget(data: cubit.doctorModel!.data![index],);
                      }),
                ),
              ],
            ),
          );
        }
      ),
    );
  }
}
