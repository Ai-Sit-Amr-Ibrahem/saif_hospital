import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import '../../../../utils/resources/constants.dart';
import '../../../../widgets/logo_progress.dart';
import '../controller/cubit/bills_cubit.dart';
import '../controller/cubit/bills_states.dart';
import 'widget/receipt_widget.dart';

class ReceiptScreen extends StatelessWidget {
  static const routeName = '/ReceiptScreen';

  const ReceiptScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('فواتيرك'),
      ),
      body: BlocProvider<BillsCubit>(
        create: (context) => BillsCubit()..getBills(context),
        child: BlocBuilder<BillsCubit, BillsStates>(builder: (context, state) {
          var cubit = BillsCubit.get(context);
          return state is BillsLoadingState || cubit.billsModel == null
              ? const LogoProgress()
              : cubit.billsModel!.data!.isEmpty
              ? const Center(
            child: Text('القائمة فارغة'),
          )
              : Padding(
                padding: const EdgeInsets.all(AppConstants.pagePadding),
                child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: cubit.billsModel!.data!.length,
                itemBuilder: (context, index) {
                  return ReceiptWidget(
                      data: cubit.billsModel!.data![index]);
                }),
              );
        }),
      ),
    );
  }
}

class BBModel {
  final String title;
  final double price;

  BBModel(this.title, this.price);
}

List<BBModel> bbList = [
  BBModel('حجز موعد الطبيب محمود سعود', 200),
  BBModel('حجز غرفة العمليات لمدة ثلاث ليالي', 3320),
  BBModel('حجز موعد دكتور محمد بيه القحطاني', 320),
  BBModel('فاتورة أشعة الساق اليسرى', 45),
  BBModel('فاتورة صرف ادوية', 89),
  BBModel('فاتورة حجز غرفة زائرين', 998),
  BBModel('فاتورة ضيافة زائرين', 459),
];
