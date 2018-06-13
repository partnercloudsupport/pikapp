import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'home.dart';
import 'locale/localizations.dart';

class App extends StatelessWidget {
  static final List<LocalizationsDelegate> localizationsDelegates = [
    AppLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  static final List<Locale> supportedLocales = [
    Locale('it'),
    Locale('en'),
  ];

  static Locale localeResolutionCallback(
      Locale locale, Iterable<Locale> supportedLocales) {
    for (Locale supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode ||
          supportedLocale.countryCode == locale.countryCode) {
        return supportedLocale;
      }
    }
    return supportedLocales.first;
  }

  static String onGenerateTitle(BuildContext context) =>
      AppLocalizations.of(context).translate('title');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      localizationsDelegates: localizationsDelegates,
      localeResolutionCallback: localeResolutionCallback,
      onGenerateTitle: onGenerateTitle,
      supportedLocales: supportedLocales,
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
    );
  }
}
