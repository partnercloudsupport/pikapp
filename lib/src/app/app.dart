import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:pikapp/src/analytics.dart';
import 'package:pikapp/src/messaging.dart';

import 'home.dart';
import 'locale/localizations.dart';

class App extends StatelessWidget {
  App() {
    messaging.configure(
      onMessage: (Map<String, dynamic> message) {
        debugPrint("onMessage: $message");
      },
      onLaunch: (Map<String, dynamic> message) {
        debugPrint("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) {
        debugPrint("onResume: $message");
      },
    );
  }

  static final List<LocalizationsDelegate> localizationsDelegates = [
    AppLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  static final navigatorObservers = [analyticsObserver];

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
      navigatorObservers: navigatorObservers,
      onGenerateTitle: onGenerateTitle,
      supportedLocales: supportedLocales,
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
    );
  }
}
