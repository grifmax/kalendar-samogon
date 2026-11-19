import 'package:cupertino_ui/cupertino_ui.dart' show GlobalCupertinoLocalizations;
import 'package:flutter_localizations/flutter_localizations.dart'
    show GlobalWidgetsLocalizations;
import 'package:material_ui/material_ui.dart';

import 'app/app_theme.dart';
import 'app/home_shell.dart';

void main() {
  runApp(const KalendarSamogonApp());
}

/// Точка входа приложения «Календарь самогонщика».
///
/// Сейчас — каркас M0: тема, русская локаль и нижняя навигация с заглушками.
/// Наполнение экранов появится на этапе M1 (см. docs/ROADMAP.md).
class KalendarSamogonApp extends StatelessWidget {
  const KalendarSamogonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Календарь самогонщика',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.dark,
      locale: const Locale('ru'),
      supportedLocales: const [Locale('ru')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: const HomeShell(),
    );
  }
}
