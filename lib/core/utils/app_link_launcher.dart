import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

Future<bool> _launchUri(Uri uri) async {
  try {
    if (!await canLaunchUrl(uri)) return false;
    return await launchUrl(uri, mode: LaunchMode.externalApplication);
  } catch (e) {
    if (kDebugMode) {
      // ignore: avoid_print
      print('Failed to launch $uri: $e');
    }
    return false;
  }
}

// Open a specific screen in the vendor app (Loby)
Future<bool> openVendorReservation(String id) => _launchUri(Uri(scheme: 'loby', host: 'app', pathSegments: ['open', 'reservation', id]));
Future<bool> openVendorActivity(String id) => _launchUri(Uri(scheme: 'loby', host: 'app', pathSegments: ['open', 'activity', id]));
Future<bool> openVendorProperty(String id) => _launchUri(Uri(scheme: 'loby', host: 'app', pathSegments: ['open', 'property', id]));
