import UIKit
import Flutter
import beacon_monitoring

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {

    // MARK: - UIApplicationDelegate Methods
    override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // ...
        setupAppDelegateRegistry()
        setupBeaconMonitoringPluginCallback()
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    // MARK: - Register Plugins
    static func registerPlugins(with registry: FlutterPluginRegistry) {
        GeneratedPluginRegistrant.register(with: registry)
    }

    // MARK: - Private Methods
    private func setupAppDelegateRegistry() {
        AppDelegate.registerPlugins(with: self)
    }
    private func setupBeaconMonitoringPluginCallback() {
        BeaconMonitoringPlugin.setPluginRegistrantCallback { registry in
            AppDelegate.registerPlugins(with: registry)
        }
    }
    private func didFinishLaunchingWithOptions() {
          if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().delegate = slf as? UNUserNotificationCenterDelegate
    }e
    }
  
}