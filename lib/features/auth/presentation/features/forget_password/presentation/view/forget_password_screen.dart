import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:hisksa/utils/resources/app_fonts.dart';
import 'package:quickalert/quickalert.dart';

import '../../../../../../../utils/resources/app_assets.dart';
import '../../../../../../../widgets/buttons.dart';
import '../../../../widgets/input_field.dart';
import '../../controller/forget_password_cubit/forget_password_cubit.dart';
import '../../controller/forget_password_cubit/forget_password_states.dart';

class ForgetPasswordScreen extends StatelessWidget {
  static const routeName = '/ForgetPasswordScreen';

  ForgetPasswordScreen({Key? key}) : super(key: key);
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final fileNum = ModalRoute.of(context)!.settings.arguments as String;
    return BlocProvider<ForgetPasswordCubit>(
      create: (context) => ForgetPasswordCubit(),
      child: BlocBuilder<ForgetPasswordCubit, ForgetPasswordStates>(
        builder: (context, state) {
          var cubit = ForgetPasswordCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        AppAssets.mainLogo,
                        height: 150,
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      const Text('إعادة تعيين كلمة السر'),
                      const SizedBox(
                        height: 50,
                      ),
                      Text('رقم الملف: $fileNum', style: AppFonts.headlineStyle,),
                      const SizedBox(
                        height: 20,
                      ),
                      MyInputFiled(
                        controller: _passwordController,
                        hint: "كلمة السر",
                        keybord: TextInputType.visiblePassword,
                        inputIcon: IconlyBroken.lock,
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
                        controller: _confirmPasswordController,
                        hint: "تأكيد كلمة السر",
                        keybord: TextInputType.visiblePassword,
                        inputIcon: IconlyBroken.lock,
                        fct: (value) {
                          if (value!.isEmpty) {
                            return 'من فضلك قم بادخال كلمة السر';
                          } else if (value.length < 6) {
                            return 'كلمة السر يجب ان تكون اكثر من 6 حروف او ارقام';
                          }
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: StadiumButton(
                          title: "التأكيد  ",
                          fct: () async {
                            if (_formKey.currentState!.validate()) {
                              if(_passwordController.text != _confirmPasswordController.text){
                                QuickAlert.show(
                                  context: context,
                                  type: QuickAlertType.warning,
                                  text: 'كلمتين السر غير متطابقتين',
                                );
                              }else{
                                cubit.resetPassword(
                                  fileNum: fileNum,
                                  password: _passwordController.text,
                                  context: context,
                                );
                              }
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}
