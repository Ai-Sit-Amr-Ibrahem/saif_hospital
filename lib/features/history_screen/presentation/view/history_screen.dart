import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hisksa/features/history_details_screen/presentation/view/history_details_screen.dart';
import 'package:hisksa/features/history_screen/presentation/controller/cubit/history_states.dart';
import 'package:hisksa/features/history_screen/presentation/controller/cubit/histoy_cubit.dart';
import 'package:hisksa/utils/resources/app_colors.dart';
import 'package:hisksa/utils/resources/constants.dart';
import 'package:hisksa/widgets/logo_progress.dart';

class HistoryScreen extends StatelessWidget {
  static const routeName = '/HistoryScreen';

  const HistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HistoryCubit>(
      create: (context) => HistoryCubit()..getHistory(context),
      child:
          BlocBuilder<HistoryCubit, HistoryStates>(builder: (context, state) {
        var cubit = HistoryCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text('التاريخ المرضي'),
          ),
          body: state is GetHistoryLoadingState
              ? const LogoProgress()
              : ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: cubit.historyModel!.data!.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          HistoryDetailsScreen.routeName,
                          arguments:
                              cubit.historyModel!.data![index].rECEIPTHEADERID,
                        );
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(AppConstants.pagePadding),
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        shadowColor: AppColors.mainColor,
                        elevation: 3,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Text(cubit.historyModel!.data![index].sPECIALIEST ??
                                ''),
                            ListTile(
                              title: Text(
                                  cubit.historyModel!.data![index].dOCTORNAME ??
                                      ''),
                              subtitle: Text(
                                  cubit.historyModel!.data![index].dateVisit ??
                                      ''),
                              leading: const Icon(Fontisto.stethoscope),
                              trailing: Text(
                                  cubit.historyModel!.data![index].vISITTYPE ??
                                      ''),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
        );
      }),
    );
  }
}
