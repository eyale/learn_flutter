import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product.dart';
import '../providers/products_provider.dart';

class EditProductsScreen extends StatefulWidget {
  static String routeName = '/edit_products';

  const EditProductsScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<EditProductsScreen> createState() => _EditProductsScreenState();
}

class _EditProductsScreenState extends State<EditProductsScreen> {
  final _imageUrlController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var _isLoading = false;
  var _editedProduct = Product(
      id: DateTime.now().toString(),
      title: '',
      description: '',
      price: 0,
      imageUrl: '');

  var _initFormValues = {
    'title': '',
    'description': '',
    'price': '',
    'imageUrl': '',
  };
  var _isInit = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_isInit) return;

    final productId = ModalRoute.of(context)?.settings.arguments as String?;
    if (productId == null) return;

    _editedProduct =
        Provider.of<Products>(context, listen: false).getBy(id: productId);
    _initFormValues = {
      'title': _editedProduct.title,
      'description': _editedProduct.description,
      'price': _editedProduct.price.toString(),
      'imageUrl': '',
    };

    _imageUrlController.text = _editedProduct.imageUrl;

    _isInit = false;
  }

  void _onSave() async {
    setState(() {
      _isLoading = !_isLoading;
    });

    final productsProvider = Provider.of<Products>(context, listen: false);
    final isValid = _formKey.currentState!.validate();

    if (!isValid) return;

    final isInProductsAlready = productsProvider.items
        .where((element) => element.id == _editedProduct.id);

    if (isInProductsAlready.isNotEmpty) {
      await productsProvider.update(
        byId: _editedProduct.id,
        withNewProduct: _editedProduct,
      );
    } else {
      try {
        await productsProvider.add(_editedProduct);
      } catch (_) {
        await showErrorDialog();
      }
    }

    setState(() {
      _isLoading = !_isLoading;
    });
    Navigator.of(context).pop();
  }

  Future<void> showErrorDialog() {
    return showDialog<void>(
        context: context,
        builder: (localContext) {
          return CupertinoAlertDialog(
            title: const Text('Server error 📵'),
            content: const Text('Something went wrong'),
            actions: [
              CupertinoButton(
                  child: const Text('Back'),
                  onPressed: () {
                    Navigator.of(localContext).pop();
                  })
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit'),
        actions: [
          IconButton(
            onPressed: _onSave,
            icon: const Icon(CupertinoIcons.floppy_disk),
          )
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    reverse: true,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: TextFormField(
                            initialValue: _initFormValues['title'],
                            decoration:
                                const InputDecoration(label: Text('Title:')),
                            textInputAction: TextInputAction.next,
                            autofocus: true,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please provide a title';
                              }
                              return null;
                            },
                            onChanged: (newVal) {
                              _editedProduct =
                                  _editedProduct.copyWith(title: newVal);
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: TextFormField(
                            initialValue: _initFormValues['description'],
                            decoration: const InputDecoration(
                                label: Text('Description:')),
                            maxLines: 3,
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please provide description';
                              }
                              return null;
                            },
                            onChanged: (newVal) {
                              _editedProduct =
                                  _editedProduct.copyWith(description: newVal);
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: TextFormField(
                            initialValue: _initFormValues['price'],
                            decoration:
                                const InputDecoration(label: Text('Price:')),
                            keyboardType: TextInputType.datetime,
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please provide price';
                              }
                              if (double.tryParse(value) == null) {
                                return 'Please enter valid number for price';
                              }
                              if (double.parse(value) <= 0) {
                                return 'Please enter price greater than 0';
                              }
                              return null;
                            },
                            onChanged: (newVal) {
                              if (double.tryParse(newVal) == null) return;
                              _editedProduct = _editedProduct.copyWith(
                                  price: double.parse(newVal));
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(right: 10),
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1, color: Colors.grey)),
                                child: _imageUrlController.text.isEmpty
                                    ? const Icon(CupertinoIcons.xmark)
                                    : SizedBox(
                                        width: 100,
                                        height: 100,
                                        child: Image.network(
                                          _imageUrlController.text,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                              ),
                              Expanded(
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    label: const Text('Image URL:'),
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        _imageUrlController.clear();
                                      },
                                      icon: const Icon(CupertinoIcons.clear),
                                    ),
                                  ),
                                  keyboardType: TextInputType.url,
                                  textInputAction: TextInputAction.done,
                                  controller: _imageUrlController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please provide Image URL';
                                    }
                                    if ((!value.startsWith('http') &&
                                            !value.startsWith('https')) ||
                                        (!value.endsWith('.png') &&
                                            !value.endsWith('.jpg') &&
                                            !value.endsWith('.jpeg'))) {
                                      return 'Please provide valid URL';
                                    }
                                    return null;
                                  },
                                  onFieldSubmitted: (_) {
                                    _onSave();
                                  },
                                  onSaved: (newVal) {
                                    _editedProduct = _editedProduct.copyWith(
                                        imageUrl: newVal);
                                  },
                                  onChanged: (newValue) {
                                    if (newValue.isEmpty ||
                                        (!newValue.startsWith('http') &&
                                            !newValue.startsWith('https')) ||
                                        (!newValue.endsWith('.png') &&
                                            !newValue.endsWith('.jpg') &&
                                            !newValue.endsWith('.jpeg'))) {
                                      return;
                                    }
                                    setState(() {
                                      _editedProduct = _editedProduct.copyWith(
                                          imageUrl: newValue);
                                    });
                                  },
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
