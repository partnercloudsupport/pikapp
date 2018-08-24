import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:pikapp/locale/localizations.dart';
import 'package:pikapp/services/firebase/analytics.dart';

import 'home.dart';

class App extends StatelessWidget {
  const App({@required this.theme});

  static final List<LocalizationsDelegate> localizationsDelegates = [
    AppLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  static final List<NavigatorObserver> navigatorObservers = [analyticsObserver];

  static final List<Locale> supportedLocales = [
    const Locale('it'),
    const Locale('en'),
  ];

  static Locale localeResolutionCallback(
      Locale locale, Iterable<Locale> supportedLocales) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return supportedLocale;
      }
    }
    return supportedLocales.first;
  }

  static String onGenerateTitle(BuildContext context) =>
      AppLocalizations.of(context).translate('title');

  final ThemeData theme;

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AppHome(),
        localizationsDelegates: localizationsDelegates,
        localeResolutionCallback: localeResolutionCallback,
        navigatorObservers: navigatorObservers,
        onGenerateTitle: onGenerateTitle,
        supportedLocales: supportedLocales,
        theme: theme,
      );
}
