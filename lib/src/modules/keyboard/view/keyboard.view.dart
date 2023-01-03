import 'package:ag_keyboard/src/modules/keyboard/provider/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'ag.keyboard.dart';

class KeyboardView extends ConsumerWidget {
  KeyboardView({super.key});
  final FocusNode _focusNode1 = FocusNode();
  final Color agLight = const Color(0xff37B2F3);
  final Color agDark = const Color(0xff226DC6);
  final bool isKeyboardVisible = false;
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //!removing this line sometime occurs error
    // bool shouldRecalculate = ref.watch(shouldRecalculateProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Keyboard View'),
      ),
      body: Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Form(
                  key: ref.watch(formKeyProvider),
                  child: TextFormField(
                    focusNode: _focusNode1,
                    controller: _controller,
                    validator: (value) {
                      return AgKeyboard.checkExpression(value);
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.none,
                    showCursor: true,
                    style: Theme.of(context).textTheme.headlineMedium,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), hintText: ''),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                  },
                  child: const Text('Close keyboard'),
                ),
              ],
            ),
          ),
          AgKeyboard(
            focusNode: _focusNode1,
            controller: _controller,
            backgroundColor: agLight,
            digitColor: agDark,
            operatorColor: Colors.black.withOpacity(0.4),
            resultColor: Colors.black.withOpacity(0.7),
          ),
        ],
      ),
    );
  }
}
