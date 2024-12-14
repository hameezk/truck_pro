import Flutter
import UIKit
import GoogleMaps

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    GMSServices.provideAPIKey("AIzaSyCmm3aMQJYEo9SMkRRY_ooH1Nn9ZBiNq-4")
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
