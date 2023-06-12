import 'package:fleetime_genshin/common/providers/multi_bloc_providers.dart';
import 'package:fleetime_genshin/common/router/router_config.dart';
import 'package:fleetime_genshin/theme/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppProviders(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        restorationScopeId: 'app',
        routerConfig: routerSettings,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', ''), // English, no country code
        ],
        theme: GenshinThemeData.lightMode,
        darkTheme: GenshinThemeData.darkMode,
        themeMode: ThemeMode.system,
        onGenerateTitle: (BuildContext context) =>
            AppLocalizations.of(context)!.appTitle,
      ),
    );
  }
}
