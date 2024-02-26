import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hisksa/features/history_details_screen/presentation/controller/cubit/history_details_cubit.dart';
import 'package:hisksa/features/history_details_screen/presentation/controller/cubit/history_details_states.dart';
import 'package:hisksa/features/history_details_screen/presentation/view/widgets/radio_widget.dart';
import 'package:hisksa/widgets/logo_progress.dart';

import '../../../../utils/resources/app_colors.dart';
import '../../../radio_lab_screen/presentation/view/widgets/lab_widget.dart';
import 'widgets/lab_widget.dart';
import 'widgets/medication_widget.dart';
import 'widgets/others_widget.dart';
import 'widgets/risk_factors_widget.dart';
import 'widgets/visit_data_widget.dart';
import 'widgets/vit_widget.dart';

class HistoryDetailsScreen extends StatelessWidget {
  static const routeName = '/HistoryDetailsScreen';

  const HistoryDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final historyDetailsID =
        ModalRoute.of(context)!.settings.arguments as String;
    return BlocProvider<HistoryDetailsCubit>(
      create: (context) =>
          HistoryDetailsCubit()..getHistoryDetails(context, historyDetailsID),
      child: BlocBuilder<HistoryDetailsCubit, HistoryDetailsStates>(
          builder: (context, state) {
        var cubit = HistoryDetailsCubit.get(context);
        return Scaffold(
            appBar: AppBar(
              title: const Text('تفاصيل الزيارة'),
            ),
            body: state is GetHistoryDetailsLoadingState
                ? const LogoProgress()
                : SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Accordion(
                          paddingListBottom: 0,
                          maxOpenSections: 1,
                          headerBackgroundColorOpened: Colors.black54,
                          scaleWhenAnimating: true,
                          openAndCloseAnimation: true,
                          disableScrolling: true,
                          scrollIntoViewOfItems: ScrollIntoViewOfItems.fast,
                          children: [
                            AccordionSection(
                              isOpen: true,
                              leftIcon: const Icon(Fontisto.stethoscope,
                                  color: Colors.white),
                              headerBackgroundColorOpened: AppColors.mainColor,
                              header: const Text(
                                'معلومات الزيارة',
                              ),
                              contentBackgroundColor:
                                  Theme.of(context).cardColor,
                              content: VisitDataWidget(
                                  data: cubit.historyDetailsModel!.data!),
                            ),
                            accWidget(
                              title: 'Vit',
                              isOpen: false,
                              content: VitWidget(
                                vitalsigns: cubit
                                    .historyDetailsModel!.data!.vITALSIGNS!,
                              ),
                              context: context,
                              icon: FontAwesome.medkit,
                            ),
                            accWidget(
                              title: 'Risk Factors',
                              isOpen: false,
                              content: RiskFactorsWidget(
                                  riskfactors: cubit
                                      .historyDetailsModel!.data!.rISKFACTORS!),
                              context: context,
                              icon: IconlyBroken.danger,
                            ),
                            accWidget(
                              title: 'Medication',
                              isOpen: false,
                              content: MedicationWidget(
                                data: cubit.historyDetailsModel!.data!,
                              ),
                              context: context,
                              icon: Fontisto.pills,
                            ),
                            accWidget(
                              title: 'Laboratory',
                              isOpen: false,
                              content: HistoryLabWidget(
                                data: cubit.historyDetailsModel!.data!,
                              ),
                              context: context,
                              icon: Fontisto.injection_syringe,
                            ),
                            accWidget(
                              title: 'Radio',
                              isOpen: false,
                              content: HistoryRadioWidget( data: cubit.historyDetailsModel!.data!,),
                              context: context,
                              icon: MaterialCommunityIcons.radiology_box,
                            ),
                            accWidget(
                              title: 'Others',
                              isOpen: false,
                              content:OthersWidget(data: cubit.historyDetailsModel!.data!,),
                              context: context,
                              icon: IconlyBroken.category,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ));
      }),
    );
  }
}

AccordionSection accWidget({
  required String title,
  required bool isOpen,
  required Widget content,
  required IconData icon,
  required BuildContext context,
}) {
  return AccordionSection(
    header: Text(title),
    isOpen: isOpen,
    leftIcon: Icon(icon, color: Colors.white),
    headerBackgroundColorOpened: AppColors.mainColor,
    contentBackgroundColor: Theme.of(context).cardColor,
    content: content,
  );
}
