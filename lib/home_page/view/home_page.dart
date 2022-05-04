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
      backgroundColor: Theme.of(context).backgroundColor,
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
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(HomePageConstants.logoUrl),
                      fit: BoxFit.cover)),
            ),
            // ListTile(
            //   leading: const Icon(Icons.home),
            //   title: const Text(HomePageConstants.home),
            //   onTap: () {
            //     Navigator.of(context).pushNamed(Routes.homePage);
            //     Navigator.pop(context);
            //   },
            // ),
            ListTile(
              leading: const Icon(Icons.analytics),
              title: const Text(HomePageConstants.analytics),
              onTap: () {
                Navigator.of(context).pushNamed(Routes.analyticPage);
              },
            ),
            ListTile(
              leading: const Icon(Icons.history),
              title: const Text(HomePageConstants.billHistory),
              onTap: () {
                Navigator.of(context).pushNamed(Routes.billHistory);
              },
            ),
            ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text(HomePageConstants.notification),
              onTap: () {
                Navigator.of(context).pushNamed(Routes.lowStockManagementPage);
              },
            ),
            ListTile(
              leading: const Icon(Icons.receipt_long_outlined),
              title: const Text(HomePageConstants.generateBill),
              onTap: () {
                Navigator.of(context).pushNamed(Routes.billPage);
              },
            ),
            ListTile(
              leading: const Icon(Icons.list),
              title: const Text(HomePageConstants.stockExplorer),
              onTap: () {
                Navigator.of(context).pushNamed(Routes.currentStock);
              },
            ),
            ListTile(
              leading: const Icon(Icons.qr_code),
              title: const Text(HomePageConstants.barcodeScanner),
              onTap: () {
                Navigator.of(context).pushNamed(Routes.scannerPage);
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text(HomePageConstants.user),
              onTap: () {
                Navigator.of(context).pushNamed(Routes.profilePage);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.logout,
                color: Theme.of(context).colorScheme.error,
              ),
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
          margin: const EdgeInsets.symmetric(horizontal: kDefaultMargin * 2),
          padding: const EdgeInsets.only(top: kDefaultPadding * 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Inventory',
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.headline2?.copyWith(
                      color: Theme.of(context).textTheme.headline1?.color,
                    ),
              ),
              Row(
                children: [
                  Expanded(
                      child: GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(Routes.currentStock);
                          },
                          child: Container(
                            height: 185,
                            child: Column(children: [
                              const Padding(
                                  padding: EdgeInsets.only(
                                      top: kDefaultPadding * 1.5)),
                              Container(
                                child: Text(
                                  'Stock Explorer',
                                  textAlign: TextAlign.left,
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                              ),
                              // ),
                              const Padding(
                                  padding: EdgeInsets.only(
                                      bottom: kDefaultPadding * 2)),
                              Container(
                                padding: EdgeInsets.only(left: 15, right: 15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Paracetamol',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2
                                          ?.copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          )
                                          .copyWith(
                                              fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '22',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2
                                          ?.copyWith(color: Color(0xFFFA8518))
                                          .copyWith(
                                              fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                              const Padding(
                                  padding: EdgeInsets.only(
                                      bottom: kDefaultPadding * 2)),
                              Container(
                                padding: EdgeInsets.only(left: 15, right: 15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Dolono',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2
                                          ?.copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          )
                                          .copyWith(
                                              fontWeight: FontWeight.bold),
                                    ),
                                    Text('65',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2
                                            ?.copyWith(color: Color(0xFFFA8518))
                                            .copyWith(
                                                fontWeight: FontWeight.bold))
                                  ],
                                ),
                              ),
                              const Padding(
                                  padding: EdgeInsets.only(
                                      bottom: kDefaultPadding * 2)),
                              Container(
                                padding: EdgeInsets.only(left: 15, right: 15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Aspirin',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2
                                          ?.copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          )
                                          .copyWith(
                                              fontWeight: FontWeight.bold),
                                    ),
                                    Text('14',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2
                                            ?.copyWith(color: Color(0xFFFA8518))
                                            .copyWith(
                                                fontWeight: FontWeight.bold))
                                  ],
                                ),
                              ),
                              const Padding(
                                  padding: EdgeInsets.only(
                                      bottom: kDefaultPadding * 2)),
                              Container(
                                padding: EdgeInsets.only(left: 15, right: 15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Easpirin',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2
                                          ?.copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          )
                                          .copyWith(
                                              fontWeight: FontWeight.bold),
                                    ),
                                    Text('10',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2
                                            ?.copyWith(color: Color(0xFFFA8518))
                                            .copyWith(
                                                fontWeight: FontWeight.bold))
                                  ],
                                ),
                              )
                            ]),
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                    color:
                                        Theme.of(context).colorScheme.outline)),
                          ))),
                  Expanded(
                      child: Container(
                    height: 185,
                    child: Column(children: [
                      const Padding(
                          padding:
                              EdgeInsets.only(bottom: kDefaultPadding * 2)),
                      Container(
                          child: Icon(
                        Icons.qr_code_scanner,
                        size: kDefaultIconSize * 4,
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withAlpha(200),
                      )),
                      Container(
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed(Routes.scannerPage);
                            },
                            child: Text("Scan")),
                        padding: EdgeInsets.only(bottom: kDefaultPadding * 1.5),
                      ),
                    ]),
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                          color: Theme.of(context).colorScheme.outline),
                    ),
                  ))
                ],
              ),
              const Padding(padding: EdgeInsets.only(top: kDefaultPadding * 2)),
              Text(
                'Bills',
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.headline2?.copyWith(
                      color: Theme.of(context).textTheme.headline1?.color,
                    ),
              ),
              Row(
                children: [
                  Expanded(
                      child: Container(
                    height: 160,
                    child: Column(children: [
                      const Padding(
                          padding:
                              EdgeInsets.only(bottom: kDefaultPadding * 2.5)),
                      Container(
                          child: Icon(
                        Icons.receipt_long_outlined,
                        size: kDefaultIconSize * 2,
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withAlpha(200),
                      )),
                      Padding(
                          padding:
                              EdgeInsets.only(bottom: kDefaultPadding * 2.5)),
                      Container(
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed(Routes.billPage);
                            },
                            child: Text("Generate Bill")),
                        padding: EdgeInsets.only(bottom: kDefaultPadding * 1.5),
                      ),
                    ]),
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                            color: Theme.of(context).colorScheme.outline)),
                  )),
                  Expanded(
                      child: Container(
                    height: 160,
                    child: Column(children: [
                      const Padding(
                          padding:
                              EdgeInsets.only(bottom: kDefaultPadding * 2.5)),
                      Container(
                          child: Icon(
                        Icons.history,
                        size: kDefaultIconSize * 2,
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withAlpha(200),
                      )),
                      Padding(
                          padding:
                              EdgeInsets.only(bottom: kDefaultPadding * 2.5)),
                      Container(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed(Routes.billHistory);
                          },
                          child: Text("Bill History"),
                        ),
                        padding: EdgeInsets.only(bottom: kDefaultPadding * 1.5),
                      ),
                    ]),
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                            color: Theme.of(context).colorScheme.outline)),
                  ))
                ],
              ),
              const Padding(padding: EdgeInsets.only(top: kDefaultPadding * 2)),
              Text(
                'Analytics',
                style: Theme.of(context).textTheme.headline2?.copyWith(
                      color: Theme.of(context).textTheme.headline1?.color,
                    ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/analytic_graph.jpeg'),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ],
          ),

          // child: Column(
          //   children: [
          //     Row(
          //       children: [
          //         Expanded(
          //           child: CustomButton(
          //             icon: Icons.qr_code_scanner_outlined,
          //             label: HomePageConstants.scanPageButtonLabel,
          //             onPressed: () =>
          //                 Navigator.pushNamed(context, Routes.scannerPage),
          //           ),
          //         ),
          //         const Padding(
          //           padding: EdgeInsets.symmetric(horizontal: kDefaultMargin),
          //         ),
          //         Expanded(
          //           child: CustomButton(
          //             icon: Icons.receipt_long_rounded,
          //             label: HomePageConstants.billiingPageButtonLabel,
          //             onPressed: () =>
          //                 Navigator.pushNamed(context, Routes.billPage),
          //           ),
          //         ),
          //       ],
          //     ),
          //     const Padding(padding: EdgeInsets.only(top: kDefaultPadding * 2)),
          //     Row(
          //       children: [
          //         Expanded(
          //           child: CustomButton(
          //             icon: Icons.notifications_active,
          //             label: HomePageConstants.lowStockPageLabel,
          //             onPressed: () => Navigator.pushNamed(
          //               context,
          //               Routes.lowStockManagementPage,
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ],
          // ),
        ),
      ),
    );
  }
}
