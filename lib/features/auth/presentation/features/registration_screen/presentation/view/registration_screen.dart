import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hisksa/features/auth/data/model/gender.dart';
import 'package:hisksa/features/auth/presentation/features/registration_screen/controller/countries/get_countries_cubit.dart';
import 'package:hisksa/features/auth/presentation/features/registration_screen/controller/genders/get_genders_cubit.dart';
import 'package:hisksa/features/auth/presentation/features/registration_screen/controller/register_cubit/register_cubit.dart';
import 'package:hisksa/features/auth/presentation/features/registration_screen/controller/register_cubit/register_states.dart';
import 'package:hisksa/utils/resources/constants.dart';
import '../../../../../../../utils/resources/app_assets.dart';
import '../../../../../../../utils/resources/app_colors.dart';
import '../../../../../../../utils/resources/size_config.dart';
import '../../../../../../../widgets/countries_widget.dart';
import '../../../../widgets/input_field.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = '/SignUpScreen';

  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _dateController = TextEditingController();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _rePasswordController = TextEditingController();

  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  LookUps? selectedCountry;

  String countryValue = "";
  String gender = '20024';
  int? selectedOption;
String? countryId;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RegisterCubit>(
          create: (context) => RegisterCubit(),
        ),
        BlocProvider<GetGenderCubit>(
          create: (context) => GetGenderCubit()..getLookUps(context, id: "302"),
        ),
        BlocProvider<GetCountriesCubit>(
          create: (context) =>
              GetCountriesCubit()..getLookUps(context, id: "303"),
        )
      ],
      child:
          BlocBuilder<RegisterCubit, RegisterStates>(builder: (context, state) {
        var cubit = RegisterCubit.get(context);
        return Scaffold(
          body: BlocBuilder<GetGenderCubit, GetGenderState>(
            builder: (context, state) {
              return state is GetGenderStateLoading
                  ? const Center(child: CircularProgressIndicator.adaptive())
                  : state is GetGenderStateLoaded
                      ? Center(
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    const SizedBox(height: 20),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Icon(
                                              Icons.arrow_forward_ios,
                                              color: AppColors.mainColor),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 25,
                                    ),
                                    Image.asset(
                                      AppAssets.mainLogo,
                                      height: 260,
                                    ),
                                    const SizedBox(
                                      height: 50,
                                    ),
                                    MyInputFiled(
                                      controller: _nameController,
                                      hint: "الأسم بالعربي بالكامل رباعي",
                                      inputIcon: IconlyBroken.profile,
                                      keybord: TextInputType.text,
                                      fct: (value) {
                                        if (value!.isEmpty) {
                                          return 'من فضلك قم بإدخال اسمك';
                                        } else if (value.split(' ').length <
                                            4) {
                                          return 'الرجاء ادخال الأسم رباعي';
                                        }
                                      },
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    MyInputFiled(
                                      controller: _userNameController,
                                      hint:
                                          "اسم المستخدم(سيتم استخدام هذا الاسم اثناء تسجيل الدخول)",
                                      inputIcon: IconlyBroken.message,
                                      keybord: TextInputType.text,
                                      fct: (value) {
                                        if (value!.isEmpty) {
                                          return 'من فضلك قم بإدخال اسم المستخدم';
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    MyInputFiled(
                                      controller: _passwordController,
                                      hint: "كلمة السر",
                                      keybord: TextInputType.visiblePassword,
                                      isPass: cubit.isPassword,
                                      onSuffixPressed: () {
                                        cubit.changePasswordVisibility();
                                      },
                                      inputIcon: cubit.suffix,
                                      fct: (value) {
                                        if (value!.isEmpty) {
                                          return 'من فضلك قم بادخال كلمة السر';
                                        } else if (value.length < 6) {
                                          return 'كلمة السر يجب ان تكون اكثر من 6 حروف او ارقام';
                                        }
                                      },
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    MyInputFiled(
                                      controller: _rePasswordController,
                                      hint: "اعادة كتابة كلمة السر",
                                      keybord: TextInputType.visiblePassword,
                                      isPass: cubit.isPassword,
                                      inputIcon: cubit.suffix,
                                      onSuffixPressed: () {
                                        cubit.changePasswordVisibility();
                                      },
                                      fct: (value) {
                                        if (value!.isEmpty) {
                                          return 'من فضلك قم باعادة ادخال الرقم السري';
                                        } else if (value.length < 6) {
                                          return 'كلمة السر يجب ان تكون اكثر من 6 حروف او ارقام';
                                        } else if (_rePasswordController.text
                                                .toLowerCase()
                                                .trim() !=
                                            _passwordController.text
                                                .toLowerCase()
                                                .trim()) {
                                          return 'يجب ان تتطابق كلمتين السر';
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    MyInputFiled(
                                      controller: _phoneController,
                                      hint: "رقم الهاتف (اختياري)",
                                      keybord: TextInputType.phone,
                                      inputIcon: IconlyBroken.call,
                                      format: [
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      fct: (value) {
                                        return null;
                                      },
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    MyInputFiled(
                                      controller: _idController,
                                      hint: "رقم الهوية (اختياري)",
                                      keybord: TextInputType.phone,
                                      inputIcon: MaterialCommunityIcons
                                          .badge_account_horizontal_outline,
                                      format: [
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      fct: (value) {
                                        return null;
                                      },
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    // BlocBuilder<GetCountriesCubit,
                                    //         GetCountriesState>(
                                    //     builder: (context, state) {
                                    //   return state is GetCountriesStateLoaded ?DropdownButtonHideUnderline(
                                    //     child: DropdownButton2<LookUps>(
                                    //       isExpanded: true,
                                    //       hint: Text(
                                    //
                                    //             "اختر جنسيتك اخياري",
                                    //         style: TextStyle(
                                    //             color: AppColors.kTextColorAccent,
                                    //             fontSize: SizeConfig.textScale(
                                    //                     context) *
                                    //                 12),
                                    //         overflow: TextOverflow.ellipsis,
                                    //       ),
                                    //       items: state.data
                                    //           .map(
                                    //               (LookUps item) =>
                                    //                   DropdownMenuItem<
                                    //                       LookUps>(
                                    //                     value: item,
                                    //                     child:
                                    //                         selectedCountry !=
                                    //                                 item
                                    //                             ? Row(
                                    //                                 mainAxisAlignment:
                                    //                                     MainAxisAlignment
                                    //                                         .start,
                                    //                                 children: [
                                    //                                   Icon(
                                    //                                       selectedCountry == item
                                    //                                           ?Icons.radio_button_checked
                                    //                                           :Icons.radio_button_off,
                                    //                                       size: SizeConfig.height(
                                    //                                           16,
                                    //                                           context),
                                    //                                      ),
                                    //                                   const SizedBox(width: 8,),
                                    //                                   Text(
                                    //                                     item.lineArName ??
                                    //                                         '',
                                    //                                     style:
                                    //                                         TextStyle(
                                    //                                       fontSize:
                                    //                                          14,
                                    //                                       fontWeight: selectedCountry == item
                                    //                                           ? FontWeight.w700
                                    //                                           : FontWeight.w400,
                                    //                                       color: selectedCountry == item
                                    //                                           ? AppColors.mainColor
                                    //                                           : AppColors.kTextColorAccent,
                                    //                                     ),
                                    //                                     overflow:
                                    //                                         TextOverflow.ellipsis,
                                    //                                   ),
                                    //                                 ],
                                    //                               )
                                    //                             : Text(
                                    //                                 item.lineArName ??
                                    //                                     '',
                                    //                                 style:
                                    //                                     TextStyle(
                                    //                                   fontSize:
                                    //                                       14,
                                    //                                   fontWeight: selectedCountry ==
                                    //                                           item
                                    //                                       ? FontWeight
                                    //                                           .w700
                                    //                                       : FontWeight
                                    //                                           .w400,
                                    //                                   color: selectedCountry ==
                                    //                                           item
                                    //                                       ? AppColors
                                    //                                           .mainColor
                                    //                                       : AppColors
                                    //                                           .kTextColorAccent,
                                    //                                 ),
                                    //                                 overflow:
                                    //                                     TextOverflow
                                    //                                         .ellipsis,
                                    //                               ),
                                    //                   ))
                                    //           .toList(),
                                    //       value: selectedCountry,
                                    //       onChanged: (LookUps? value) {
                                    //         setState(() {
                                    //           selectedCountry = value;
                                    //           countryId = selectedCountry!.lineId.toString();
                                    //         });
                                    //
                                    //       },
                                    //       buttonStyleData: ButtonStyleData(
                                    //         height: 50,
                                    //         width: double.infinity,
                                    //         padding: const EdgeInsets.symmetric(horizontal: 14),
                                    //         decoration: BoxDecoration(
                                    //           borderRadius:
                                    //               BorderRadius.circular(10),
                                    //           border: Border.all(
                                    //               color: AppColors.mainColor,
                                    //               width: 0.5),
                                    //           color: AppColors.white,
                                    //         ),
                                    //         elevation: 0,
                                    //       ),
                                    //       iconStyleData: const IconStyleData(
                                    //         icon: Icon(Icons.arrow_drop_down),
                                    //         iconSize: 24,
                                    //         iconEnabledColor: AppColors.kTextColorAccent,
                                    //         iconDisabledColor: AppColors.kTextColorAccent,
                                    //       ),
                                    //       dropdownStyleData: DropdownStyleData(
                                    //         width:
                                    //             double.infinity,
                                    //         maxHeight: 400,
                                    //         padding: EdgeInsets.zero,
                                    //         decoration: BoxDecoration(
                                    //           border: Border.all(
                                    //               color: AppColors.kTextColorAccent,
                                    //               width: 0.5),
                                    //           borderRadius:
                                    //               BorderRadius.circular(14),
                                    //           color: AppColors.white,
                                    //         ),
                                    //         offset: const Offset(0, 0),
                                    //         scrollbarTheme: ScrollbarThemeData(
                                    //           radius: const Radius.circular(40),
                                    //           thickness: MaterialStateProperty
                                    //               .all<double>(6),
                                    //           thumbVisibility:
                                    //               MaterialStateProperty.all<
                                    //                   bool>(true),
                                    //         ),
                                    //       ),
                                    //       menuItemStyleData: const MenuItemStyleData(
                                    //         height: 40,
                                    //         padding: EdgeInsets.symmetric(horizontal: 14),
                                    //       ),
                                    //     ),
                                    //   ):SizedBox();
                                    // }),
                                    Text(countryValue),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const Align(
                                        alignment: Alignment.centerRight,
                                        child: Text("الجنس")),
                                    GridView.count(
                                      crossAxisCount: 2,
                                      childAspectRatio: 4,
                                      padding: EdgeInsets.zero,
                                      shrinkWrap: true,
                                      children: List.generate(state.data.length,
                                          (index) {
                                        return RadioListTile(
                                          contentPadding: EdgeInsets.zero,
                                          title: Text(
                                              state.data[index].lineArName ??
                                                  ""),
                                          value: state.data[index].lineId,
                                          groupValue: selectedOption,
                                          onChanged: (value) {
                                            setState(() {
                                              selectedOption =
                                                  state.data[index].lineId;
                                              print("asdasd" +
                                                  selectedOption.toString());
                                            });
                                          },
                                          activeColor: AppColors.mainColor,
                                          fillColor: selectedOption !=
                                                  state.data[index].lineId
                                              ? MaterialStateColor.resolveWith(
                                                  (states) => AppColors
                                                      .kTextColorAccent
                                                      .withOpacity(0.2))
                                              : null,
                                          selected: selectedOption == index,
                                        );
                                      }).toList(),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    BlocBuilder<RegisterCubit, RegisterStates>(
  builder: (context, state) {
    return Align(
                                      alignment: Alignment.bottomRight,
                                      child: SizedBox(
                                        height: 50,
                                        child: state is RegisterSuccessState
                                            ? const CircularProgressIndicator
                                                .adaptive()
                                            : MaterialButton(
                                                shape: const StadiumBorder(),
                                                clipBehavior:
                                                    Clip.antiAliasWithSaveLayer,
                                                elevation: 5,
                                                onPressed: () {
                                                  if (_formKey.currentState!
                                                      .validate()) {
                                                    RegisterCubit.get(context)
                                                        .signUp(
                                                      userName:
                                                          _userNameController
                                                              .text,
                                                      name:
                                                          _nameController.text,
                                                      password:
                                                          _passwordController
                                                              .text,
                                                      phoneNumber:
                                                          _phoneController.text,
                                                      birthdate:
                                                          _dateController.text,
                                                      id: _idController.text,
                                                      nationality: countryId,
                                                      gender: selectedOption
                                                          .toString(),
                                                      context: context,
                                                    );
                                                  }
                                                },
                                                color: AppColors.mainColor,
                                                child: const Text(
                                                  'تسجيل مستخدم',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                      ),
                                    );
  },
),
                                    const SizedBox(
                                      height: 50,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'بالفعل يوجد اكونت!!',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: const Color(0xFF757575)
                                                .withOpacity(.5),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            'تسجيل الدخول'.toUpperCase(),
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.mainColor),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      : const SizedBox();
            },
          ),
        );
      }),
    );
  }
}
