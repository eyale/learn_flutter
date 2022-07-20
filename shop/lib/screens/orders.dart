import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/order.dart';
import '../widgets/app_drawer.dart';
import '../widgets/order_list_item.dart';

class OrdersScreen extends StatefulWidget {
  static String routeName = '/orders';
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  late Future _ordersFuture;

  Future getOrdersFuture() {
    return Provider.of<Order>(context, listen: false).get();
  }

  @override
  void initState() {
    super.initState();
    _ordersFuture = getOrdersFuture();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text('orders'),
      ),
      body: SafeArea(
        child: FutureBuilder(
            future: _ordersFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.error != null) {
                return Center(child: Text(snapshot.error.toString()));
              }
              return Consumer<Order>(
                builder: (context, item, child) {
                  return ListView.builder(
                    itemCount: item.count,
                    itemBuilder: (context, index) {
                      return OrderListItem(
                        order: item.orders[index],
                      );
                    },
                  );
                },
              );
            }),
      ),
    );
  }
}
