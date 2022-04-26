import 'package:flutter/material.dart';

import './billing_page/billing_page.dart';
// import './billing_page/view/billing_page.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: BillingPage(),
      ),
    );
  }
}
