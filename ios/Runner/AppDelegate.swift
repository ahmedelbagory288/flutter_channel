import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

   let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
      let channel = FlutterMethodChannel(name: "flutter_channel",
                                                binaryMessenger: controller.binaryMessenger)

//       channel.setMethodCallHandler({
//         (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
//         // This method is invoked on the UI thread.
//       guard call.method == "getBatteryLevel" else {
//           result(FlutterMethodNotImplemented)
//           return
//         }
//         self?.receiveBatteryLevel(result: result)
//       })


//          channel.setMethodCallHandler({(call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
//         guard call.method == "enterPiPMode" else {
//             result(FlutterMethodNotImplemented)
//             return
//             }
//              if let keyWindow = UIApplication.shared.windows.first(where: { $0.isKeyWindow }),
//                  let rootViewController = keyWindow.rootViewController {
//                     let player = AVPlayer()
//                     let playerViewController = AVPlayerViewController()
//                     playerViewController.player = player
//
//                     if #available(iOS 14.0, *) {
//                         playerViewController.allowsPictureInPicturePlayback = true
//                     }
//
//                     rootViewController.present(playerViewController, animated: true) {
//                         player.play()
//                     }
//                 }
//         })
//

       channel.setMethodCallHandler { [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            guard call.method == "enterPiPMode" else {
                result(FlutterMethodNotImplemented)
                return
            }

            if let keyWindow = UIApplication.shared.windows.first(where: { $0.isKeyWindow }),
               let rootViewController = keyWindow.rootViewController {
                if #available(iOS 14.0, *) {
                    rootViewController.canBecomeOverlay = true
                    rootViewController.isModalInPresentation = true
                }

                rootViewController.view.window?.windowLevel = UIWindow.Level.statusBar + 1
            }

            result(nil)
        }
 
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }


        
  private func receiveBatteryLevel(result: FlutterResult) {
    let device = UIDevice.current
    device.isBatteryMonitoringEnabled = true
    if device.batteryState == UIDevice.BatteryState.unknown {
      result(FlutterError(code: "UNAVAILABLE",
                          message: "Battery level not available.",
                          details: nil))
    } else {
      result(Int(device.batteryLevel * 100))
    }
  }
}