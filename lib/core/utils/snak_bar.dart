import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whats_app/core/helper/print.dart';

void showSnakBar({required BuildContext context, required String content}) {
  Print.printError(content);
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      elevation: 10.0,
      backgroundColor: Theme.of(context).colorScheme.error,
      behavior: SnackBarBehavior.floating,
      content: Text(
        content,
        style: Theme.of(context).textTheme.bodySmall!.copyWith(
              fontWeight: FontWeight.normal,
            ),
      ),
    ),
  );
}

Future<File?> getLostData(BuildContext context) async {
  File? image;
  try {
    final response = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (response != null) {
      image = File(response.path);
      return image;
    }
  } catch (e) {
    showSnakBar(context: context, content: e.toString());
  }
  return image;
}
