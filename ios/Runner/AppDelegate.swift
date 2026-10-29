import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
  private let DIALER_CHANNEL = "com.example.home_to_school/dialer"
  private var isDialerChannelConfigured = false

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let result = super.application(application, didFinishLaunchingWithOptions: launchOptions)

    // If running in a traditional setup where window is initialized immediately
    if let flutterViewController = window?.rootViewController as? FlutterViewController {
      configureDialerChannel(messenger: flutterViewController.binaryMessenger)
    }

    return result
  }

  // Modern Flutter with UIScene / SceneDelegate
  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)
    configureDialerChannel(messenger: engineBridge.applicationRegistrar.messenger())
  }

  private func configureDialerChannel(messenger: FlutterBinaryMessenger) {
    guard !isDialerChannelConfigured else { return }
    isDialerChannelConfigured = true

    let dialerChannel = FlutterMethodChannel(name: DIALER_CHANNEL, binaryMessenger: messenger)

    dialerChannel.setMethodCallHandler { (call: FlutterMethodCall, result: @escaping FlutterResult) in
      if call.method == "openDialer" {
        if let args = call.arguments as? [String: Any],
           let number = args["number"] as? String {
          let cleanNumber = number.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? number
          guard let url = URL(string: "tel://\(cleanNumber)") else {
            result(FlutterError(code: "INVALID_NUMBER", message: "Phone number is invalid", details: nil))
            return
          }

          if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:]) { success in
              result(success)
            }
          } else {
            // Simulator or device without dialer capabilities
            result(false)
          }
        } else {
          result(FlutterError(code: "INVALID_NUMBER", message: "Phone number is invalid", details: nil))
        }
      } else {
        result(FlutterMethodNotImplemented)
      }
    }
  }
}
