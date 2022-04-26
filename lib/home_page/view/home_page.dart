import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../authentication/authentication.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            if (state is AuthenticationStateAuthenticated) {
              return Text(
                  '${state.user?.name} owns the ${state.user?.pharmacyName}');
            }

            return Container();
          },
        ),
      ),
    );
  }
}
