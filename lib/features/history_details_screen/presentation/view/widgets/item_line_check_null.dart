import 'package:flutter/material.dart';

class ItemLineNullCheck extends StatelessWidget {
  final IconData icon;
  final String keyText;
  final String value;

  const ItemLineNullCheck({
    Key? key,
    required this.keyText,
    required this.value,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return value == 'null'
        ? const SizedBox()
        : Row(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(keyText),
                    Icon(icon),
                  ],
                ),
              ),
              Expanded(
                child: Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: Text(
                    value,
                  ),
                ),
              ),
            ],
          );
  }
}
