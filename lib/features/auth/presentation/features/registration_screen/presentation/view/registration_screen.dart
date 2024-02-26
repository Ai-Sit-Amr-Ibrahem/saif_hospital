import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hisksa/features/auth/presentation/features/registration_screen/controller/genders/get_genders_cubit.dart';
import 'package:hisksa/features/auth/presentation/features/registration_screen/controller/register_cubit/register_cubit.dart';
import 'package:hisksa/features/auth/presentation/features/registration_screen/controller/register_cubit/register_states.dart';
import 'package:hisksa/utils/resources/constants.dart';
import 'package:intl/intl.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../../../../../../../utils/resources/app_assets.dart';
import '../../../../../../../utils/resources/app_colors.dart';
import '../../../../../../home_layout/presentation/view/home_layout.dart';
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

  String countryValue = "";
  String gender = '20024';
  int? selectedOption;

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
                  : state is GetGenderStateLoaded ?Center(
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
                                      child: const Icon(Icons.arrow_forward_ios,
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
                                    } else if (value.split(' ').length < 4) {
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
                                CSCPicker(
                                  flagState: CountryFlag.SHOW_IN_DROP_DOWN_ONLY,
                                  showCities: false,
                                  showStates: false,

                                  defaultCountry: CscCountry.Saudi_Arabia,
                                  countryDropdownLabel: countryValue == ''
                                      ? 'اختر جنسيتك (اختياري)'
                                      : countryValue,
                                  dropdownDecoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(
                                              AppConstants.pagePadding)),
                                      color: Colors.white,
                                      border: Border.all(
                                          color: Colors.grey.shade300,
                                          width: 1)),
                                  onCountryChanged: (value) {
                                    print(value);
                                    setState(() {
                                      countryValue = value;
                                    });
                                    print('here is the country $value');
                                  },
                                ),
                                Text(countryValue),
                                const SizedBox(
                                  height: 20,
                                ),
                                Align(alignment: Alignment.centerRight,child: Text("الجنس")),

                                GridView.count(
                                  crossAxisCount: 2,
                                  childAspectRatio: 4,
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  children: List.generate(
                                      state.data.length, (index) {
                                    return RadioListTile(
                                      contentPadding: EdgeInsets.zero,
                                      title: Text(state.data[index].lineArName ?? ""),
                                      value:  state.data[index].lineId,
                                      groupValue: selectedOption,
                                      onChanged: (value) {
                                        setState(() {
                                          selectedOption = state.data[index].lineId;
                                          print("asdasd"+ selectedOption.toString());

                                        });
                                      },
                                      activeColor: AppColors.mainColor,
                                      fillColor: selectedOption != state.data[index].lineId
                                          ? MaterialStateColor.resolveWith((states) =>
                                          AppColors.kTextColorAccent.withOpacity(0.2))
                                          : null,
                                      selected: selectedOption == index,
                                    );
                                  }).toList(),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: SizedBox(
                                    height: 50,
                                    child: state is RegisterLoadingState
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
                                                      _userNameController.text,
                                                  name: _nameController.text,
                                                  password:
                                                      _passwordController.text,
                                                  phoneNumber:
                                                      _phoneController.text,
                                                  birthdate:
                                                      _dateController.text,
                                                  id: _idController.text,
                                                  nationality: "2",
                                                  gender: selectedOption.toString(),
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
                                ),
                                const SizedBox(
                                  height: 50,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                    ):SizedBox();
            },
          ),
        );
      }),
    );
  }
}
