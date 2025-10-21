import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../core/localization/l10n_ext.dart';

// NOTE: This screen intentionally mirrors the styling concepts from the vendor
// app's LocationConfirmationScreen (stack layout, center marker hint, bottom
// information panel) but is read-only for end users.

/// Displays a read-only map with a marker at the property's location.
/// Expects latitude, longitude, and address to be passed in.
class PropertyLocationView extends StatefulWidget {
  const PropertyLocationView({super.key, required this.latitude, required this.longitude, required this.address});

  final double latitude;
  final double longitude;
  final String address;

  static Route<void> route({required double latitude, required double longitude, required String address}) =>
      MaterialPageRoute(builder: (_) => PropertyLocationView(latitude: latitude, longitude: longitude, address: address));

  @override
  State<PropertyLocationView> createState() => _PropertyLocationViewState();
}

class _PropertyLocationViewState extends State<PropertyLocationView> {
  GoogleMapController? _mapController;
  late final LatLng _target;
  bool get _invalid => widget.latitude == 0 && widget.longitude == 0;

  /// Launches external Google Maps. Prefers geo: URI (Android) with fallback to
  /// universal https URL. If both fail, shows a SnackBar.
  Future<void> _openInGoogleMaps() async {
    if (_invalid) return;
    final lat = widget.latitude;
    final lng = widget.longitude;
    final label = widget.address.isEmpty ? context.l10n.propertyLocationLabel : widget.address;
    final encodedLabel = Uri.encodeComponent(label);

    // geo intent (preferred on Android). We try launching without pre-check to avoid false negatives.
    final geoUri = Uri.parse('geo:$lat,$lng?q=$lat,$lng($encodedLabel)');
    // Universal HTTPS fallback (works cross‑platform / browsers):
    final webUri = Uri.parse('https://www.google.com/maps/search/?api=1&query=$lat,$lng');

    bool opened = false;
    try {
      opened = await launchUrl(geoUri, mode: LaunchMode.externalApplication);
    } catch (_) {
      opened = false;
    }
    if (!opened) {
      try {
        opened = await launchUrl(webUri, mode: LaunchMode.externalApplication);
      } catch (_) {
        opened = false;
      }
    }
    if (!mounted) return;
    if (!opened) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(context.l10n.unableToOpenGoogleMaps)));
    }
  }

  @override
  void initState() {
    super.initState();
    _target = LatLng(widget.latitude, widget.longitude);
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    // Basic light style (kept minimal for parity without copying entire style JSON).
    // ignore: deprecated_member_use
    _mapController?.setMapStyle('[{"elementType":"geometry","stylers":[{"color":"#f5f5f5"}]}]');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Map or placeholder
          if (!_invalid)
            GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(target: _target, zoom: 15),
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
              mapToolbarEnabled: false,
              markers: {
                Marker(
                  markerId: const MarkerId('property_location'),
                  position: _target,
                  infoWindow: InfoWindow(title: widget.address),
                  icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
                ),
              },
            )
          else
            Container(
              color: Colors.grey.shade200,
              alignment: Alignment.center,
              child: Text(context.l10n.locationNotAvailable, style: const TextStyle(fontSize: 16, color: Colors.black54)),
            ),

          // Center marker indicator (shown only if valid)
          if (!_invalid)
            IgnorePointer(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.location_on, size: 48, color: Colors.redAccent),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [BoxShadow(color: Colors.black.withAlpha(25), blurRadius: 8, offset: const Offset(0, 2))],
                      ),
                      child: Text(
                        context.l10n.propertyLocationLabel,
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.black87),
                      ),
                    ),
                  ],
                ),
              ),
            ),

          // Bottom information panel
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(240),
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                boxShadow: [BoxShadow(color: Colors.black.withAlpha(25), blurRadius: 20, offset: const Offset(0, -5))],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.place, color: Colors.blueAccent, size: 28),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _invalid ? context.l10n.noCoordinatesProvided : widget.address,
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black87),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 6),
                            Text(
                              _invalid
                                  ? context.l10n.noMappedLocationYet
                                  : '${_target.latitude.toStringAsFixed(5)}, ${_target.longitude.toStringAsFixed(5)}',
                              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black54),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      if (!_invalid)
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: _openInGoogleMaps,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueAccent,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                            ),
                            icon: const Icon(Icons.map_outlined),
                            label: Text(context.l10n.openInGoogleMaps),
                          ),
                        ),
                      if (!_invalid) const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.of(context).pop(),
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                          ),
                          child: Text(context.l10n.commonClose),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Simple top-back button overlay
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 8, left: 8),
              child: ClipOval(
                child: Material(
                  color: Colors.white.withAlpha(225),
                  child: InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    child: const SizedBox(width: 42, height: 42, child: Icon(Icons.arrow_back, color: Colors.black87)),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
