import 'package:flutter/material.dart';

class ItemLine extends StatelessWidget {
  final IconData icon;
  final String text;
  final String? label;
  final TextStyle? style;
  final Color? iconColor;
  final int? maxLine;
  const ItemLine({Key? key, required this.icon, required this.text, this.style, this.iconColor, this.maxLine, this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Icon(icon, color: iconColor,),
        const SizedBox(
          width: 5,
        ),
        Text(label != null ? '$label: ' : ''),
        Expanded(
          child: Text(
            text,
            style: style,
            maxLines: maxLine,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
