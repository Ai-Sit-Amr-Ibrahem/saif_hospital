import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:hisksa/utils/resources/app_fonts.dart';
import 'package:hisksa/utils/resources/constants.dart';

class NotificationScreen extends StatelessWidget {
  static const routeName = '/NotificationScreen';
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الاشعارات'),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(AppConstants.pagePadding),
              child: Text('جديد', style: AppFonts.headlineStyle,),
            ),
            const Divider(),
            ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 5,
                itemBuilder: (context, index){
              return const ListTile(
                leading: Icon(IconlyBroken.notification),
                title: Text('تأكيد حجز'),
                subtitle: Text('تم تأكيد حجز موعد عند الطبيب د. محمد السيد حامد'),
              );
            }),
            const Divider(),

            const Padding(
              padding: EdgeInsets.all(AppConstants.pagePadding),
              child: Text('قديماَ', style: AppFonts.headlineStyle,),
            ),

            const Divider(),
            ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 12,
                itemBuilder: (context, index){
                  return const ListTile(
                    leading: Icon(IconlyBroken.notification),
                    title: Text('تأكيد حجز'),
                    subtitle: Text('تم تأكيد حجز موعد عند الطبيب د. محمد السيد حامد'),
                  );
                }),

          ],
        ),
      ),
    );
  }
}
