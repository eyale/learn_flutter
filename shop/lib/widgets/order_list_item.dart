import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../providers/order.dart' as OrderProviderItem;

class OrderListItem extends StatefulWidget {
  final OrderProviderItem.OrderItem order;
  const OrderListItem({Key? key, required this.order}) : super(key: key);

  @override
  State<OrderListItem> createState() => _OrderListItemState();
}

class _OrderListItemState extends State<OrderListItem> {
  bool _isExpanded = false;

  void handleTapExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Column(
        children: [
          ListTile(
            title: Text(
              '\$${widget.order.amount}',
              style: const TextStyle(fontSize: 22),
            ),
            subtitle: Text(DateFormat('dd.MM.yyyy  -  hh:mm')
                .format(widget.order.dateTime)),
            trailing: IconButton(
              color: Theme.of(context).colorScheme.secondary,
              icon: Icon(_isExpanded
                  ? CupertinoIcons.chevron_up
                  : CupertinoIcons.chevron_down),
              onPressed: handleTapExpand,
            ),
            onTap: () {},
          ),
          if (_isExpanded)
            SizedBox(
              height: min(widget.order.products.length * 20 + 100, 100),
              child: ListView(
                  children: widget.order.products.map((item) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            item.title,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary),
                          ),
                          Row(
                            children: [
                              Text('${item.quantity} x ',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary)),
                              Text(
                                item.price.toString(),
                                style: TextStyle(
                                    fontSize: 16,
                                    color:
                                        Theme.of(context).colorScheme.primary),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    const Divider(),
                  ],
                );
              }).toList()),
            )
        ],
      ),
    );
  }
}
