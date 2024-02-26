import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hisksa/features/radio_lab_screen/presentation/controller/cubit/radio_lab_cubit.dart';
import 'package:hisksa/features/radio_lab_screen/presentation/controller/cubit/radio_lab_states.dart';
import 'package:hisksa/utils/resources/constants.dart';
import 'package:hisksa/widgets/logo_progress.dart';

import 'widgets/lab_widget.dart';

class LabScreen extends StatelessWidget {
  const LabScreen({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RadioLabCubit>(
      create: (context) => RadioLabCubit()..getLab(context),
      child: BlocBuilder<RadioLabCubit, RadioLabStates>(
        builder: (context, state) {
          var cubit = RadioLabCubit.get(context);
          return state is GetLabLoadingState? const LogoProgress() : Padding(
            padding: const EdgeInsets.all(AppConstants.pagePadding,),
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
                itemCount: cubit.labModel!.data!.length,
                itemBuilder: (context, index){
              return LabWidget(data: cubit.labModel!.data![index],);
            }),
          );
        }
      ),
    );
  }
}
