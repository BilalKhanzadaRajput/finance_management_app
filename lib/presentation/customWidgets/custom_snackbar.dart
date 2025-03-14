import 'package:flutter/material.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

// Function to show a custom Snackbar
void showCustomSnackbar(BuildContext context, String title, String message, ContentType contentType) {
  final snackBar = SnackBar(
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    content: AwesomeSnackbarContent(
      title: title,
      message: message,
      contentType: contentType,
    ),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
