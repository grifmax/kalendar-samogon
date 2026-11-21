import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../../app/app_version.dart';
import '../../widgets/form_fields.dart';

/// «О приложении»: версия, рейтинг 18+, политика конфиденциальности.
///
/// Политика лежит в ассетах (`assets/privacy.md`) — тот же текст, что
/// публикуется по ссылке в карточке магазина. Google Play проверяет оба места,
/// поэтому текст должен быть доступен и офлайн, без перехода в браузер.
class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  final Future<String> _privacy = rootBundle.loadString('assets/privacy.md');

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('О приложении')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
        children: [
          Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/logo_splash.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Календарь самогонщика',
                      style: theme.textTheme.titleMedium,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'версия $kAppVersion',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: FormSpacing.section),
          Card(
            margin: EdgeInsets.zero,
            color: theme.colorScheme.errorContainer.withValues(alpha: 0.35),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.warning_amber_rounded,
                    size: 20,
                    color: theme.colorScheme.error,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '18+',
                          style: theme.textTheme.titleSmall?.copyWith(
                            color: theme.colorScheme.error,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Приложение для совершеннолетних: рецепты и журнал '
                          'домашнего приготовления напитков. Оно не продаёт '
                          'алкоголь и не заменяет соблюдение закона. '
                          'Чрезмерное употребление алкоголя вредит здоровью.',
                          style: theme.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: FormSpacing.section),
          const FormSectionTitle(
            title: 'Политика конфиденциальности',
            hint: 'Данные не покидают устройство',
          ),
          FutureBuilder<String>(
            future: _privacy,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 24),
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              final text = snapshot.data;
              if (text == null) {
                return Text(
                  'Не удалось открыть текст политики.',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.error,
                  ),
                );
              }
              return Card(
                margin: EdgeInsets.zero,
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _renderMarkdown(text, theme),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

/// Простая разметка markdown в виджеты.
///
/// Полноценный парсер тут не нужен, но и сырой текст показывать нельзя: в
/// карточке политики видны «#», «**» и таблица с чертами. Поддерживаем то, что
/// реально есть в документе: заголовки, маркированные списки, абзацы и
/// выделение жирным.
List<Widget> _renderMarkdown(String text, ThemeData theme) {
  final widgets = <Widget>[];
  final body = theme.textTheme.bodySmall?.copyWith(height: 1.45);

  // В файле абзацы перенесены по 80 символов — такие переносы нельзя
  // показывать как есть: сначала склеиваем строки в блоки по пустым строкам.
  final blocks = <String>[];
  final buffer = <String>[];
  for (final raw in text.split('\n')) {
    final line = raw.trim();
    if (line.isEmpty) {
      if (buffer.isNotEmpty) {
        blocks.add(buffer.join(' '));
        buffer.clear();
      }
      continue;
    }
    final structural = line.startsWith('#') ||
        line.startsWith('- ') ||
        line.startsWith('* ') ||
        line.startsWith('> ') ||
        line.startsWith('|') ||
        line == '---';
    if (structural) {
      if (buffer.isNotEmpty) {
        blocks.add(buffer.join(' '));
        buffer.clear();
      }
      blocks.add(line);
    } else {
      buffer.add(line);
    }
  }
  if (buffer.isNotEmpty) blocks.add(buffer.join(' '));

  for (final line in blocks) {
    if (line.startsWith('|---') || line.startsWith('| ---')) continue;
    if (line.startsWith('|')) {
      final cells = line
          .split('|')
          .map((c) => c.trim())
          .where((c) => c.isNotEmpty)
          .toList();
      if (cells.isEmpty) continue;
      widgets.add(Padding(
        padding: const EdgeInsets.only(bottom: 4),
        child: Text('${cells.first}: ${cells.skip(1).join(' · ')}', style: body),
      ));
      continue;
    }
    if (line.startsWith('#')) {
      final title = _inline(line.replaceFirst(RegExp(r'^#+\s*'), ''));
      widgets.add(Padding(
        padding: EdgeInsets.only(top: widgets.isEmpty ? 0 : 14, bottom: 6),
        child: Text(
          title,
          style: theme.textTheme.titleSmall?.copyWith(
            color: theme.colorScheme.primary,
          ),
        ),
      ));
      continue;
    }
    if (line.startsWith('- ') || line.startsWith('* ')) {
      widgets.add(Padding(
        padding: const EdgeInsets.only(bottom: 4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('•  ', style: body),
            Expanded(child: Text(_inline(line.substring(2)), style: body)),
          ],
        ),
      ));
      continue;
    }
    if (line.startsWith('> ')) {
      widgets.add(Padding(
        padding: const EdgeInsets.only(bottom: 4),
        child: Text(
          _inline(line.substring(2)),
          style: body?.copyWith(fontStyle: FontStyle.italic),
        ),
      ));
      continue;
    }
    if (line == '---') {
      widgets.add(const Divider(height: 20));
      continue;
    }
    widgets.add(Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(_inline(line), style: body),
    ));
  }
  return widgets;
}

/// Убирает инлайн-разметку: `**жирный**`, `` `код` ``.
String _inline(String s) =>
    s.replaceAll('**', '').replaceAll('`', '').replaceAll('*', '');

/// Подпись под списком в «Ещё»: версия и рейтинг одной строкой.
String get aboutVersionLabel => 'Календарь самогонщика · версия $kAppVersion · 18+';
