import 'package:flutter/material.dart';

class NoTransactions extends StatelessWidget {
  const NoTransactions({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (layoutContext, constraints) {
        return Column(
          children: [
            Text(
              'no transactions yet',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: constraints.maxHeight * 0.6,
              child: Image.asset(
                'assets/images/no-sign-sign-of.png',
                fit: BoxFit.cover,
              ),
            )
          ],
        );
      },
    );
  }
}
