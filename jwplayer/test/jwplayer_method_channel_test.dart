import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jwplayer/mobile/jwplayer_method_channel.dart';

void main() {
  MethodChannelJWPlayer platform = MethodChannelJWPlayer();
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
