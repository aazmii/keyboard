// import 'package:flutter/material.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'dart:async';
//* KEPT AS REFFERENCE FOR DIFFERENT APPROACH
// class RawKeyboardListenerWidget extends StatefulWidget {
//   const RawKeyboardListenerWidget({super.key});
//   @override
//   _RawKeyboardListenerState createState() => _RawKeyboardListenerState();
// }

// class _RawKeyboardListenerState extends State {
//   final TextEditingController _controller = TextEditingController();
//   final FocusNode _textNode = FocusNode();
//   @override
//   initState() {
//     super.initState();
//   }

//   //Handle when submitting
//   void _handleSubmitted(String finalinput) {
//     setState(() {
//       SystemChannels.textInput
//           .invokeMethod('TextInput.hide'); //hide keyboard again
//       _controller.clear();
//     });
//   }

//   handleKey(RawKeyEventData key) {
//     print(key);
//     String _keyCode;
//     _keyCode = key.keyLabel.toString(); //keycode of key event (66 is return)
//   }

//   _buildTextComposer() {
//     TextField _textField = TextField(
//       decoration: const InputDecoration(hintText: "Enter name"),
//       controller: _controller,
//       onSubmitted: _handleSubmitted,
//     );
//     FocusScope.of(context).requestFocus(_textNode);
//     return RawKeyboardListener(
//         focusNode: _textNode,
//         // onKey: (key) => handleKey(key.data),
//         onKey: (value) {
//           if (value.isKeyPressed(LogicalKeyboardKey.enter)) {
//             print('enter');
//           }
//         },
//         child: Center(
//             child: Padding(
//           padding: const EdgeInsets.all(15.0),
//           child: _textField,
//         )));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("RowKeyBoard example"),
//       ),
//       body: _buildTextComposer(),
//     );
//   }
// }
