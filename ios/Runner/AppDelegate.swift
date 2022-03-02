import UIKit
import Flutter
import FirebaseMessaging

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    // 👇 this block
    override func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
      // NOTE: For logging
      // let deviceTokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
      // print("==== didRegisterForRemoteNotificationsWithDeviceToken ====")
      // print(deviceTokenString)
      Messaging.messaging().apnsToken = deviceToken
    }
}
  


//import UIKit
//import Flutter
//import Firebase
//import FirebaseAuth
//
//
//@UIApplicationMain
//@objc class AppDelegate: FlutterAppDelegate {
//  override func application(
//    _ application: UIApplication,
//    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
//  ) -> Bool {
//    GeneratedPluginRegistrant.register(with: self)
//    FirebaseApp.configure()
//    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
//  }
//
//    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
//       let firebaseAuth = Auth.auth()
//       firebaseAuth.setAPNSToken(deviceToken, type: AuthAPNSTokenType.unknown)
//
//   }
//
//   func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
//       let firebaseAuth = Auth.auth()
//       if (firebaseAuth.canHandleNotification(userInfo)){
//           print(userInfo)
//           return
//       }
//   }
//}
