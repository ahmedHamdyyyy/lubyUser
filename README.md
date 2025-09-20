# luby2

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Feature: View Property Location

When browsing a property, tapping the address text or the "View Location on Map" row in the property details screen opens a dedicated map screen (`PropertyLocationView`) showing the property's latitude/longitude with a marker.

Implementation notes:
- Address coordinates come from the backend (`address.latitude`, `address.longitude`).
- Navigation is triggered via `Navigator.of(context).push(PropertyLocationView.route(...))`.
- The map uses `google_maps_flutter` with a simplified style and a single marker.

If the coordinates are `0,0` the navigation is ignored (no map push) to avoid showing an invalid location.
