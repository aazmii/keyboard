import 'package:ag_keyboard/src/localization/app_localizations.dart' show AppLocalizations;
import 'package:flutter/material.dart' show BuildContext, Locale;

import 'package:flutter_localizations/flutter_localizations.dart'
    show GlobalCupertinoLocalizations, GlobalMaterialLocalizations, GlobalWidgetsLocalizations;

AppLocalizations? t;

const localizationsDelegates = [
  AppLocalizations.delegate,
  GlobalMaterialLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate,
];

const supportedLocales = [Locale('en', '')];

String onGenerateTitle(BuildContext context) => AppLocalizations.of(context)!.appTitle;
