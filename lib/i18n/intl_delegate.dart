import 'dart:async';

import 'package:flutter/material.dart';

import 'intl_localization.dart';

class BarbuLocalizationsDelegate extends LocalizationsDelegate<Locs> {
  const BarbuLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['fr', 'en'].contains(locale.languageCode);

  @override
  Future<Locs> load(Locale locale) async {
    Locs localizations = new Locs(locale);
    await localizations.load();

    print("Load ${locale.languageCode}");

    return localizations;
  }

  @override
  bool shouldReload(BarbuLocalizationsDelegate old) => false;
}