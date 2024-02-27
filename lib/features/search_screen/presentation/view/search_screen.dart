import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:hisksa/features/doctors_screen/data/model/doctor_Model.dart';
import 'package:hisksa/utils/resources/app_fonts.dart';
import 'package:hisksa/widgets/headline_row.dart';

import '../../../../utils/resources/app_colors.dart';
import '../../../../utils/resources/constants.dart';
import '../../../../widgets/buttons.dart';
import '../../../../widgets/cached_image.dart';
import '../../../auth/presentation/widgets/input_field.dart';
import '../../../doctors_screen/presentation/view/doctors_screen.dart';
import '../../../home_screen/presentation/view/widgets/dr_widget.dart';
import '../controller/cubit/search_cubit.dart';
import '../controller/cubit/search_states.dart';

class SearchScreen extends StatelessWidget {
  static const routeName = '/SearchScreen';

  SearchScreen({Key? key}) : super(key: key);
  TextEditingController searchController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('البحث'),
      ),
      body: BlocProvider<SearchCubit>(
        create: (context) => SearchCubit(),
        child:
            BlocBuilder<SearchCubit, SearchStates>(builder: (context, state) {
          var cubit = SearchCubit.get(context);
          return Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      AppConstants.pagePadding,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(AppConstants.pagePadding),
                    child: Column(
                      children: [
                        MyInputFiled(
                          controller: searchController,
                          hint: 'بحث',
                          inputIcon: IconlyBroken.search,
                          keybord: TextInputType.text,
                          fct: (value) {
                            if (value!.isEmpty) {
                              return 'من فضلك قم بادخال بيانات';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        StadiumButton(
                          buttonWidth: double.infinity,
                          title: 'بحث',
                          fct: () {
                            if (_formKey.currentState!.validate()) {
                              cubit.getSearch(context, searchController.text);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: DefaultTabController(
                    length: 2,
                    child: Column(
                      children: [
                        const TabBar(tabs: [
                          Tab(
                            text: 'أطباء',
                          ),
                          Tab(
                            text: 'عيادات',
                          ),
                        ]),
                        Expanded(
                          child: cubit.searchModel == null
                              ? const Center(
                                  child: Text('قم بالبحث عن طبيب او عيادة'))
                              : TabBarView(children: [
                                  ListView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    itemCount:
                                        cubit.searchModel!.data!.dOCTOR!.length,
                                    itemBuilder: (context, index) {
                                      return DrWidget(data: cubit.searchModel!.data!.dOCTOR![index]);
                                    },
                                  ),
                                  ListView.builder(
                                      physics: const BouncingScrollPhysics(),
                                      itemCount:
                                          cubit.searchModel!.data!.cLINIC!.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 6.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushNamed(
                                                context,
                                                DoctorsScreen.routeName,
                                                arguments: {
                                                  'id': cubit.searchModel!.data!.cLINIC![index].cLIINICID,
                                                  'name': cubit.searchModel!.data!.cLINIC![index].cLINIC,
                                                },
                                              );
                                            },
                                            child: Card(
                                              clipBehavior: Clip.antiAliasWithSaveLayer,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(
                                                  20,
                                                ),
                                              ),
                                              elevation: 8,
                                              shadowColor: AppColors.mainColor,
                                              child: Row(
                                                children: [
                                                  Card(
                                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                                    shape: const CircleBorder(),
                                                    elevation: 4,
                                                    shadowColor: AppColors.mainColor,
                                                    child: CachedImageWidget(
                                                      image: cubit.searchModel!.data!.cLINIC![index].iMAGE!= null
                                                          ? cubit.searchModel!.data!.cLINIC![index].iMAGE!
                                                          : 'https://img.freepik.com/free-photo/medical-banner-with-doctor-wearing-goggles_23-2149611193.jpg?w=900&t=st=1680166194~exp=1680166794~hmac=fdc7357426a297dce81d20b4bf2e0a2a47ceaf4d70b3fd70ddabc5b7175fd779',
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    cubit.searchModel!.data!.cLINIC![index].cLINIC ?? '',
                                                    style: const TextStyle(
                                                        fontWeight: FontWeight.w700, fontSize: 12),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                ]),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
