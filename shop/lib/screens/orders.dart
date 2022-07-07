import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/order.dart';
import '../widgets/app_drawer.dart';
import '../widgets/order_list_item.dart';

class OrdersScreen extends StatelessWidget {
  static String routeName = '/orders';
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<Order>(context);
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text('orders'),
      ),
      body: ListView.builder(
        itemCount: orders.count,
        itemBuilder: (context, index) {
          return OrderListItem(
            order: orders.orders[index],
          );
        },
      ),
    );
  }
}
