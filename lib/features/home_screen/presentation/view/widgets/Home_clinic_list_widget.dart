import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hisksa/features/center_details_screen/presentation/view/center_details_screen.dart';
import 'package:hisksa/features/clinics_screen/presentation/controller/cubit/clinics_cubit.dart';
import 'package:hisksa/features/clinics_screen/presentation/controller/cubit/clinics_states.dart';
import 'package:hisksa/utils/resources/app_fonts.dart';
import 'package:hisksa/widgets/logo_progress.dart';

import '../../../../../utils/resources/app_colors.dart';
import '../../../../../utils/resources/constants.dart';
import '../../../../../widgets/cached_image.dart';
import '../../../../doctors_screen/presentation/view/doctors_screen.dart';

class HomeClinicListWidget extends StatelessWidget {
  const HomeClinicListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClinicsCubit, ClinicsStates>(
      builder: (context, state) {
        var cubit = ClinicsCubit.get(context);
        return SizedBox(
          height: 130,
          child: state is GetClinicsLoadingState || cubit.clinicsModel == null ? const LogoProgress() : ListView.builder(
              itemCount: cubit.clinicsModel!.data!.length > 5 ? 5 : cubit.clinicsModel!.data!.length,
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        DoctorsScreen.routeName,
                        arguments: {
                          'id': cubit.clinicsModel!.data![index].cLIINICID,
                          'name': cubit.clinicsModel!.data![index].cLINIC,
                        },
                      );
                    },
                    child: Column(
                      children: [
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppConstants.pagePadding),
                          ),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          shadowColor: AppColors.mainColor,
                          elevation: 4,
                          child: CachedImageWidget(
                            image: cubit.clinicsModel!.data![index].iMAGE??'',
                            height: 100,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          cubit.clinicsModel!.data![index].cLINIC ?? '',
                          style: const TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                );
              }),
        );
      }
    );
  }
}
