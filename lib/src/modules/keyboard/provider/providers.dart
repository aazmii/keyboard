import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'result.provider.dart';

final controllerProvier = Provider.autoDispose<TextEditingController>((ref) {
  final textController = TextEditingController();
  ref.onDispose(() => textController.dispose());
  return textController;
});
final displayTextProvider = StateProvider.autoDispose<String>((ref) => '');

final shouldRecalculateProvider = StateProvider<bool>((ref) => false);

final resultProvider =
    NotifierProvider<ResultProvider, String>(ResultProvider.new);
