import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../provider/calculation.provider.dart';
import 'ag.keyboard.dart';

class KeyboardView extends ConsumerWidget {
  KeyboardView({super.key});
  final FocusNode _focusNode1 = FocusNode();
  final Color agLight = const Color(0xff37B2F3);
  final Color agDark = const Color(0xff226DC6);
  final bool isKeyboardVisible = false;
  // final _controller = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //!removing this line gives error, god knows why
    bool shouldRecalculate = ref.watch(shouldRecalculateProvider);
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
                TextField(
                  focusNode: _focusNode1,
                  // controller: _controller,

                  controller: ref.watch(controllerProvier),
                  keyboardType: TextInputType.none,
                  style: Theme.of(context).textTheme.headlineMedium,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: ''),
                ),
                const SizedBox(height: 20),
                Text(ref.watch(displayTextProvider)),
                ElevatedButton(
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    // ref.read(displayTextProvider.notifier).state += 'o';
                  },
                  child: const Text('Close keyboard'),
                ),
              ],
            ),
          ),
          AgKeyboard(
            focusNode: _focusNode1,
            textController: ref.watch(controllerProvier),
            // textController: _controller,
            backgroundColor: agDark,
            digitColor: agLight,
            operatorColor: Colors.black.withOpacity(0.4),
            resultColor: Colors.black.withOpacity(0.7),
          ),
        ],
      ),
    );
  }
}
