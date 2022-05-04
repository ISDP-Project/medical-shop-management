import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy_app/authentication/bloc/authentication_bloc.dart';

import '../../constants/constants.dart';
import '../widgets/widgets.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(
            left: kDefaultPadding * 4,
            right: kDefaultPadding * 4,
            top: kDefaultPadding * 4,
          ),
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Text(
                      LoginPageConstants.heading,
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    const Padding(padding: EdgeInsets.all(kDefaultPadding)),
                    Text(
                      LoginPageConstants.subheading,
                      style: Theme.of(context).textTheme.bodyText2,
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    BlocBuilder<AuthenticationBloc, AuthenticationState>(
                        builder: (context, state) {
                      if (state.showError ?? false) {
                        return Text(
                          LoginPageConstants.errorMessage,
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: Theme.of(context).colorScheme.error,
                                  ),
                        );
                      }
                      return const SizedBox();
                    }),
                    CustomTextField(
                      label: LoginPageConstants.emailTextFieldLabel,
                      controller: _emailController,
                      textInputType: TextInputType.emailAddress,
                    ),
                    const Padding(
                        padding: EdgeInsets.only(top: kDefaultPadding)),
                    CustomTextField(
                      label: LoginPageConstants.passTextFieldLabel,
                      controller: _passwordController,
                      obscureText: true,
                      textInputType: TextInputType.visiblePassword,
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<AuthenticationRepository>().logIn(
                            email: _emailController.text,
                            password: _passwordController.text,
                          );
                    },
                    child: Text(
                      LoginPageConstants.buttonText,
                      style: Theme.of(context).textTheme.button!.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      LoginPageConstants.signupText,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    TextButton(
                      onPressed: () {
                        context
                            .read<AuthenticationBloc>()
                            .add(AuthenticationTypeChangeRequested());
                      },
                      child: Text(
                        LoginPageConstants.signupButtonText,
                        style: Theme.of(context).textTheme.button,
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/background.png"),
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
