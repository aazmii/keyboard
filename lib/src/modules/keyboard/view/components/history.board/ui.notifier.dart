import 'package:flutter/material.dart';

Future<void> notifyUser(BuildContext context, String msg) async {
  final snackbar = SnackBar(
    content: Text(msg),
    duration: const Duration(milliseconds: 1200),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackbar);
}
