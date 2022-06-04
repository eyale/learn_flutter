import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final Function handlePress;
  final Color backgroundColor;
  final Color titleColor;

  CustomButton({
    this.title,
    this.handlePress,
    this.backgroundColor = Colors.blueGrey,
    this.titleColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(5),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: backgroundColor,
          onPrimary: titleColor,
        ),
        onPressed: handlePress,
        child: Text(title),
      ),
    );
  }
}
