import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hisksa/features/auth/presentation/features/forget_password/controller/forget_password_cubit/forget_password_cubit.dart';
import 'package:hisksa/features/auth/presentation/features/forget_password/controller/forget_password_cubit/forget_password_states.dart';
import 'package:quickalert/quickalert.dart';

import '../../../../../../../utils/resources/app_assets.dart';
import '../../../../../../../widgets/buttons.dart';
import '../../../../widgets/input_field.dart';

class CheckIDScreen extends StatelessWidget {
  static const routeName = '/CheckIDScreen';
   CheckIDScreen({Key? key}) : super(key: key);


   final TextEditingController _phoneController = TextEditingController();
   final TextEditingController _iDController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
                      MyInputFiled(
                        controller: _phoneController,
                        keybord: TextInputType.phone,
                        hint: "رقم الجوال",
                        inputIcon: IconlyBroken.call,
                        fct: (value) {
                          if (value!.isEmpty) {
                            return 'من فضلك قم بادخال رقم الجوال';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      MyInputFiled(
                        controller: _iDController,
                        hint: "رقم الهوية",
                        keybord: TextInputType.number,
                        inputIcon: AntDesign.idcard,
                        fct: (value) {
                          if (value!.isEmpty) {
                            return 'من فضلك قم بادخال رقم الهوية';
                          } return null;
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: StadiumButton(
                          title: "المتابعة لتغيير كلمة السر",
                          fct: () async {
                            if (_formKey.currentState!.validate()) {
                              cubit.chkID(
                                phone: _phoneController.text,
                                id: _iDController.text,
                                context: context,
                              );
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
