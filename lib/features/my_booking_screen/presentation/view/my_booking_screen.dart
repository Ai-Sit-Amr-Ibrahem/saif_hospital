import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hisksa/features/my_booking_screen/presentation/controller/cubit/my_booking_cubit.dart';
import 'package:hisksa/features/my_booking_screen/presentation/controller/cubit/my_booking_states.dart';
import 'package:hisksa/utils/app/my_app.dart';
import 'package:hisksa/widgets/logo_progress.dart';
import 'package:lottie/lottie.dart';

import 'widgets/my_booking_widget.dart';

class MyBookingScreen extends StatelessWidget {
  static const routeName = '/MyBookingScreen';

  const MyBookingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('المواعيد المحجوزة مؤخراً'),
      ),
      body: BlocProvider<MyBookingCubit>(
        create: (BuildContext context) =>
            MyBookingCubit()..getMyBooking(navigatorKey.currentState!.context),
        child: BlocBuilder<MyBookingCubit, MyBookingStates>(
            builder: (context, state) {
          var cubit = MyBookingCubit.get(context);
          return state is GetMyBookingLoadingState ||
                  cubit.myBookingModel == null
              ? const LogoProgress()
              : cubit.myBookingModel!.data!.isEmpty
                  ? Center(
                    child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Lottie.network(
                              'https://assets3.lottiefiles.com/packages/lf20_EMTsq1.json'),
                          const SizedBox(height: 25,),
                          const Text('قائمة المواعيد المحجوزة فارغة')
                        ],
                      ),
                  )
                  : ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: cubit.myBookingModel!.data!.length,
                      itemBuilder: (context, index) {
                        return  MyBookingWidget(data: cubit.myBookingModel!.data![index],);
                      });
        }),
      ),
    );
  }
}
