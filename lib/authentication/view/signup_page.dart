import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy_app/authentication/bloc/authentication_bloc.dart';

import '../widgets/widgets.dart';
import '../../constants/constants.dart';

class SignupPage extends StatelessWidget {
  SignupPage({Key? key}) : super(key: key);

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneNoController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _pharmacyNameController = TextEditingController();
  final TextEditingController _pharmacyGstinController =
      TextEditingController();
  final TextEditingController _pharmacyAddressController =
      TextEditingController();
  final TextEditingController _pharmacyCityController = TextEditingController();
  final TextEditingController _pharmacyPinCodeController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).backgroundColor,
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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Text(
                      SignupPageConstants.heading,
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    const Padding(padding: EdgeInsets.all(kDefaultPadding)),
                    Text(
                      SignupPageConstants.subheading,
                      style: Theme.of(context).textTheme.bodyText2,
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 5,
                child: Column(
                  children: [
                    BlocBuilder<AuthenticationBloc, AuthenticationState>(
                        builder: (context, state) {
                      if (state.showError ?? false) {
                        return Text(
                          SignupPageConstants.errorMessage,
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: Theme.of(context).colorScheme.error,
                                  ),
                        );
                      }
                      return const SizedBox();
                    }),
                    Expanded(
                      child: Container(
                        margin:
                            const EdgeInsets.only(bottom: kDefaultMargin * 2),
                        child: ListView(
                          physics: const BouncingScrollPhysics(),
                          children: [
                            CustomTextField(
                              label:
                                  SignupPageConstants.firstNameTextFieldLabel,
                              controller: _firstNameController,
                              textInputType: TextInputType.name,
                            ),
                            const Padding(
                                padding: EdgeInsets.only(top: kDefaultPadding)),
                            CustomTextField(
                              label: SignupPageConstants.lastNameTextFieldLabel,
                              controller: _lastNameController,
                              textInputType: TextInputType.name,
                            ),
                            const Padding(
                                padding: EdgeInsets.only(top: kDefaultPadding)),
                            CustomTextField(
                              label: SignupPageConstants.phoneTextFieldLabel,
                              controller: _phoneNoController,
                              textInputType: TextInputType.phone,
                            ),
                            const Padding(
                                padding: EdgeInsets.only(top: kDefaultPadding)),
                            CustomTextField(
                              label: SignupPageConstants.emailTextFieldLabel,
                              controller: _emailController,
                              textInputType: TextInputType.emailAddress,
                            ),
                            const Padding(
                                padding: EdgeInsets.only(top: kDefaultPadding)),
                            CustomTextField(
                              label: SignupPageConstants.passTextFieldLabel,
                              controller: _passwordController,
                              obscureText: true,
                            ),
                            const Padding(
                                padding: EdgeInsets.only(top: kDefaultPadding)),
                            CustomTextField(
                              label: SignupPageConstants.pharmacyNameLabel,
                              controller: _pharmacyNameController,
                              textInputType: TextInputType.name,
                            ),
                            const Padding(
                                padding: EdgeInsets.only(top: kDefaultPadding)),
                            CustomTextField(
                              label: SignupPageConstants.pharmacyGstin,
                              controller: _pharmacyGstinController,
                              textInputType: TextInputType.visiblePassword,
                            ),
                            const Padding(
                                padding: EdgeInsets.only(top: kDefaultPadding)),
                            CustomTextField(
                              label: SignupPageConstants.pharmacyAddress,
                              controller: _pharmacyAddressController,
                              textInputType: TextInputType.streetAddress,
                            ),
                            const Padding(
                                padding: EdgeInsets.only(top: kDefaultPadding)),
                            CustomTextField(
                              label: SignupPageConstants.pharmacyCity,
                              controller: _pharmacyCityController,
                              textInputType: TextInputType.name,
                            ),
                            const Padding(
                                padding: EdgeInsets.only(top: kDefaultPadding)),
                            CustomTextField(
                              label: SignupPageConstants.pharmacyPinCode,
                              controller: _pharmacyPinCodeController,
                              textInputType: TextInputType.number,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<AuthenticationRepository>().signUp(
                            email: _emailController.text,
                            password: _passwordController.text,
                            firstName: _firstNameController.text,
                            lastName: _lastNameController.text,
                            phoneNo: _phoneNoController.text,
                            pharmacyName: _pharmacyNameController.text,
                            pharmacyGstin: _pharmacyGstinController.text,
                            pharmacyAddress: _pharmacyAddressController.text,
                            pharmacyCity: _pharmacyCityController.text,
                            pharmacyPinCode: _pharmacyPinCodeController.text,
                          );
                    },
                    child: Text(
                      SignupPageConstants.buttonText,
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
                      SignupPageConstants.loginText,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    TextButton(
                      onPressed: () {
                        context
                            .read<AuthenticationBloc>()
                            .add(AuthenticationTypeChangeRequested());
                      },
                      child: Text(
                        SignupPageConstants.loginButtonText,
                        style: Theme.of(context).textTheme.button,
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 2,
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
