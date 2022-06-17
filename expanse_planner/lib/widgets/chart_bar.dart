import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  const ChartBar({
    Key? key,
    required this.label,
    required this.amount,
    required this.percentFromTotal,
  }): super(key: key);

  final String label;
  final double amount;
  final double percentFromTotal;

  @override
  Widget build(BuildContext context) {
    print('📊 build Chart');
    return LayoutBuilder(
      builder: (layoutBuilderContext, constraints) {
        return Column(
          children: [
            SizedBox(
                height: constraints.maxHeight * 0.15,
                child:
                    FittedBox(child: Text('\$${amount.toStringAsFixed(1)}'))),
            SizedBox(
              height: constraints.maxHeight * 0.05,
            ),
            SizedBox(
              height: constraints.maxHeight * 0.6,
              width: 10,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.green, width: 1.0),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.pinkAccent,
                    ),
                  ),
                  FractionallySizedBox(
                    heightFactor: percentFromTotal,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: constraints.maxHeight * 0.05,
            ),
            SizedBox(
              height: constraints.maxHeight * 0.15,
              child: FittedBox(child: Text(label)),
            ),
          ],
        );
      },
    );
  }
}
