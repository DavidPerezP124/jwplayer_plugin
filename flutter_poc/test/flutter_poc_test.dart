import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_poc/flutter_poc.dart';
import 'package:flutter_poc/flutter_poc_platform_interface.dart';
import 'package:flutter_poc/flutter_poc_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterPocPlatform 
    with MockPlatformInterfaceMixin
    implements FlutterPocPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterPocPlatform initialPlatform = FlutterPocPlatform.instance;

  test('$MethodChannelFlutterPoc is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterPoc>());
  });

  test('getPlatformVersion', () async {
    FlutterPoc flutterPocPlugin = FlutterPoc();
    MockFlutterPocPlatform fakePlatform = MockFlutterPocPlatform();
    FlutterPocPlatform.instance = fakePlatform;
  
    expect(await flutterPocPlugin.getPlatformVersion(), '42');
  });
}
