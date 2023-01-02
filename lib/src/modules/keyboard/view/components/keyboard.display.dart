import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class KeyboardDisplay extends ConsumerWidget {
  const KeyboardDisplay({
    super.key,
    required this.displayText,
  });

  final String displayText;

  @override
  Widget build(BuildContext context, ref) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: 70,
      width: double.infinity,
      color: Colors.black45,
      child: Align(
        alignment: Alignment.centerLeft,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Text(
            displayText,
            style: const TextStyle(fontSize: 32),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
