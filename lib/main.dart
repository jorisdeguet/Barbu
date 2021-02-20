import 'package:barbu/i18n/intl_delegate.dart';
import 'package:barbu/players.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';

// TODO https://www.youtube.com/watch?v=futE-2pAE30

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        const SeedyLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en'),
        const Locale('fr'),
      ],
      localeResolutionCallback: (Locale locale, Iterable<Locale> supportedLocales) {
        if (locale == null) return supportedLocales.first;
        for (Locale supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
      title: 'Barbu',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: PlayersScreen(title: 'Flutter Demo Home Page'),
    );
  }
}

