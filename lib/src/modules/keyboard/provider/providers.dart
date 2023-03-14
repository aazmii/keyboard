import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final formKeyProvider = StateProvider((_) => GlobalKey<FormState>());

// final controllerProvier = Provider.autoDispose<TextEditingController>((ref) {
//   final textController = TextEditingController();
//   ref.onDispose(() => textController.dispose());
//   return textController;
// });

final displayTextProvider = StateProvider.autoDispose((_) => '');

final shouldRecalculateProvider = StateProvider((_) => false);

final expressionProvider = StateProvider((_) => '');

final historyViewProvider = StateProvider((_) => false);

final historyProvider = StateProvider((_) => <String>[]);

// final buttonColorProvider = StateProvider<Color>((ref) => Colors.blue);
// final operatorColorProvider = StateProvider<Color>((ref) => Colors.blue);
// final pointColorProvider = StateProvider<Color>((ref) => Colors.blue);
// final equelColorProvider = StateProvider<Color>((ref) => Colors.blue);
// final backColorProvider = StateProvider<Color>((ref) => Colors.blue);

// final alphabetSizeProvider = StateProvider.autoDispose<double>((ref) => 10);
