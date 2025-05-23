import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'key.press.provider.dart';
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
final expressionProvider = StateProvider<String>((ref) => '');

final formKeyProvider = StateProvider<GlobalKey<FormState>>((ref) {
  final formKey = GlobalKey<FormState>();
  return formKey;
});

final keyPressProvider =
    NotifierProvider<KeyPressProvider, KeyPressProvider>(KeyPressProvider.new);

final historyViewProvider = StateProvider<bool>((ref) => false);

final historyProvider = StateProvider<List<String>>((ref) => []);

final buttonColorProvider = StateProvider<Color>((ref) => Colors.blue);
final operatorColorProvider = StateProvider<Color>((ref) => Colors.blue);
final pointColorProvider = StateProvider<Color>((ref) => Colors.blue);
final equelColorProvider = StateProvider<Color>((ref) => Colors.blue);
final backColorProvider = StateProvider<Color>((ref) => Colors.blue);

final alphabetSizeProvider = StateProvider.autoDispose<double>((ref) => 10);
