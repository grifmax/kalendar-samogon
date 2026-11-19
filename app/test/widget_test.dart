import 'package:flutter_test/flutter_test.dart';

import 'package:kalendar_samogon/main.dart';

void main() {
  testWidgets('Каркас запускается и показывает пять разделов', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const KalendarSamogonApp());
    await tester.pumpAndSettle();

    // Заголовок первого экрана и его пустое состояние.
    expect(find.text('Сегодня'), findsWidgets);
    expect(find.text('Здесь будут задачи на день'), findsOneWidget);

    // Нижняя навигация: все пять разделов на месте.
    expect(find.text('Календарь'), findsOneWidget);
    expect(find.text('Партии'), findsOneWidget);
    expect(find.text('Рецепты'), findsOneWidget);
    expect(find.text('Ещё'), findsOneWidget);
  });

  testWidgets('Переключение на раздел «Ещё» показывает список функций', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const KalendarSamogonApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Ещё'));
    await tester.pumpAndSettle();

    expect(find.text('Калькуляторы'), findsOneWidget);
    expect(find.text('Склад и погреб'), findsOneWidget);
  });
}
