import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../utils/resources/app_colors.dart';


class MyInputFiled extends StatelessWidget {
  const MyInputFiled({
    required this.hint,
    required this.controller,
    required this.inputIcon,
    this.borderRadious = 40.0,
    this.keybord = TextInputType.text,
    this.iconColor = AppColors.mainColor,
    this.isPass = false,
     this.format,
    this.onSuffixPressed,
    required this.fct,
  });

  final TextEditingController controller;
  final double borderRadious;
  final String hint;
  final TextInputType keybord;
  final IconData inputIcon;
  final Color iconColor;
  final bool isPass;
  final List<TextInputFormatter>? format;
  final Function()? onSuffixPressed;
  final String? Function(String?)? fct;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(borderRadious),
          ),
          boxShadow: const [
            BoxShadow(
              color: AppColors.mainColor,
              offset: Offset(0, 3),
              blurRadius: 4.0,
            )
          ],
        ),
        child: TextFormField(
          controller: controller,
          obscureText: isPass,
          keyboardType: keybord,
          inputFormatters: format,
          validator: fct,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: Colors.black
          ),
          decoration: InputDecoration(
            counterStyle: const TextStyle(
              fontSize: 30,
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            suffixIcon: IconButton(
              onPressed: onSuffixPressed,
              icon: Icon(
                inputIcon,
                color: iconColor,
              ),
            ),
            hintText: hint,
            hintStyle: const TextStyle(
              fontSize: 16,
              color: Colors.black38,
            ),
            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(
                Radius.circular(borderRadious),
              ),
            ),
          ),
        ),
      ),
    );
  }
}