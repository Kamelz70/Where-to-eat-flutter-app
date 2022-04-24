import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class ImageInput extends StatefulWidget {
  final Function onSelectImage;
  // ignore: use_key_in_widget_constructors
  const ImageInput(this.onSelectImage);
  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  // ignore: avoid_init_to_null, prefer_final_fields
  File? _storedImage = null;

  Future<void> _takePicture() async {
    final picker = ImagePicker();

    final imageFile = await picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
    if (imageFile == null) {
      return;
    }
    setState(() {
      _storedImage = File(imageFile.path);
    });
    //get the appdata directory
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    //name it with the base name
    final fileName = path.basename(imageFile.path);
    final savedImage = await _storedImage!.copy('${appDir.path}/$fileName');
    widget.onSelectImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton.icon(
          icon: const Icon(Icons.camera_alt),
          label: const Text('Take Picture'),
          onPressed: _takePicture,
        ),
        SizedBox(
          height: 100,
          child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              itemBuilder: (ctx, index) {
                return Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                  ),
                  alignment: Alignment.center,
                  child: _storedImage != null
                      ? Image.file(
                          _storedImage as File,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        )
                      : const Text(
                          'No Image Loaded',
                          textAlign: TextAlign.center,
                        ),
                );
              }),
        ),
      ],
    );
  }
}
