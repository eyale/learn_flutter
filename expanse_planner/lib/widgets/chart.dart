import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
  const Chart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Text(
        'Chart',
        style: Theme.of(context).textTheme.headline1,
      ),
    );
  }
}
