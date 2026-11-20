import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

/// Локальные напоминания о событиях партий.
///
/// Всё оффлайн: система планирует уведомления на устройстве.
/// На Android 13+ требуется разрешение на уведомления, на 12+ — на точные
/// будильники; если точные недоступны, планируем неточные (напоминание
/// может прийти с задержкой, но придёт).
class NotificationService {
  NotificationService();

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  bool _ready = false;
  bool _exactAllowed = false;

  static const _channelId = 'process_reminders';
  static const _channelName = 'Напоминания о процессах';
  static const _channelDescription =
      'Замеры, перегонки, взбалтывание настоек, доливка бочек';

  bool get isReady => _ready;
  bool get exactAllowed => _exactAllowed;

  Future<void> init() async {
    if (_ready) return;
    tzdata.initializeTimeZones();
    try {
      final name = await FlutterTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(name.identifier));
    } catch (_) {
      // Если не удалось определить зону — остаёмся на UTC, время уведомлений
      // сместится, но приложение продолжит работать.
    }

    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const darwin = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    await _plugin.initialize(
      settings: const InitializationSettings(android: android, iOS: darwin),
    );

    final androidImpl = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    if (androidImpl != null) {
      await androidImpl.requestNotificationsPermission();
      // Точные будильники НЕ запрашиваем на старте: системный экран
      // «Будильники и напоминания» перекрывает приложение. Проверяем молча,
      // а разрешение предлагаем запросить из настроек.
      _exactAllowed =
          await androidImpl.canScheduleExactNotifications() ?? false;
    }
    _ready = true;
  }

  Future<void> scheduleForEvent({
    required int id,
    required String title,
    required String body,
    required DateTime when,
    String? payload,
  }) async {
    if (!_ready) return;
    if (when.isBefore(DateTime.now())) return;

    final details = NotificationDetails(
      android: const AndroidNotificationDetails(
        _channelId,
        _channelName,
        channelDescription: _channelDescription,
        importance: Importance.high,
        priority: Priority.high,
      ),
      iOS: const DarwinNotificationDetails(),
    );

    try {
      await _plugin.zonedSchedule(
        id: id,
        scheduledDate: tz.TZDateTime.from(when, tz.local),
        notificationDetails: details,
        androidScheduleMode: _exactAllowed
            ? AndroidScheduleMode.exactAllowWhileIdle
            : AndroidScheduleMode.inexactAllowWhileIdle,
        title: title,
        body: body,
        payload: payload,
      );
    } catch (e) {
      debugPrint('Не удалось запланировать уведомление: $e');
    }
  }

  /// Запросить разрешение на точные будильники (открывает системный экран).
  /// Вызывать только по явному действию пользователя из настроек.
  Future<bool> requestExactAlarms() async {
    final androidImpl = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    if (androidImpl == null) return false;
    final granted = await androidImpl.requestExactAlarmsPermission() ?? false;
    _exactAllowed = granted;
    return granted;
  }

  Future<void> cancel(int id) async {
    if (!_ready) return;
    await _plugin.cancel(id: id);
  }

  Future<void> cancelAll() async {
    if (!_ready) return;
    await _plugin.cancelAll();
  }

  /// Показать уведомление сразу — для проверки настроек.
  Future<void> showNow({required String title, required String body}) async {
    if (!_ready) return;
    await _plugin.show(
      id: 999999,
      title: title,
      body: body,
      notificationDetails: const NotificationDetails(
        android: AndroidNotificationDetails(
          _channelId,
          _channelName,
          channelDescription: _channelDescription,
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
    );
  }
}
