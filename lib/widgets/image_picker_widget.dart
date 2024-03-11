import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImagePickerWidget extends StatelessWidget {
  final Function(File) onImageSelected;

  const ImagePickerWidget({Key? key, required this.onImageSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () async {
            final pickedFile =
            await ImagePicker().getImage(source: ImageSource.gallery);

            if (pickedFile != null) {
              onImageSelected(File(pickedFile.path));
            } else {
              print('No image selected.');
            }
          },
          icon: Icon(Icons.photo),
          iconSize: 50,
        ),
        SizedBox(width: 10),
        IconButton(
          onPressed: () async {
            final pickedFile =
            await ImagePicker().getImage(source: ImageSource.camera);

            if (pickedFile != null) {
              onImageSelected(File(pickedFile.path));
            } else {
              print('No photo taken.');
            }
          },
          icon: Icon(Icons.camera_alt),
          iconSize: 50,
        ),
      ],
    );
  }
}
