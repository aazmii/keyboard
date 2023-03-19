import 'package:flutter/material.dart'
    show BuildContext, Key, MaterialApp, MediaQuery, Widget;
import 'package:flutter_gen/gen_l10n/app_localizations.dart'
    show AppLocalizations;
import 'package:flutter_riverpod/flutter_riverpod.dart'
    show ConsumerWidget, WidgetRef;

import 'constants/constants.dart' show appName;
import 'localization/loalization.dart'
    show localizationsDelegates, onGenerateTitle, supportedLocales, t;
import 'modules/router/view/router.dart' show AppRouter;
import 'theme/model/theme.model.dart' show ThemeProfileExtension;
import 'theme/provider/theme.provider.dart' show themeProvider;
import 'utils/extensions/extensions.dart';

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      localizationsDelegates: localizationsDelegates,
      theme: ref.watch(themeProvider).theme,
      supportedLocales: supportedLocales,
      debugShowCheckedModeBanner: false,
      onGenerateTitle: onGenerateTitle,
      restorationScopeId: appName,
      home: const AppRouter(),
      builder: (context, child) {
        t = AppLocalizations.of(context);
        return MediaQuery(
          data: context.mediaQuery.copyWith(
            textScaleFactor: 1.0,
            devicePixelRatio: 1.0,
          ),
          child: child!,
        );
      },
    );
  }
}
