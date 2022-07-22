import 'package:flutter/material.dart';
import 'package:places/widgets/image_input.dart';

class AddPlaceScreen extends StatefulWidget {
  static const String routeName = '/add-place';

  const AddPlaceScreen({Key? key}) : super(key: key);

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void _handleTapAddProduct() {}
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a new place'),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
                child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(label: Text('some')),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    child: const Text(''),
                  ),
                  const ImageInput(),
                ],
              ),
            )),
            ElevatedButton.icon(
              icon: const Icon(Icons.add),
              label: const Text('Add'),
              onPressed: _handleTapAddProduct,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(10),
                shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                elevation: 0,
                primary: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
