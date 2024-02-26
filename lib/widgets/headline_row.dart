import 'package:flutter/material.dart';
import 'package:hisksa/utils/resources/constants.dart';

import '../utils/resources/app_fonts.dart';

class HeadLineRow extends StatelessWidget {
  final String title;
  final Function()? fct;
  const HeadLineRow({Key? key, required this.title, this.fct}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppConstants.pagePadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: AppFonts.headlineStyle,
          ),
          fct == null? const SizedBox() : TextButton(onPressed: fct, child: const Text('عرض المزيد'))
        ],
      ),
    );
  }
}
