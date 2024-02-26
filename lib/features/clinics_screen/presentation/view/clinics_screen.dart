import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:hisksa/utils/resources/constants.dart';

import '../../../../utils/resources/app_assets.dart';
import '../../../../widgets/buttons.dart';
import '../../../auth/presentation/widgets/input_field.dart';
import 'widgets/categories_grid_view.dart';

class ClinicsScreen extends StatelessWidget {
  ClinicsScreen({Key? key}) : super(key: key);

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset(
          AppAssets.mainLogo,
          height: 30,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppConstants.pagePadding),
        child: CategoriesGrid(crossAxisCount: 3,),
      ),
    );
  }
}
