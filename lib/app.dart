import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:barcode_repository/barcode_repository.dart';
import 'package:master_db_repository/master_db_repository.dart';
import 'package:pharmacy_data_repository/pharmacy_data_repository.dart';
import 'package:authentication_repository/authentication_repository.dart';

import './routes.dart';
import './home_page/home_page.dart';
import './constants/constants.dart';
import './scanner_page/scanner_page.dart';
import './billing_page/billing_page.dart';
import './bill_history/bill_history.dart';
import './authentication/authentication.dart';
import './low_stock_management_page/low_stock_management.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
    required AuthenticationRepository authenticationRepository,
    required PharmacyDataRepository pharmacyDataRepository,
    required BarcodeRepository barcodeRepository,
    required MasterDBHandler masterDBHandler,
  })  : _authenticationRepository = authenticationRepository,
        _pharmacyDataRepository = pharmacyDataRepository,
        _barcodeRepository = barcodeRepository,
        _masterDBHandler = masterDBHandler,
        super(key: key);

  final AuthenticationRepository _authenticationRepository;
  final PharmacyDataRepository _pharmacyDataRepository;
  final BarcodeRepository _barcodeRepository;
  final MasterDBHandler _masterDBHandler;

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
        RepositoryProvider.value(
          value: _barcodeRepository,
        ),
        RepositoryProvider.value(
          value: _masterDBHandler,
        ),
      ],
      child: BlocProvider(
        create: (context) => AuthenticationBloc(
          authenticationRepository: _authenticationRepository,
        ),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light().copyWith(
            backgroundColor: Colors.white,
            colorScheme: const ColorScheme.light().copyWith(
              primary: const Color(0xFF0d6efd),
              primaryContainer: const Color(0xFF0d6efd),
              surface: Colors.grey[200],
              outline: Colors.grey,
            ),
            iconTheme: const IconThemeData(
              color: Colors.white,
              size: kDefaultIconSize,
            ),
            textTheme: TextTheme(
              headline1: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
              headline2: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
                color: Colors.grey[700],
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
            floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: Color(0xFF0d6efd),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                textStyle: MaterialStateProperty.all<TextStyle>(
                  const TextStyle(fontSize: 20),
                ),
                backgroundColor: MaterialStateProperty.all<Color>(
                  const Color(0xFF0d6efd),
                ),
              ),
            ),
            switchTheme: SwitchThemeData(
              thumbColor: MaterialStateProperty.all<Color>(
                const Color(0xFF0d6efd),
              ),
            ),
          ),
          routes: {
            Routes.loginPage: (context) => LoginPage(),
            Routes.signupPage: (context) => SignupPage(),
            Routes.homePage: (context) => const HomePage(),
            Routes.billPage: (context) => const BillingPage(),
            Routes.scannerPage: (context) => const ScannerPage(),
            Routes.lowStockManagementPage: (context) => const LowStockPage(),
            Routes.billHistory: (context) => const BillHistory(),
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
