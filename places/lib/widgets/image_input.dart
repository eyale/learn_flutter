import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({Key? key}) : super(key: key);

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  final ImagePicker picker = ImagePicker();
  File? storedImage;

  Future _handleTapTakePhoto() async {
    final imageFile = await picker.pickImage(
        source: ImageSource.camera, maxHeight: 600, maxWidth: 600);
    debugPrint('📁 imageFile: ${imageFile!.path}');
    setState(() {
      storedImage = File(imageFile.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 150,
          height: 110,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
          ),
          child: storedImage == null
              ? const Icon(
                  Icons.dangerous,
                  color: Colors.amber,
                  size: 80,
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.file(
                    storedImage!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: OutlinedButton.icon(
              icon: const Icon(Icons.camera),
              onPressed: _handleTapTakePhoto,
              label: const Text('Take photo'),
            ),
          ),
        ),
      ],
    );
  }
}
