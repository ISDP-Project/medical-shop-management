import 'dart:developer';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy_data_repository/pharmacy_data_repository.dart';

import '../../routes.dart';
import '../widgets/widgets.dart';
import '../../constants/constants.dart';
import '../../authentication/authentication.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    log('built homepage with gst: ${context.read<AuthenticationBloc>().state.user!.pharmacyGstin}');
    context.read<PharmacyDataRepository>().setPharmacyName(
          context.read<AuthenticationBloc>().state.user!.pharmacyGstin,
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: kDefaultAppBarElevation,
        title: Row(
          children: [
            Text(
              HomePageConstants.appBarGreeting.replaceFirst(
                HomePageConstants.replace,
                context.read<AuthenticationBloc>().state.user!.firstName,
              ),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              child: Text(HomePageConstants.drawerHeading),
              decoration: BoxDecoration(),
            ),
            ListTile(
              title: const Text(HomePageConstants.home),
              onTap: () {
                Navigator.of(context);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text(HomePageConstants.notification),
              onTap: () {
                Navigator.of(context);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text(HomePageConstants.setting),
              onTap: () {
                Navigator.of(context);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text(HomePageConstants.payment),
              onTap: () {
                Navigator.of(context);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text(HomePageConstants.user),
              onTap: () {
                Navigator.of(context);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text(HomePageConstants.help),
              onTap: () {
                Navigator.of(context);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text(HomePageConstants.logOutButtonLabel),
              onTap: () {
                context.read<AuthenticationRepository>().logOut();
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: kDefaultMargin * 1.25),
          padding: const EdgeInsets.only(top: kDefaultPadding * 2),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      icon: Icons.qr_code_scanner_outlined,
                      label: HomePageConstants.scanPageButtonLabel,
                      onPressed: () =>
                          Navigator.pushNamed(context, Routes.scannerPage),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: kDefaultMargin),
                  ),
                  Expanded(
                    child: CustomButton(
                      icon: Icons.receipt_long_rounded,
                      label: HomePageConstants.billiingPageButtonLabel,
                      onPressed: () =>
                          Navigator.pushNamed(context, Routes.billPage),
                    ),
                  ),
                ],
              ),
              const Padding(padding: EdgeInsets.only(top: kDefaultPadding * 2)),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      icon: Icons.notifications_active,
                      label: HomePageConstants.lowStockPageLabel,
                      onPressed: () => Navigator.pushNamed(
                        context,
                        Routes.lowStockManagementPage,
                      ),
                    ),
                  ),
                ],
              ),
              const Padding(padding: EdgeInsets.only(top: kDefaultPadding * 2)),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      icon: Icons.history,
                      label: HomePageConstants.billHistoryLabel,
                      onPressed: () {},
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: kDefaultMargin),
                  ),
                  Expanded(
                    child: CustomButton(
                      label: HomePageConstants.stockExplorerLabel,
                      onPressed: () {},
                      icon: Icons.inventory,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
