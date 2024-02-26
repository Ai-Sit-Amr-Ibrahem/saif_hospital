import 'package:flutter/material.dart';


class GradiantButton extends StatelessWidget {
  GradiantButton({
    this.radious = 50,
    required this.text,
    required this.icon,
    required this.fct,
  });

  final double radious;
  final String text;
  final IconData icon;
  final Function() fct;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: fct,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radious),
      ),
      padding: const EdgeInsets.all(0),
      child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 35),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radious),
            gradient: LinearGradient(
              colors: kButtonGradiant,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                text,
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
              SizedBox(
                width: 9,
                child: Icon(
                  icon,
                  size: 18,
                  color: Colors.white,
                ),
              )
            ],
          )),
    );
  }
}

const List<Color> kButtonGradiant = <Color>[
  Colors.orange,
  Colors.black,
];