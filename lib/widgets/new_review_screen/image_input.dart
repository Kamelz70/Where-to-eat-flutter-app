import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:provider/provider.dart';

import '../../providers/new_review_provider.dart';

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

  Future<void> _takePicture(NewReviewProvider newReviewProvider) async {
    final picker = ImagePicker();

    final imageFile = await picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
    if (imageFile == null) {
      return;
    }
    newReviewProvider.addImage(File(imageFile.path));
    //get the appdata directory
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    //name it with the base name
    final fileName = path.basename(imageFile.path);
    final savedImage = await _storedImage!.copy('${appDir.path}/$fileName');
    widget.onSelectImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    final newReviewProvider = Provider.of<NewReviewProvider>(context);
    return Column(
      children: [
        TextButton.icon(
            icon: const Icon(Icons.camera_alt),
            label: const Text('Take Picture'),
            onPressed: () {
              _takePicture(newReviewProvider);
            }),
        SizedBox(
          height: 100,
          child: Consumer<NewReviewProvider>(
            builder: (_, newReviewProvider, ch) => ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: newReviewProvider.imageList.length,
                itemBuilder: (ctx, index) {
                  return Container(
                      width: 150,
                      height: 150,
                      margin: EdgeInsets.only(right: 10),
                      alignment: Alignment.center,
                      child: Stack(children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(
                            newReviewProvider.imageList[index] as File,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                        Positioned(
                          child: CircleAvatar(
                            backgroundColor: Color.fromRGBO(220, 220, 220, 0.6),
                            radius: 20,
                            child: IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  newReviewProvider.removeImage(index);
                                },
                                color: Colors.red),
                          ),
                          top: 3,
                          right: 2,
                        )
                      ]));
                }),
          ),
        ),
      ],
    );
  }
}
