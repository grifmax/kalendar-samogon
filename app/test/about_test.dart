import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kalendar_samogon/app/app_theme.dart';
import 'package:kalendar_samogon/features/about/about_screen.dart';

void main() {
  testWidgets('«О приложении»: версия, 18+ и политика', (tester) async {
    tester.view.physicalSize = const Size(420, 2600);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      MaterialApp(theme: AppTheme.dark, home: const AboutScreen()),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.text('Календарь самогонщика'), findsOneWidget);
    expect(find.textContaining('версия 0.'), findsOneWidget);
    expect(find.text('18+'), findsOneWidget);
    expect(find.textContaining('вредит здоровью'), findsOneWidget);

    // Текст политики подгрузился из ассетов.
    expect(find.textContaining('Политика конфиденциальности'), findsWidgets);
    expect(find.textContaining('не собирает'), findsOneWidget);
  });

  test('политика в приложении совпадает с публикуемой по смыслу', () {
    final appCopy = File('assets/privacy.md').readAsStringSync();
    final docCopy = File('../docs/PRIVACY.md').readAsStringSync();

    // Ключевые утверждения должны быть в обоих текстах: магазин проверяет
    // ссылку, а пользователь — раздел в приложении.
    for (final phrase in [
      'не собирает',
      'хранятся',
      '18+',
      'Удаление данных',
    ]) {
      expect(appCopy, contains(phrase), reason: 'в ассете нет «$phrase»');
      expect(docCopy, contains(phrase), reason: 'в docs нет «$phrase»');
    }
  });
}
