import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hisksa/features/checkout_screen/presentation/controller/cubit/checkout_cubit.dart';
import 'package:hisksa/utils/resources/app_fonts.dart';
import 'package:hisksa/utils/resources/constants.dart';
import '../../../../utils/helper/hive_helper.dart';
import '../../../../utils/resources/app_colors.dart';
import '../../../../widgets/buttons.dart';
import '../../../auth/presentation/features/login_screen/presentation/view/login_screen.dart';
import '../controller/cubit/checkout_states.dart';
import 'widgets/appointment_details.dart';
import 'widgets/balance_widget.dart';
import 'widgets/cash_widget.dart';
import 'widgets/visa_widget.dart';

class CheckoutScreen extends StatelessWidget {
  static const routeName = '/CheckoutScreen';

  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute
        .of(context)!
        .settings
        .arguments as Map;
    return BlocProvider<CheckoutCubit>(
      create: (BuildContext context) => CheckoutCubit(),
      child: BlocBuilder<CheckoutCubit, CheckoutStates>(
        builder: (context, state) {
          var cubit = CheckoutCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text('اتمام حجز موعد زيارة'),
            ),
            body: HiveHelper.getToken() == ''
                ? Center(
              child: Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    AppConstants.pagePadding,
                  ),
                ),
                elevation: 4,
                shadowColor: AppColors.mainColor,
                child: Padding(
                  padding: const EdgeInsets.all(AppConstants.pagePadding),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'الرجاء تسجيل الدخول اولا',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      StadiumButton(
                        buttonWidth: double.infinity,
                        title: 'تسجيل الدخول',
                        fct: () {
                          Navigator.pushNamed(context, LoginScreen.routeName,);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            )
                :   Padding(
              padding: const EdgeInsets.all(
                AppConstants.pagePadding,
              ),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    const Text(
                      'تنويه هام',
                      style: AppFonts.headlineStyle,
                    ),
                    const Text(
                        'يتم الحضور قبل الميعاد بنصف ساعة في حالة الدفع المسبق ( بالرصيد او الكتروني), اما في حالة الدفع الكاش يتم الحضور قبل الموعد بساعة تجنباً لإلغاء الموعد. \n شكراً لكم.'),
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
                          leftIcon:
                              const Icon(Fontisto.stethoscope, color: Colors.white),
                          headerBackgroundColorOpened: AppColors.mainColor,
                          header: const Text(
                            'معلومات الحجز',
                          ),
                          contentBackgroundColor: Theme.of(context).cardColor,
                          content: AppointmentDetails(
                            doctorData: data['doctor_data'],
                            date: data['date'],
                            time: data['time'],
                          ),
                        ),
                        // AccordionSection(
                        //   header: const Text('من الرصيد'),
                        //   isOpen: false,
                        //   leftIcon: const Icon(IconlyLight.wallet, color: Colors.white),
                        //   headerBackgroundColorOpened: AppColors.mainColor,
                        //   contentBackgroundColor: Theme.of(context).cardColor,
                        //   content: const BalanceWidget(),
                        // ),
                        // AccordionSection(
                        //   header: const Text('دفع الكتروني'),
                        //   isOpen: false,
                        //   leftIcon: const Icon(Fontisto.credit_card, color: Colors.white),
                        //   contentBackgroundColor: Theme.of(context).cardColor,
                        //   headerBackgroundColorOpened: AppColors.mainColor,
                        //   content: VisaWidget(),
                        // ),
                        AccordionSection(
                          header: const Text('دفع نقدي عند الوصول'),
                          isOpen: false,
                          leftIcon: const Icon(Ionicons.cash_outline, color: Colors.white),
                          contentBackgroundColor: Theme.of(context).cardColor,
                          headerBackgroundColorOpened: AppColors.mainColor,
                          content: CashWidget(time: data['time'], cubit: cubit,),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}
