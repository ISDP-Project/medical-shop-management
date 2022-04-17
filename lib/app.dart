import 'package:flutter/material.dart';

import './constants/ui_decorations.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        iconTheme: const IconThemeData(
          color: kDefaultLightPrimary,
        ),
      ),
      home: SafeArea(
        child: Container(),
      ),
    );
  }
}
