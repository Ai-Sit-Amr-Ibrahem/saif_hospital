import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hisksa/features/clinics_screen/presentation/controller/cubit/clinics_cubit.dart';
import 'package:hisksa/features/clinics_screen/presentation/controller/cubit/clinics_states.dart';
import 'package:hisksa/features/doctors_screen/presentation/view/doctors_screen.dart';
import 'package:hisksa/widgets/logo_progress.dart';

class CategoriesGrid extends StatelessWidget {
  final int crossAxisCount;

  const CategoriesGrid({
    Key? key,
    this.crossAxisCount = 2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClinicsCubit, ClinicsStates>(builder: (context, state) {
      var cubit = ClinicsCubit.get(context);
      return state is GetClinicsLoadingState
          ? const Center(child: LogoProgress())
          : MasonryGridView.count(
              padding: const EdgeInsets.all(0),
              physics: const BouncingScrollPhysics(),
              crossAxisCount: crossAxisCount,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              itemCount: cubit.clinicsModel!.data!.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    InkWell(
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
                      child: Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            20,
                          ),
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Image.network(
                          ((cubit.clinicsModel!.data![index].iMAGE != 'NULL') && (cubit.clinicsModel!.data![index].iMAGE != null))
                              ? cubit.clinicsModel!.data![index].iMAGE!
                              : 'https://img.freepik.com/free-photo/blur-hospital_1203-7956.jpg?w=900&t=st=1680166363~exp=1680166963~hmac=945711c9a5c45a64cdeb993c45a9ab00aaf9fbb9a7525ba9734d5b3ea6af4624 ',
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
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
                );
              },
            );
    });
  }
}
