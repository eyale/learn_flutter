import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';

class ProductDetailsScreen extends StatelessWidget {
  static String routeName = '/product-details';

  const ProductDetailsScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    final id = ModalRoute.of(context)?.settings.arguments as String;
    final product = Provider.of<Products>(
      context,
      listen: false,
    ).getBy(id: id);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(30)),
              child: Container(
                color: Colors.black38,
                child: IconButton(
                  color: Colors.white,
                  icon: const Icon(
                    Icons.chevron_left,
                    size: 40,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ),
            expandedHeight: _isPortrait ? 500 : 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.all(0),
              title: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: _isPortrait ? 50 : 100, vertical: 5),
                width: double.infinity,
                color: Colors.black38,
                child: SafeArea(child: Text(product.title)),
              ),
              background: Hero(
                tag: product.id,
                child: Image.network(
                  product.imageUrl,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                const SizedBox(height: 20),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: _isPortrait ? 20 : 60),
                  child: Text(
                    '\$${product.price}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: _isPortrait ? 20 : 60, vertical: 20),
                  child: SizedBox(
                    width: double.infinity,
                    child: Text(
                      product.description,
                      softWrap: true,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 100,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
