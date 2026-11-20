import 'package:flutter/material.dart';

/// Заставка на время старта: логотип и название приложения.
///
/// Показывается поверх первого кадра, пока [AppBoot] не отдаст управление
/// основному экрану. Нативная заставка Android/iOS показывает только значок
/// (система обрезает её по кругу и не даёт места под текст), поэтому название
/// выводится здесь — сразу после запуска движка.
class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 700),
  )..forward();

  late final Animation<double> _fade = CurvedAnimation(
    parent: _controller,
    curve: const Interval(0, 0.7, curve: Curves.easeOut),
  );

  late final Animation<double> _rise = Tween<double>(begin: 14, end: 0).animate(
    CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.15, 1, curve: Curves.easeOutCubic),
    ),
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          center: Alignment.center,
          radius: 0.95,
          colors: [Color(0xFF241A12), Color(0xFF14120F), Color(0xFF0C0A08)],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FadeTransition(
              opacity: _fade,
              child: Transform.translate(
                offset: Offset(0, _rise.value),
                child: SizedBox(
                  width: 176,
                  height: 176,
                  child: Image.asset(
                    'assets/images/logo_splash.png',
                    fit: BoxFit.contain,
                    filterQuality: FilterQuality.high,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 28),
            FadeTransition(
              opacity: _fade,
              child: Transform.translate(
                offset: Offset(0, _rise.value),
                child: Column(
                  children: [
                    Text(
                      'Календарь\nсамогонщика',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        height: 1.2,
                        letterSpacing: 0.2,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: 44,
                      height: 2,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary.withValues(alpha: 0.7),
                        borderRadius: BorderRadius.circular(1),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'браги · настойки · выдержка',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                        letterSpacing: 0.6,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
