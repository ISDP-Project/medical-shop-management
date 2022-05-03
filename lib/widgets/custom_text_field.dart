import 'package:flutter/material.dart';

import '../constants/constants.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.label,
    required this.controller,
    this.obscureText = false,
    this.textInputType = TextInputType.text,
  }) : super(key: key);

  final String label;
  final TextEditingController controller;
  final bool obscureText;
  final TextInputType textInputType;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(
            top: kDefaultPadding,
            bottom: kDefaultPadding * 0.5,
          ),
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ),
        TextFormField(
          obscureText: obscureText,
          style: Theme.of(context).textTheme.bodyText1,
          controller: controller,
          autocorrect: false,
          keyboardType: textInputType,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: kDefaultPadding,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.outline,
              ),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.outline,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
