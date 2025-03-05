import 'package:app/common/injection.dart';
import 'package:app/result/result_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';

import 'common/theme.dart';
import 'home/home_page.dart';

void main() {
  configureDependencies();
  runApp(const MyApp());
}

final _router = GoRouter(
  initialLocation: HomePage.name,
  routes: [
    GoRoute(
      path: HomePage.name,
      name: HomePage.name,
      builder: (context, state) => HomePage(),
    ),
    GoRoute(
      path: ResultPage.name,
      name: ResultPage.name,
      builder:
          (context, state) => ResultPage(imageUrl: state.extra!.toString()),
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp.router(
    onGenerateTitle: (context) => AppLocalizations.of(context)!.appName,
    theme: appTheme,
    localizationsDelegates: const [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: const [Locale('en'), Locale('tr')],
    routerConfig: _router,
  );
}
