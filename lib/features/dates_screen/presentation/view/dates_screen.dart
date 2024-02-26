import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hisksa/features/dates_screen/presentation/controller/cubit/dates_cubit.dart';
import 'package:hisksa/features/dates_screen/presentation/controller/cubit/dates_states.dart';
import 'package:hisksa/features/doctors_screen/data/model/doctor_Model.dart';
import 'package:hisksa/utils/resources/app_fonts.dart';
import 'package:hisksa/widgets/logo_progress.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../../utils/resources/app_colors.dart';
import '../../../../utils/resources/constants.dart';
import '../../../../widgets/item_line.dart';
import '../../../times_screen/presentation/view/times_screen.dart';

class DatesScreen extends StatelessWidget {
  static const routeName = '/DatesScreen';

  const DatesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute
        .of(context)!
        .settings
        .arguments as DoctorData;
    return Scaffold(
      appBar: AppBar(
        title: Text(data.dOCTORNAME ?? ''),
      ),
      body: Column(
        children: [
          Accordion(
            paddingListBottom: 0,
            maxOpenSections: 2,
            headerBackgroundColorOpened: Colors.black54,
            scaleWhenAnimating: true,
            openAndCloseAnimation: true,
            children: [
              AccordionSection(
                isOpen: true,
                leftIcon: const Icon(Fontisto.stethoscope, color: Colors.white),
                headerBackgroundColorOpened: AppColors.mainColor,
                header: const Text(
                  'معلومات الطبيب',
                ),
                content: Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      20,
                    ),
                  ),
                  elevation: 8,
                  shadowColor: AppColors.mainColor,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                             CircleAvatar(
                              radius: 45,
                              backgroundImage: NetworkImage(
                                data.dOCTORIMAGE != 'NULL' ? data.dOCTORNAME! :'https://img.freepik.com/free-photo/medical-banner-with-doctor-wearing-goggles_23-2149611193.jpg?w=900&t=st=1680166194~exp=1680166794~hmac=fdc7357426a297dce81d20b4bf2e0a2a47ceaf4d70b3fd70ddabc5b7175fd779',
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  ItemLine(
                                    icon: Fontisto.stethoscope,
                                    text: data.dOCTORNAME ?? '',
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .labelLarge!
                                        .copyWith(color: AppColors.mainColor),
                                  ),
                                  ItemLine(
                                    icon: IconlyBroken.category,
                                    text: data.dOCTORDEGRE ?? '',
                                  ),
                                  data.price == 0 ? const SizedBox() : ItemLine(
                                      icon: IconlyBroken.ticket,
                                      text:
                                      '${formatter.format(data.price)} SAR')
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const Divider(),
          const Text(
            'المواعيد المتاحة',
            style: AppFonts.headlineStyle,
          ),
          Expanded(
            child: BlocProvider<DatesCubit>(
              create: (context) =>
              DatesCubit()
                ..getDates(
                  context,
                  data.cLIINICID!,
                  data.dOCTORID!,
                ),
              child: BlocBuilder<DatesCubit, DatesStates>(
                  builder: (context, state) {
                    var cubit = DatesCubit.get(context);
                    return state is GetDatesLoadingState
                        ? const LogoProgress()
                        : cubit.datesModel!.data!.isEmpty ? const Center(
                      child: Text('ليست هناك مواعيد متاحة', style: AppFonts.headlineStyle,),) : ListView.builder(
                        padding: const EdgeInsets.all(0),
                        itemCount: cubit.datesModel!.data!.length,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                TimesScreen.routeName,
                                arguments: {
                                  'date' : cubit.datesModel!.data![index],
                                  'doctor_data' :  data,
                                },
                              );
                            },
                            child: ListTile(
                              leading: const Icon(IconlyBroken.calendar),
                              title: Text(cubit.datesModel!.data![index]
                                  .dATESCHADUALE ?? ''),
                              subtitle: Text(cubit.datesModel!.data![index]
                                  .dETAILS ?? ''),
                            ),
                          );
                        });
                  }
              ),
            ),
          ),
        ],
      ),
    );
  }
}
