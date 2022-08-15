import UIKit
import Flutter
import JWPlayerKit

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
      JWPlayerKitLicense.setLicenseKey("")
      weak var registrar = self.registrar(forPlugin: "plugin-name")
      // TODO: Create API for setting this on Flutter side.
      JWPlayerKitLicense.setLicenseKey("XESWDHH3RTkYqna+1TNpjWbJpQIES/MRY9CoJvIxVYL795nYoVE4w8yJX4Xq80rF9CJ28CgxKKB2ZEv7")
      let factory = JWPlayerFactory(messenger: registrar!.messenger())
      self.registrar(forPlugin: "<plugin-name>")!.register(
                  factory,
                  withId: "<platform-view-type>")
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
