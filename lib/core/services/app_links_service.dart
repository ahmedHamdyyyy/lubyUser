import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

/// Simple deep-link handler using the `app_links` plugin.
/// Target schemes: e.g., lubyuser://app/open/reservation/123
class AppLinksService {
  AppLinksService({
    required this.navigatorKey,
    required this.onRouteData,
    this.acceptedSchemes = const ['lubyuser', 'https'],
  });

  final GlobalKey<NavigatorState> navigatorKey;
  final void Function(Map<String, dynamic> data) onRouteData;
  final List<String> acceptedSchemes;

  AppLinks? _appLinks;
  StreamSubscription<Uri>? _sub;

  Future<void> init() async {
    try {
      _appLinks = AppLinks();

      // Handle an initial link if available
      try {
        final initial = await _appLinks!.getInitialLink();
        if (initial != null) {
          _handleUri(initial);
        }
      } catch (_) {}

      _sub = _appLinks!.uriLinkStream.listen(
        _handleUri,
        onError: (e, st) {
          if (kDebugMode) {
            // ignore: avoid_print
            print('AppLinks error: $e');
          }
        },
      );
    } catch (e) {
      if (kDebugMode) {
        // ignore: avoid_print
        print('Failed to initialize AppLinks: $e');
      }
    }
  }

  void dispose() {
    _sub?.cancel();
  }

  void _handleUri(Uri uri) {
    try {
      if (!acceptedSchemes.contains(uri.scheme)) return;
      final segments = uri.pathSegments;

      String? type;
      String? id;

      if (uri.scheme == 'https' && uri.host == 'dashboard.lubyksa.com') {
        // Handle https://dashboard.lubyksa.com/open/{type}/{id}
        if (segments.length >= 3 && segments[0] == 'open') {
          type = segments[1];
          id = segments[2];
        } else {
          return;
        }
      } else if (uri.scheme == 'lubyuser') {
        // Support both formats:
        // 1) lubyuser://open/{type}/{id}  => host == 'open', segments: [type, id]
        // 2) lubyuser://{anything}/open/{type}/{id} or lubyuser://open/{type}/{id} treated as path first segment
        if (uri.host == 'open') {
          if (segments.length < 2) return;
          type = segments[0];
          id = segments[1];
        } else if (segments.length >= 3 && segments[0] == 'open') {
          type = segments[1];
          id = segments[2];
        } else {
          return;
        }
      } else {
        return;
      }

      Map<String, dynamic> data;
      switch (type) {
        case 'reservation':
          data = {'type': 'new_registration', 'registrationId': id};
          break;
        case 'activity':
          data = {'type': 'new_activity', 'activityId': id};
          break;
        case 'property':
          data = {'type': 'new_property', 'propertyId': id};
          break;
        default:
          return;
      }

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (navigatorKey.currentState != null) {
          onRouteData(data);
        } else {
          Future.delayed(const Duration(milliseconds: 200), () {
            if (navigatorKey.currentState != null) onRouteData(data);
          });
        }
      });
    } catch (_) {
      // swallow
    }
  }
}
