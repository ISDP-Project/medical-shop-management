import 'package:flutter/material.dart';

import './authentication/authentication.dart';
import './home_page/home_page.dart';
import './routes.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        backgroundColor: Colors.white,
        colorScheme: ColorScheme.light().copyWith(
          primary: Colors.blueAccent,
        ),
        iconTheme: const IconThemeData(
          color: Colors.black,
          size: 32.0,
        ),
        textTheme: TextTheme(
          headline1: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          bodyText1: const TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
          bodyText2: TextStyle(
            fontSize: 15,
            color: Colors.grey[700],
          ),
          button: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 19,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
      initialRoute: Routes.loginPage,
      routes: {
        Routes.loginPage: (context) => const LoginPage(),
        Routes.signupPage: (context) => const SignupPage(),
        Routes.homePage: (context) => const HomePage(),
      },
    );
  }
}
