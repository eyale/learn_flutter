import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/transaction.dart';
import '../widgets/transactions_form.dart';
import '../widgets/transactions_list.dart';
import '../widgets/chart.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    print('🔔 didChangeAppLifecycleState 🔔: $state');
  }

  @override
  void dispose() {
    super.dispose();

    WidgetsBinding.instance.removeObserver(this);
  }

  final List<Transaction> _transactions = [];
  bool _isChartShow = true;

  void _addNewTransaction(String title, double amount, DateTime selectedDate) {
    final Transaction newTransaction = Transaction(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: selectedDate,
    );

    setState(() {
      _transactions.add(newTransaction);
    });
  }

  void _removeTransaction(String id) {
    setState(() {
      _transactions.removeWhere((element) => element.id == id);
    });
  }

  void _showBottomShit(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return TransactionsForm(onAddPress: _addNewTransaction);
      },
    );
  }

  void _toggleShowChart(bool isShow) {
    setState(() {
      _isChartShow = isShow;
    });
  }

  List<Transaction> get _recentTransactions {
    return _transactions.where((element) {
      return element.date
          .isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).toList();
  }

  List<Widget> _buildLandscapeContent({
    required MediaQueryData mq,
    required PreferredSizeWidget appBar,
    required Widget transactionsList,
  }) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Show chart: ',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Switch.adaptive(
              activeColor: Theme.of(context).primaryColor,
              value: _isChartShow,
              onChanged: _toggleShowChart),
        ],
      ),
      _isChartShow
          ? SizedBox(
              width: double.infinity,
              height: (mq.size.height -
                      appBar.preferredSize.height -
                      mq.padding.top) *
                  0.6,
              child: Chart(recentTransactions: _recentTransactions),
            )
          : transactionsList
    ];
  }

  List<Widget> _buildPortraitContent({
    required MediaQueryData mq,
    required PreferredSizeWidget appBar,
    required Widget transactionsList,
  }) {
    return [
      SizedBox(
        width: double.infinity,
        height:
            (mq.size.height - appBar.preferredSize.height - mq.padding.top) *
                0.4,
        child: Chart(recentTransactions: _recentTransactions),
      ),
      transactionsList
    ];
  }

  PreferredSizeWidget _buildAppBar() {
    return Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text(
              'Expanse Planner',
              style: TextStyle(color: Theme.of(context).primaryColorDark),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () => _showBottomShit(context),
                  child: Icon(
                    CupertinoIcons.add_circled,
                    color: Theme.of(context).primaryColor,
                  ),
                )
                // IconButton(
                //     onPressed: () => _showBottomShit(context),
                //     icon: const Icon(Icons.add))
              ],
            ),
          )
        : AppBar(
            title: const Text('Expanse Planner'),
            actions: <Widget>[
              IconButton(
                onPressed: () => _showBottomShit(context),
                icon: const Icon(Icons.add),
              ),
            ],
          ) as PreferredSizeWidget;
  }

  @override
  Widget build(BuildContext context) {
    print('🔁 build _MyHomePageState');
    final mq = MediaQuery.of(context);
    final isLandscape = mq.orientation == Orientation.landscape;

    final PreferredSizeWidget appBar = _buildAppBar();

    final transactionsList = SizedBox(
      height:
          (mq.size.height - appBar.preferredSize.height - mq.padding.top) * 0.8,
      child: TransactionsList(
          transactions: _transactions, removeTransaction: _removeTransaction),
    );

    final body = SafeArea(
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              if (isLandscape)
                ..._buildLandscapeContent(
                    mq: mq, appBar: appBar, transactionsList: transactionsList),
              if (!isLandscape)
                ..._buildPortraitContent(
                    mq: mq, appBar: appBar, transactionsList: transactionsList),
            ],
          ),
        ),
      ),
    );
    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: appBar as ObstructingPreferredSizeWidget,
            child: body,
          )
        : Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: IconButton(
                      onPressed: () => _showBottomShit(context),
                      icon: const Icon(Icons.add),
                    ),
                    onPressed: () => _showBottomShit(context),
                  ),
            appBar: appBar,
            body: body,
          );
  }
}
