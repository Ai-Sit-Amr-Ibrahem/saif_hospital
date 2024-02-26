import 'package:flutter/material.dart';

class BalanceScreen extends StatelessWidget {
  static const routeName = '/BalanceScreen';
  const BalanceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('رصيدك'),
      ),
    );
  }
}
