import 'package:ag_keyboard/src/modules/keyboard/keyboard.view.dart';
import 'package:flutter/material.dart';
import '../../../localization/loalization.dart';
import '../../../theme/themes/themes.dart';
import '../../router/provider/route.provider.dart';
import '../../setting/view/setting.view.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            style: roundedButtonStyle,
            onPressed: () async => await fadePush(
              context,
              const SettingView(),
            ),
            child: Text(t!.setting),
          ),
          ElevatedButton(
            style: roundedButtonStyle,
            onPressed: () async =>
                await fadePush(context, const KeyboardView()),
            child: const Text('Test Keyboard'),
          ),
        ],
      )),
    );
  }
}
