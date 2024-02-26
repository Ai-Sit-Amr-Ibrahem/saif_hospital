import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hisksa/features/clinics_screen/presentation/controller/cubit/clinics_cubit.dart';
import 'package:hisksa/features/doctors_screen/presentation/view/all_doctors_screen.dart';
import '../../config.dart';
import '../../features/auth/presentation/features/forget_password/presentation/view/check_id_screen.dart';
import '../../features/auth/presentation/features/forget_password/presentation/view/forget_password_screen.dart';
import '../../features/auth/presentation/features/login_screen/presentation/view/login_screen.dart';
import '../../features/auth/presentation/features/registration_screen/presentation/view/registration_screen.dart';
import '../../features/balance/presentation/view/balance_screen.dart';
import '../../features/center_details_screen/presentation/view/center_details_screen.dart';
import '../../features/checkout_screen/presentation/view/checkout_screen.dart';
import '../../features/dates_screen/presentation/view/dates_screen.dart';
import '../../features/doctors_screen/presentation/view/doctors_screen.dart';
import '../../features/history_details_screen/presentation/view/history_details_screen.dart';
import '../../features/history_screen/presentation/view/history_screen.dart';
import '../../features/home_layout/presentation/controller/home_layout_cubit.dart';
import '../../features/home_layout/presentation/view/home_layout.dart';
import '../../features/home_screen/presentation/controller/cubit/home_cubit.dart';
import '../../features/my_booking_screen/presentation/view/my_booking_details_screen.dart';
import '../../features/my_booking_screen/presentation/view/my_booking_screen.dart';
import '../../features/notifications_screen/presentation/view/notifications_screen.dart';
import '../../features/on_boarding_screen/presentation/view/on_boarding_screen.dart';
import '../../features/profile_screen/presentation/controller/theme_cubit/theme_cubit.dart';
import '../../features/profile_screen/presentation/controller/theme_cubit/theme_states.dart';
import '../../features/receipt_screen/presentation/view/receipt_screen.dart';
import '../../features/search_screen/presentation/view/search_screen.dart';
import '../../features/splash_screen/presentation/view/splash_screen.dart';
import '../../features/times_screen/presentation/view/times_screen.dart';
import '../helper/hive_helper.dart';
import '../resources/app_config.dart';
import '../resources/constants.dart';
import '../resources/theme_controller.dart';

var navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeCubit>(
          create: (BuildContext context) => ThemeCubit(),
        ),
        BlocProvider<HomeLayoutCubit>(
          create: (BuildContext context) => HomeLayoutCubit(),
        ),
        BlocProvider<ClinicsCubit>(
          create: (BuildContext context) => ClinicsCubit()..getClinics(navigatorKey.currentState!.context),
        ),
        BlocProvider<HomeCubit>(
          create: (BuildContext context) => HomeCubit()..getAvailableDoctors(navigatorKey.currentState!.context),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeStates>(
        builder: (context, state) {
          return MaterialApp(
            navigatorKey: navigatorKey,
            title: AppDesign.comName,
            localizationsDelegates: AppConfig.localizationsDelegates,
            supportedLocales: const [
              Locale('ar'),
            ],
            locale: const Locale('ar'),
            debugShowCheckedModeBanner: false,
            theme: Styles.themeData(isDark, context),
            home: HiveHelper.getToken() != '' ? const SplashScreen() : const OnBoardingScreen(),
            routes: {
              OnBoardingScreen.routeName: (ctx) => const OnBoardingScreen(),
              LoginScreen.routeName: (ctx) => LoginScreen(),
              AllDoctorsScreen.routeName: (ctx) => const AllDoctorsScreen(),

              SignUpScreen.routeName: (ctx) => const SignUpScreen(),
              CheckIDScreen.routeName: (ctx) => CheckIDScreen(),
              ForgetPasswordScreen.routeName: (ctx) => ForgetPasswordScreen(),
              HomeLayout.routeName: (ctx) => HomeLayout(),
              DatesScreen.routeName: (ctx) => const DatesScreen(),
              TimesScreen.routeName: (ctx) => const TimesScreen(),
              CheckoutScreen.routeName: (ctx) => const CheckoutScreen(),
              DoctorsScreen.routeName: (ctx) => const DoctorsScreen(),
              NotificationScreen.routeName: (ctx) => const NotificationScreen(),
              HistoryScreen.routeName: (ctx) => const HistoryScreen(),
              BalanceScreen.routeName: (ctx) => const BalanceScreen(),
              SearchScreen.routeName: (ctx) => SearchScreen(),
              CenterDetailsScreen.routeName: (ctx) => const CenterDetailsScreen(),
              SplashScreen.routeName: (ctx) => const SplashScreen(),
              MyBookingScreen.routeName: (ctx) => const MyBookingScreen(),
              ReceiptScreen.routeName: (ctx) => const ReceiptScreen(),
              HistoryDetailsScreen.routeName: (ctx) => const HistoryDetailsScreen(),
              MyBookingDetailsScreen.routeName: (ctx) => const MyBookingDetailsScreen(),
            },
          );
        }
      ),
    );
  }
}