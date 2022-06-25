import 'package:flutter/material.dart';

import '../widgets/custom_drawer.dart';
import '../main.dart';

class FiltersScreen extends StatefulWidget {
  static String routeName = '/filters';

  Function saveFilters;
  FilterValues filters;

  FiltersScreen({
    Key? key,
    required this.saveFilters,
    required this.filters,
  }) : super(key: key);

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree = false;
  bool _vegeterian = false;
  bool _vegan = false;
  bool _lactoseFree = false;

  @override
  void initState() {
    super.initState();
    _glutenFree = widget.filters.glutenFree;
    _vegeterian = widget.filters.vegeterian;
    _vegan = widget.filters.vegan;
    _lactoseFree = widget.filters.lactoseFree;
  }

  void _handleGlutenFreeSwitcher(bool value) {
    setState(() {
      _glutenFree = value;
    });
  }

  void _handleVegeterianFreeSwitcher(bool value) {
    setState(() {
      _vegeterian = value;
    });
  }

  void _handleVeganSwitcher(bool value) {
    setState(() {
      _vegan = value;
    });
  }

  void _handleLactoseFreeSwitcher(bool value) {
    setState(() {
      _lactoseFree = value;
    });
  }

  SwitchListTile createSwitchRow({
    required BuildContext context,
    required Function handler,
    required bool value,
    required String title,
    required String subtitle,
  }) {
    return SwitchListTile(
      tileColor: Colors.black12,
      activeColor: Colors.indigo,
      value: value,
      onChanged: (val) => handler(val),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyText1,
      ),
      subtitle: Text(
        subtitle,
        style: Theme.of(context).textTheme.bodyText2,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        title: const Text('Filters'),
        actions: [
          IconButton(
              onPressed: () {
                FilterValues filters = FilterValues(
                  glutenFree: _glutenFree,
                  lactoseFree: _lactoseFree,
                  vegan: _vegan,
                  vegeterian: _vegeterian,
                );
                widget.saveFilters(filters);
              },
              icon: const Icon(Icons.save_as_outlined))
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Adjust meal\'s selection',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ),
          Expanded(
              child: ListView(
            children: [
              createSwitchRow(
                context: context,
                value: _glutenFree,
                handler: _handleGlutenFreeSwitcher,
                title: 'Is Gluten-free:',
                subtitle: 'Contains only gluten-free meals',
              ),
              createSwitchRow(
                context: context,
                value: _vegeterian,
                handler: _handleVegeterianFreeSwitcher,
                title: 'Is Vegeterian:',
                subtitle: 'Contains only vegeterian meals',
              ),
              createSwitchRow(
                context: context,
                value: _vegan,
                handler: _handleVeganSwitcher,
                title: 'Is Vegan free:',
                subtitle: 'Contains only vegan meals',
              ),
              createSwitchRow(
                context: context,
                value: _lactoseFree,
                handler: _handleLactoseFreeSwitcher,
                title: 'Is Lactose-free :',
                subtitle: 'Contains only lactose-free meals',
              ),
            ],
          ))
        ],
      ),
    );
  }
}
