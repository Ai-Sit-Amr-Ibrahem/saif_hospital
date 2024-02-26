import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../widgets/logo_progress.dart';
import '../controller/cubit/radio_lab_cubit.dart';
import '../controller/cubit/radio_lab_states.dart';
import 'widgets/radio_widget.dart';

class RadioScreen extends StatelessWidget {
  const RadioScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RadioLabCubit>(
      create: (context) => RadioLabCubit()..getRadio(context),
      child:
          BlocBuilder<RadioLabCubit, RadioLabStates>(
              builder: (context, state) {
        var cubit = RadioLabCubit.get(context);
        return state is GetRadioLoadingState
            ? LogoProgress()
            : ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: cubit.radioModel!.data!.length,
                itemBuilder: (context, index) {
                  return RadioWidget(
                    data: cubit.radioModel!.data![index],
                  );
                });
      }),
    );
  }
}
