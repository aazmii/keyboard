// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//* KEPT AS A DIFFERENT APPROACH
// class AgTextField extends EditableText {
//   AgTextField({
//     super.key,
//     required TextEditingController controller,
//     required TextStyle style,
//     void Function(String)? onChanged,
//     Color cursorColor = Colors.black,
//     bool autofocus = false,
//     Color selectionColor = Colors.black,
//   }) : super(
//           controller: controller,
//           focusNode: TextfieldFocusNode(),
//           style: style,
//           cursorColor: cursorColor,
//           autofocus: autofocus,
//           selectionColor: selectionColor,
//           backgroundCursorColor: Colors.black,
//           onChanged: onChanged,
//         );

//   @override
//   EditableTextState createState() {
//     return TextFieldEditableState();
//   }
// }

// //hide keyboard when user tap on textfield.
// class TextFieldEditableState extends EditableTextState {
//   @override
//   void requestKeyboard() {
//     super.requestKeyboard();
//     //hide keyboard
//     SystemChannels.textInput.invokeMethod('TextInput.hide');
//   }
// }

// // hides keyboard from showing on first focus / autofocus
// class TextfieldFocusNode extends FocusNode {
//   @override
//   bool consumeKeyboardToken() {
//     return false;
//   }

//   static FocusNode get focusNode => TextfieldFocusNode();
// }
