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
  bool _isLoading = false;

  void toggleIsLoadingState() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  Future getOrders() {
    toggleIsLoadingState();

    return Future.delayed(
      Duration.zero,
      () {
        Provider.of<Order>(context, listen: false)
            .get()
            .then((_) => toggleIsLoadingState());
      },
    );
  }

  @override
  void initState() {
    super.initState();
    getOrders();
  }

  @override
  Widget build(BuildContext context) {
    final ordersProvider = Provider.of<Order>(context);
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text('orders'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: ordersProvider.count,
              itemBuilder: (context, index) {
                return OrderListItem(
                  order: ordersProvider.orders[index],
                );
              },
            ),
    );
  }
}
