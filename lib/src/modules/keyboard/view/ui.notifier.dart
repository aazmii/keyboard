import 'package:flutter/material.dart';

Future<void> showSnackbar(BuildContext context, String msg) async {
  final snackbar = SnackBar(
    content: Text(msg),
    duration: const Duration(milliseconds: 1500),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackbar);
}
