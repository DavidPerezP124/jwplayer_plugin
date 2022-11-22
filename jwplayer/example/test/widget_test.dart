import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jwplayer/jwplayer.dart';

import 'package:jwplayer_example/main.dart';

void main() {
  testWidgets('Verify Platform version', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const App());
    // Verify that platform version is retrieved.
    expect(
      find.byWidgetPredicate(
        (Widget widget) =>
            widget is Text && widget.data!.startsWith('Player version:'),
      ),
      findsOneWidget,
    );
  });

  testWidgets('Verify controller', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const App());
    // Verify that platform version is retrieved.
    expect(
      find.byWidgetPredicate(
        (Widget widget) =>
            widget is JWVideoPlayer && (widget.controller!.textureId == -1),
      ),
      findsOneWidget,
    );
  });
}
