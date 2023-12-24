import Flutter
import AVKit

public class PiPHandler: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "flutter_channel", binaryMessenger: registrar.messenger())
        let instance = PiPHandler()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if call.method == "enterPiPMode" {
            // Enter PiP mode
            if let keyWindow = UIApplication.shared.windows.first(where: { $0.isKeyWindow }),
               let rootViewController = keyWindow.rootViewController {
                let player = AVPlayer() // Replace this with your AVPlayer instance
                let playerViewController = AVPlayerViewController()
                playerViewController.player = player

                if #available(iOS 14.0, *) {
                    playerViewController.allowsPictureInPicturePlayback = true
                }

                rootViewController.present(playerViewController, animated: true) {
                    player.play()
                }
            }
        } else {
            result(FlutterMethodNotImplemented)
        }
    }
}
