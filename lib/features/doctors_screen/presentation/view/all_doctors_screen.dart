
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../utils/resources/app_fonts.dart';
import '../../../../utils/resources/constants.dart';
import '../../../home_screen/presentation/controller/cubit/home_cubit.dart';
import '../../../home_screen/presentation/controller/cubit/home_states.dart';
import '../../../home_screen/presentation/view/widgets/dr_widget.dart';

class AllDoctorsScreen extends StatelessWidget {
  static const routeName = '/allDoctorsScreen';

  const AllDoctorsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeStates>(builder: (context, state) {
      var cubit = HomeCubit.get(context);
      return Scaffold(
        appBar: AppBar(
          title: Text("الأطباء"),
        ),
        body: state is GetAvailableDoctorsLoadingState || cubit.doctorModel == null
            ? const Center(
          child: Text(
            'قائمة الأطباء فارغة',
            style: AppFonts.headlineStyle,
          ),
        )
            : Padding(
          padding:  EdgeInsets.symmetric( horizontal: AppConstants.pagePadding),
          child: ListView.builder(
              itemCount: cubit.doctorModel!.data!.length,

              itemBuilder: (context, index) {
                return DrWidget(data: cubit.doctorModel!.data![index],);
              }),
        ),
      );
    });
  }
}
