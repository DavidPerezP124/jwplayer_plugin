import 'dart:html' as html;

// ignore_for_file: avoid_classes_with_only_static_members
// ignore_for_file: camel_case_types

class platformViewRegistry {
  static bool registerViewFactory(
      String viewTypeId, html.Element Function(int viewId) viewFactory) {
    return false;
  }
}
