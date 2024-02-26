import 'package:flutter/material.dart';

import '../../../../../utils/resources/constants.dart';

class ProfileButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final Color iconColor;
  final double iconSize;
  final Function() fct;

  const ProfileButton(
      {Key? key,
      required this.title,
      required this.icon,
      required this.color,
      required this.iconColor,
      required this.iconSize,
      required this.fct})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: fct,
      child: SizedBox(
        height: 120,
        child: Card(
          color: color,
          elevation: 4,
          shadowColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.pagePadding),
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: iconColor,
                  size: iconSize,
                ),
                const SizedBox(
                  height: 5,
                ),
                Flexible(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: iconColor,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

