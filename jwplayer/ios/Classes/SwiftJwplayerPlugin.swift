import Flutter
import UIKit
import JWPlayerKit

fileprivate enum Methods: String {
    case getPlatformVersion
    case play
    case create
    case `init`
}

public class SwiftJwplayerPlugin:  NSObject, FlutterPlugin {
    var currentId = 0

    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "jwplayer", binaryMessenger: registrar.messenger())
        let instance = SwiftJwplayerPlugin()
        // TODO: Create API for setting this on Flutter side.
        JWPlayerKitLicense.setLicenseKey("XESWDHH3RTkYqna+1TNpjWbJpQIES/MRY9CoJvIxVYL795nYoVE4w8yJX4Xq80rF9CJ28CgxKKB2ZEv7")
        let factory = JWPlayerFactory(messenger: registrar.messenger())
        registrar.register(
            factory,
            withId: "<platform-view-type>")
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        print(call.method)
        guard let method = Methods(rawValue: call.method) else {
            result(FlutterMethodNotImplemented)
            return
        }

        switch method {
        case .create:
            result(currentId)
        case .`init`:
            result("init")
        case .getPlatformVersion:
            result(JWPlayerKit.sdkVersion)
        case .play:
            print("play")
            result("play")
        default:
            result(FlutterMethodNotImplemented)
        }
    }
}
