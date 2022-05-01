import 'package:flutter/material.dart';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:pharmacy_data_repository/pharmacy_data_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './authentication/authentication.dart';
import './routes.dart';
import './home_page/home_page.dart';
import './scanner_page/scanner_page.dart';
import './billing_page/billing_page.dart';
import './low_stock_management_page/low_stock_management.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
    required AuthenticationRepository authenticationRepository,
    required PharmacyDataRepository pharmacyDataRepository,
  })  : _authenticationRepository = authenticationRepository,
        _pharmacyDataRepository = pharmacyDataRepository,
        super(key: key);

  final AuthenticationRepository _authenticationRepository;
  final PharmacyDataRepository _pharmacyDataRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(
          value: _authenticationRepository,
        ),
        RepositoryProvider.value(
          value: _pharmacyDataRepository,
        ),
      ],
      child: BlocProvider(
        create: (context) => AuthenticationBloc(
          authenticationRepository: _authenticationRepository,
        ),
        child: MaterialApp(
          theme: ThemeData.light().copyWith(
            backgroundColor: Colors.white,
            colorScheme: const ColorScheme.light().copyWith(
              primary: Colors.blueAccent,
              primaryContainer: Colors.blueAccent,
              surface: Colors.grey[200],
              outline: Colors.grey,
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
            floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                textStyle: MaterialStateProperty.all<TextStyle>(
                  const TextStyle(fontSize: 20),
                ),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              ),
            ),
          ),
          routes: {
            Routes.loginPage: (context) => LoginPage(),
            Routes.signupPage: (context) => SignupPage(),
            Routes.homePage: (context) => const HomePage(),
            Routes.billPage: (context) => const BillingPage(),
            Routes.scannerPage: (context) => const ScannerPage(),
            Routes.lowStockManagementPage: (context) => LowStockPage(),
          },
          home: const AppView(),
        ),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AuthenticationBloc, AuthenticationState,
        AuthenticationStatus>(
      selector: (state) => state.status,
      builder: (context, status) {
        if (status == AuthenticationStatus.authenticated) {
          return BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) => const HomePage(),
          );
        }
        return BlocSelector<AuthenticationBloc, AuthenticationState,
                AuthenticationType?>(
            selector: (state) => state.authenticationType,
            builder: (context, authenticationType) {
              if (authenticationType == AuthenticationType.login) {
                return LoginPage();
              }
              return SignupPage();
            });
      },
    );
  }
}
