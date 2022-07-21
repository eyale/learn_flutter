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

class _OrderListItemState extends State<OrderListItem>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  final _animationDuration = const Duration(milliseconds: 200);

  void handleTapExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: _animationDuration,
      height:
          _isExpanded ? min(widget.order.products.length * 30 + 100, 200) : 90,
      child: Card(
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
            // if (_isExpanded)
            AnimatedContainer(
              curve: Curves.linear,
              duration: _animationDuration,
              height:
                  _isExpanded ? min(widget.order.products.length * 40, 100) : 0,
              child: ListView(
                  children: widget.order.products.map((item) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 20,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            item.title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                '${item.quantity} x ',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              Text(
                                item.price.toString(),
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
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
            ),
          ],
        ),
      ),
    );
  }
}
