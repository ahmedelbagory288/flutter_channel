import UIKit
import Flutter
import AVKit

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let flutterViewController: FlutterViewController = window?.rootViewController as! FlutterViewController
        let piPChannel = FlutterMethodChannel(name: "flutter_channel", binaryMessenger: flutterViewController.binaryMessenger)
        piPChannel.setMethodCallHandler({ [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            guard call.method == "enterPiPMode" else {
                result(FlutterMethodNotImplemented)
                return
            }

            if let keyWindow = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) {
                if #available(iOS 14.0, *) {
                    keyWindow.windowScene?.supportsMultipleScenes = true
                }

                keyWindow.windowLevel = UIWindow.Level.normal
                keyWindow.makeKeyAndVisible()
                keyWindow.windowScene?.sizeRestrictions?.maximumSize = UIScreen.main.bounds.size
                keyWindow.windowScene?.activationConditions.canActivateForTargetContentIdentifierPredicate = NSPredicate(value: true)
                keyWindow.windowScene?.activationConditions.prefersToActivateForTargetContentIdentifierPredicate = NSPredicate(value: true)
            }

            result(nil)
        })

        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}