import 'package:flutter/material.dart';
import 'custom_keyboard.dart';

class KeyboardView extends StatelessWidget {
  KeyboardView({super.key});
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();
  final Color agLight = const Color(0xff37B2F3);
  final Color agDark = const Color(0xff226DC6);
  final bool isKeyboardVisible = false;

  @override
  Widget build(BuildContext context) {
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
                  controller: _controller1,
                  keyboardType: TextInputType.none,
                  style: Theme.of(context).textTheme.headlineMedium,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: 'Textfield 1'),
                ),
                const SizedBox(height: 10),
                TextField(
                  focusNode: _focusNode2,
                  controller: _controller2,
                  keyboardType: TextInputType.none,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: 'Textfield 2'),
                ),
                ElevatedButton(
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                  },
                  child: const Text('Unfocus Textfields'),
                ),
              ],
            ),
          ),
          CustomKeyboard(
            focusNode: _focusNode1,
            textController: _controller1,
            backgroundColor: agDark,
            buttonColor: agLight,
            operatorColor: Colors.teal,
          ),
        ],
      ),
    );
  }
}
