import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptiveButton extends StatelessWidget {
  final Function onPress;
  final String title;

  const AdaptiveButton({
    Key? key,
    required this.onPress,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            onPressed: () => onPress(),
            child: Text(
              title,
              style: const TextStyle(color: Colors.blue),
            ))
        : OutlinedButton(
            onPressed: () => onPress(),
            style: OutlinedButton.styleFrom(
              primary: Theme.of(context).errorColor,
              side: BorderSide(
                color: Theme.of(context).errorColor,
                width: 0.2,
              ),
            ),
            child: Text(title),
          );
  }
}
