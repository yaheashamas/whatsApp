import 'package:flutter/material.dart';

void showSnakBar({required BuildContext context, required String content}) {
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
