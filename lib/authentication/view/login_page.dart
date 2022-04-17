import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../../routes.dart';
import '../widgets/widgets.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  children: const [
                    CustomTextField(
                      label: LoginPageConstants.emailTextFieldLabel,
                    ),
                    CustomTextField(
                      label: LoginPageConstants.passTextFieldLabel,
                      obscureText: true,
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    // TODO
                    onPressed: () {},
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
                      // TODO
                      onPressed: () =>
                          Navigator.popAndPushNamed(context, Routes.signupPage),
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
