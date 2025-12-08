import 'package:flutter/material.dart';
import 'package:luby2/core/localization/l10n_ext.dart';

class Utils {
  static void errorDialog(BuildContext context, String error, {void Function()? onPressed}) => showDialog(
    context: context,
    builder:
        (context) => Dialog(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(error),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(onPressed: () => Navigator.pop(context), child: Text(context.l10n.dismiss)),
                    TextButton(onPressed: onPressed, child: Text(context.l10n.retry)),
                  ],
                ),
              ],
            ),
          ),
        ),
  );

  static int calculateDaysDifference(String? startDate, String? endDate) {
    if (startDate == null || endDate == null) return 0;
    final start = DateTime.parse(startDate);
    final end = DateTime.parse(endDate);
    return end.difference(start).inDays.abs();
  }

  static Future<T?> loadingDialog<T>(
    BuildContext context, {
    String message = 'Loading...',
    bool barrierDismissible = false,
    Color? accentColor,
    bool showProgress = true,
    Duration? autoDismissDuration,
  }) => showDialog<T>(
    context: context,
    barrierDismissible: barrierDismissible,
    barrierColor: Colors.black54,
    builder:
        (context) => PopScope(
          canPop: barrierDismissible,
          child: _ModernLoadingDialog(
            message: message,
            accentColor: accentColor,
            showProgress: showProgress,
            autoDismissDuration: autoDismissDuration,
          ),
        ),
  );
  static String getMimeType(String path) {
    final ext = path.split('.').last.toLowerCase();
    switch (ext) {
      case 'jpg':
      case 'jpeg':
        return 'image/jpeg';
      case 'png':
        return 'image/png';
      case 'pdf':
        return 'application/pdf';
      default:
        return 'application/octet-stream'; // fallback
    }
  }
}

// Modern Loading Dialog Widget
class _ModernLoadingDialog extends StatefulWidget {
  final String message;
  final Color? accentColor;
  final bool showProgress;
  final Duration? autoDismissDuration;

  const _ModernLoadingDialog({required this.message, this.accentColor, this.showProgress = true, this.autoDismissDuration});

  @override
  State<_ModernLoadingDialog> createState() => _ModernLoadingDialogState();
}

class _ModernLoadingDialogState extends State<_ModernLoadingDialog> with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _rotateController;
  late Animation<double> _pulseAnimation;
  late Animation<double> _rotateAnimation;

  @override
  void initState() {
    super.initState();

    _pulseController = AnimationController(duration: const Duration(milliseconds: 1500), vsync: this);

    _rotateController = AnimationController(duration: const Duration(milliseconds: 2000), vsync: this);

    _pulseAnimation = Tween<double>(
      begin: 0.8,
      end: 1.2,
    ).animate(CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut));

    _rotateAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _rotateController, curve: Curves.linear));

    _pulseController.repeat(reverse: true);
    _rotateController.repeat();

    // Auto dismiss if duration is provided
    if (widget.autoDismissDuration != null) {
      Future.delayed(widget.autoDismissDuration!).then((_) {
        if (mounted && Navigator.canPop(context)) {
          Navigator.pop(context);
        }
      });
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _rotateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final accentColor = widget.accentColor ?? theme.colorScheme.primary;

    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 40),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(color: Colors.black.withAlpha(25), blurRadius: 20, offset: const Offset(0, 10), spreadRadius: 0),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Animated loading indicator
              if (widget.showProgress) ...[
                AnimatedBuilder(
                  animation: _pulseAnimation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _pulseAnimation.value,
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [accentColor.withAlpha(25), accentColor.withAlpha(75)],
                          ),
                        ),
                        child: Center(
                          child: AnimatedBuilder(
                            animation: _rotateAnimation,
                            builder: (context, child) {
                              return Transform.rotate(
                                angle: _rotateAnimation.value * 2 * 3.14159,
                                child: Icon(Icons.refresh_rounded, color: accentColor, size: 40),
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 24),
              ],

              // Message text with modern typography
              Text(
                widget.message,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.onSurface,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.2,
                ),
                textAlign: TextAlign.center,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),

              // Subtle progress dots
              if (widget.showProgress) ...[
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(3, (index) {
                    return AnimatedBuilder(
                      animation: _pulseController,
                      builder: (context, child) {
                        final delay = index * 0.2;
                        final animationValue = (_pulseController.value + delay) % 1.0;
                        final scale = 0.5 + (0.5 * animationValue);

                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: 8 * scale,
                          height: 8 * scale,
                          decoration: BoxDecoration(color: accentColor.withAlpha(150), shape: BoxShape.circle),
                        );
                      },
                    );
                  }),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
