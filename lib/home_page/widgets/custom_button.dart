import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.icon,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  final IconData icon;
  final String label;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressed(),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          vertical: kDefaultPadding * 1.75,
        ),
      ),
      child: Column(
        children: [
          Icon(icon),
          const Padding(padding: EdgeInsets.only(top: kDefaultPadding * 1.25)),
          Text(label),
        ],
      ),
    );
  }
}
