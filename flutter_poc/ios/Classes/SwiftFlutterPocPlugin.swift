import Flutter
import UIKit
import JWPlayerKit

fileprivate enum Methods: String {
  case getPlatformVersion
  case play
}

public class SwiftFlutterPocPlugin:  NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_poc", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterPocPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    print(call.method)
    guard let method = Methods(rawValue: call.method) else {
      result(FlutterMethodNotImplemented)
      return
    }
    switch method {
    case .getPlatformVersion:
        result("iOS ")
       // JWPlayerViewController()
    case .play:
      print("play")
      result("play")
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}
