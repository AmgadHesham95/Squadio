import 'package:flutter/material.dart';

class ErrorLoadingMessageWidget extends StatelessWidget {
  const ErrorLoadingMessageWidget(
      {Key? key, required this.textColor, required this.iconColor})
      : super(key: key);

  final Color textColor;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.error,
          color: iconColor,
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          'Error loading image',
          style: TextStyle(color: textColor),
        ),
      ],
    );
  }
}
