import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}

Future<List<File>> pickImages() async {
  List<File> images = [];
  try {
    var res = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
    );
    if (res != null && res.files.isNotEmpty) {
      for (int i = 0; i < res.files.length; i++) {
        images.add(File(res.files[i].path!));
      }
    }
  } catch (e) {
    (e.toString());
    //showSnackBar(context, e.toString());
  }
  return images;
}
