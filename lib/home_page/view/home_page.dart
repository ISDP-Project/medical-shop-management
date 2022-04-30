import 'package:flutter/material.dart'
    show
        AppBar,
        BoxDecoration,
        BuildContext,
        ButtonStyle,
        Center,
        Column,
        Container,
        Drawer,
        DrawerHeader,
        ElevatedButton,
        Key,
        ListTile,
        ListView,
        MainAxisSize,
        Navigator,
        SafeArea,
        Scaffold,
        SizedBox,
        StatelessWidget,
        Text,
        TextStyle,
        Widget;

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../authentication/authentication.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  get pageOptions => null;

  get selectedMenuItem => null;

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            const DrawerHeader(
              child: Text(HomePageConstants.drawerHeading),
              decoration: BoxDecoration(),
            ),
            ListTile(
              title: const Text(HomePageConstants.home),
              onTap: () {
                Navigator.of(context);
                // ignore: unnecessary_new

                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text(HomePageConstants.notification),
              onTap: () {
                Navigator.of(context);
                // ignore: unnecessary_new

                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text(HomePageConstants.setting),
              onTap: () {
                Navigator.of(context);
                // ignore: unnecessary_new

                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text(HomePageConstants.payment),
              onTap: () {
                Navigator.of(context);
                // ignore: unnecessary_new

                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text(HomePageConstants.user),
              onTap: () {
                Navigator.of(context);
                // ignore: unnecessary_new

                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text(HomePageConstants.help),
              onTap: () {
                Navigator.of(context);
                // ignore: unnecessary_new

                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            if (state is AuthenticationStateAuthenticated) {
              return Center(
                child:
                    Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 20)),
                    onPressed: () {},
                    child: const Text(HomePageConstants.billingpage),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 20)),
                    onPressed: () {},
                    child: const Text(HomePageConstants.scan),
                  ),
                ]),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
