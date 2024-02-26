import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hisksa/features/doctors_screen/presentation/controller/cubit/doctors_cubit.dart';
import 'package:hisksa/features/home_screen/presentation/view/widgets/dr_widget.dart';
import 'package:hisksa/utils/resources/app_fonts.dart';
import 'package:hisksa/widgets/logo_progress.dart';

import '../controller/cubit/doctors_states.dart';

class DoctorsScreen extends StatelessWidget {
  static const routeName = '/DoctorsScreen';

  const DoctorsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final clinic = ModalRoute.of(context)!.settings.arguments as Map;
    return BlocProvider<DoctorsCubit>(
      create: (context) => DoctorsCubit()..getDoctors(context, clinic['id']),
      child:
          BlocBuilder<DoctorsCubit, DoctorsStates>(builder: (context, state) {
        var cubit = DoctorsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(clinic['name']),
          ),
          body: state is GetDoctorsLoadingState
              ? const LogoProgress()
              : cubit.doctorModel!.data!.isEmpty
                  ? const Center(
                      child: Text(
                        'قائمة الأطباء فارغة',
                        style: AppFonts.headlineStyle,
                      ),
                    )
                  : ListView.builder(
                      itemCount: cubit.doctorModel!.data!.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return DrWidget(
                          data: cubit.doctorModel!.data![index],
                        );
                      }),
        );
      }),
    );
  }
}
