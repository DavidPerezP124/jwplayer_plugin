import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jwplayer/jwplayer_method_channel.dart';

void main() {
  MethodChannelJwplayer platform = MethodChannelJwplayer();
  const MethodChannel channel = MethodChannel('jwplayer');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
