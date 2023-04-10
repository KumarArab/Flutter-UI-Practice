import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      
      let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
          let deviceDataChannel = FlutterMethodChannel(name: "methodChannel/deviceData",
                                                    binaryMessenger: controller.binaryMessenger)
      deviceDataChannel.setMethodCallHandler({
            (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            // This method is invoked on the UI thread.
            // Handle device Id messages.
          guard call.method == "getDeviceId" else {
             result(FlutterMethodNotImplemented)
             return
           }
           self?.getUniqueDeviceId(result: result)
          
          
          })
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
    
    private func getUniqueDeviceId(result:FlutterResult) {
        result(UIDevice.current.identifierForVendor!.uuidString)
    }
}
