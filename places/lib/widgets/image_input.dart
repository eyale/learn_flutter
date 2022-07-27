import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspath;

class ImageInput extends StatefulWidget {
  Function handleSelectImage;

  ImageInput({
    Key? key,
    required this.handleSelectImage,
  }) : super(key: key);

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  final ImagePicker picker = ImagePicker();
  File? storedImage;

  void _selectImage({required String filePath}) async {
    final appDir = await syspath.getApplicationDocumentsDirectory();
    final fileName = path.basename(filePath);
    final savedImage = await storedImage?.copy('${appDir.path}/$fileName');

    widget.handleSelectImage(savedImage);
  }

  Future _handleTapTakePhoto() async {
    final imageFile = await picker.pickImage(
        source: ImageSource.camera, maxHeight: 600, maxWidth: 600);

    if (imageFile != null) {
      setState(() {
        storedImage = File(imageFile.path);
      });

      _selectImage(filePath: imageFile.path);
    }
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
