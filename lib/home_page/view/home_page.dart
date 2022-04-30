import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/widgets.dart';
import '../../routes.dart';
import '../../authentication/authentication.dart';
import '../../constants/constants.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    log('built homepage');

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
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
          ],
        ),
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: kDefaultMargin * 1.25),
          padding: const EdgeInsets.only(top: kDefaultPadding),
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
            ],
          ),
        ),
      ),
    );
  }
}
