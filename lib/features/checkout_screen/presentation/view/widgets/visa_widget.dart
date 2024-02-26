import 'package:awesome_card/credit_card.dart';
import 'package:awesome_card/style/card_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;

import '../../../../../widgets/buttons.dart';


class VisaWidget extends StatefulWidget {
  VisaWidget({Key? key,}) : super(key: key);


  @override
  _VisaWidgetState createState() => _VisaWidgetState();
}

class _VisaWidgetState extends State<VisaWidget> {
  String cardNumber = '';
  String cardHolderName = '';
  String expiryDate = '';
  String cvv = '';
  bool showBack = false;

  late FocusNode _focusNode;
  TextEditingController cardNumberCtrl = TextEditingController();
  TextEditingController expiryFieldCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {
        _focusNode.hasFocus ? showBack = true : showBack = false;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CreditCard(
          cardNumber: cardNumber,
          cardExpiry: expiryDate,
          cardHolderName: cardHolderName,
          cvv: cvv,
          bankName: 'SIT Bank',
          showBackSide: showBack,
          frontBackground: CardBackgrounds.black,
          backBackground: CardBackgrounds.white,
          showShadow: true,
          // mask: getCardTypeMask(cardType: CardType.americanExpress),
        ),
        const SizedBox(
          height: 20,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: TextFormField(
                controller: cardNumberCtrl,

                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(
                      RegExp(r'[0-9]')),
                ],
                decoration: const InputDecoration(hintText: 'Card Number',),
                maxLength: 16,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  final newCardNumber = value.trim();
                  var newStr = '';
                  final step = 4;

                  for (var i = 0; i < newCardNumber.length; i += step) {
                    newStr += newCardNumber.substring(
                        i, math.min(i + step, newCardNumber.length));
                    if (i + step < newCardNumber.length) newStr += ' ';
                  }

                  setState(() {
                    cardNumber = newStr;
                  });
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: TextFormField(
                controller: expiryFieldCtrl,
                decoration: const InputDecoration(hintText: 'Card Expiry'),
                maxLength: 5,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  var newDateValue = value.trim();
                  final isPressingBackspace =
                      expiryDate.length > newDateValue.length;
                  final containsSlash = newDateValue.contains('/');

                  if (newDateValue.length >= 2 &&
                      !containsSlash &&
                      !isPressingBackspace) {
                    newDateValue = newDateValue.substring(0, 2) +
                        '/' +
                        newDateValue.substring(2);
                  }
                  setState(() {
                    expiryFieldCtrl.text = newDateValue;
                    expiryFieldCtrl.selection = TextSelection.fromPosition(
                        TextPosition(offset: newDateValue.length));
                    expiryDate = newDateValue;
                  });
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: TextFormField(
                decoration: const InputDecoration(hintText: 'Card Holder Name'),
                onChanged: (value) {
                  setState(() {
                    cardHolderName = value;
                  });
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
              child: TextFormField(
                decoration: const InputDecoration(hintText: 'CVV'),
                maxLength: 3,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    cvv = value;
                  });
                },
                focusNode: _focusNode,
              ),
            ),
          ],
        ),
        StadiumButton(title: 'حفظ الفاتورة', fct: (){}),
      ],
    );
  }
}