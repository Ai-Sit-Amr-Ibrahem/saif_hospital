import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:hisksa/features/times_screen/presentation/controller/cubit/time_cubit.dart';
import 'package:hisksa/features/times_screen/presentation/controller/cubit/time_states.dart';
import 'package:hisksa/widgets/logo_progress.dart';

import '../../../checkout_screen/presentation/view/checkout_screen.dart';
import '../../../dates_screen/data/model/dates_model.dart';

class TimesScreen extends StatelessWidget {
  static const routeName = '/TimesScreen';

  const TimesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
      appBar: AppBar(
        title: Text(data['date'].dATESCHADUALE ?? ''),
      ),
      body: BlocProvider<TimeCubit>(
        create: (context) =>
            TimeCubit()..getTime(context, data['date'].rESOURCESSCHEDULEID!),
        child: BlocBuilder<TimeCubit, TimeStates>(builder: (context, state) {
          var cubit = TimeCubit.get(context);
          return state is TimeLoadingState
              ? const LogoProgress()
              : ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: cubit.timeModel!.data!.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, CheckoutScreen.routeName,
                            arguments: {
                              'doctor_data': data['doctor_data'],
                              'date': data['date'],
                              'time': cubit.timeModel!.data![index],
                            });
                      },
                      child: ListTile(
                        leading: const Icon(IconlyBroken.timeCircle),
                        trailing: const Icon(IconlyBroken.arrowLeftCircle),
                        title: Text(
                            cubit.timeModel!.data![index].tIMEAVILABLE ?? ''),
                      ),
                    );
                  });
        }),
      ),
    );
  }
}
