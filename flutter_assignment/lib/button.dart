import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final Color borderColor;

  const CustomButton({
    @required this.onPressed,
    this.backgroundColor = Colors.white,
    this.borderColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(20),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          primary: backgroundColor,
          side: BorderSide(
            width: 1,
            color: borderColor,
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(50)),
          ),
        ),
        onPressed: onPressed,
        child: const Text('Apply New Text'),
      ),
    );
  }
}
