import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:hisksa/features/auth/presentation/features/login_screen/controller/login_cubit/login_states.dart';
import 'package:hisksa/features/home_layout/presentation/view/home_layout.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../../main.dart';
import '../../../../../../../utils/resources/app_assets.dart';
import '../../../../../../../utils/resources/app_colors.dart';
import '../../../../../../../utils/resources/constants.dart';
import '../../../../../../../widgets/buttons.dart';
import '../../../../../../splash_screen/presentation/view/splash_screen.dart';
import '../../../../widgets/input_field.dart';
import '../../../forget_password/presentation/view/check_id_screen.dart';
import '../../../forget_password/presentation/view/forget_password_screen.dart';
import '../../../registration_screen/presentation/view/registration_screen.dart';
import '../../controller/login_cubit/login_cubit.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/LoginScreen';

  LoginScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginCubit>(
      create: (context) => LoginCubit(),
      child: BlocBuilder<LoginCubit, LoginStates>(builder: (context, state) {
        var cubit = LoginCubit.get(context);
        return Scaffold(
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                HomeLayout.routeName,
                                (route) => false,
                              );
                            },
                            child: const Text(
                              'المواصلة كضيف',
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColors.mainColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Image.asset(
                       AppAssets.mainLogo,
                        height: 260,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      MyInputFiled(
                        controller: _usernameController,
                        keybord: TextInputType.name,
                        hint: "اسم المستخدم",
                        inputIcon: IconlyBroken.profile,
                        fct: (value) {
                          if (value!.isEmpty) {
                            return 'من فضلك قم بادخال اسم المستخدم';
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      MyInputFiled(
                        controller: _passwordController,
                        hint: "كلمة المرور",
                        isPass: cubit.isPassword,
                        onSuffixPressed: () {
                          cubit.changePasswordVisibility();
                        },
                        inputIcon: cubit.suffix,
                        fct: (value) {
                          if (value!.isEmpty) {
                            return 'من فضلك ادخل كلمة المرور';
                          } else if (value.length < 6) {
                            return 'كلمة المرور يجب ان تكون اكثر من ٦ احرف';
                          } else if (value.length > 60) {
                            return 'كلمة المرور يجب ان تكون اقل من ٦٠ حرف';
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, CheckIDScreen.routeName);
                          },
                          child: Text(
                            "نسيت كلمة السر!؟",
                            // textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 12,
                              decoration: TextDecoration.none,
                              color: const Color(0xFF757575).withOpacity(.5),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                       Align(
                        alignment: Alignment.bottomRight,
                        child: state is LoginLoadingState? const CircularProgressIndicator.adaptive() : StadiumButton(
                          title: 'تسجيل الدخول',
                          fct: () {
                            // Navigator.of(context).pushNamedAndRemoveUntil(
                            //     SplashScreen.routeName,
                            //     (Route<dynamic> route) => false);

                            if (_formKey.currentState!.validate()) {
                              cubit.login(
                                userName: _usernameController.text,
                                password: _passwordController.text,
                                context: context,
                              );
                            }
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'تسجيل مستخدم جديد!!',
                            style: TextStyle(
                              fontSize: 14,
                              color: const Color(0xFF757575).withOpacity(.5),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                SignUpScreen.routeName,
                              );
                            },
                            child: Text(
                              'تسجيل مستخدم'.toUpperCase(),
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.mainColor),
                            ),
                          ),
                        ],
                      ),
                      // TextButton(onPressed: (){
                      //   Navigator.pushReplacementNamed(context, HomeLayout.routeName,);
                      // }, child: const Text('تخطي')),
                      const SizedBox(
                        height: 40,
                      ),
                      Text(
                        'Version: ${packageInfo.version}',
                        style: const TextStyle(color: Colors.grey),
                      ),
                      Text('Copyright© ${DateTime.now().year}',
                          style: Theme.of(context).textTheme.caption),
                      Text(
                        'Powered By',
                        style: Theme.of(context).textTheme.caption,
                      ),
                      InkWell(
                        onTap: () async {
                          String url = 'https://www.sitksa-eg.com/home';
                          if (await canLaunch(url)) {
                            await launch(url);
                          }
                        },
                        child: Image.asset(AppAssets.sitLogo, height: 55),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
