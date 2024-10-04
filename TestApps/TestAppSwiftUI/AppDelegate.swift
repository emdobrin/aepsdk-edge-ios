//
// Copyright 2020 Adobe. All rights reserved.
// This file is licensed to you under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License. You may obtain a copy
// of the License at http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software distributed under
// the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR REPRESENTATIONS
// OF ANY KIND, either express or implied. See the License for the specific language
// governing permissions and limitations under the License.
//

import AEPCore
import AEPEdge
import AEPEdgeConsent
import AEPEdgeIdentity
import AEPMessaging
import AEPLifecycle
import Compression
import UIKit

#if os(iOS)
import AEPAssurance
#endif

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    // TODO: Set up the Environment File ID from your Launch property for the preferred environment
    //private let LAUNCH_ENVIRONMENT_FILE_ID = "94f571f308d5/258cde3c1a94/launch-8a790844d1cf-development" -> Obu mobile 5
    private let LAUNCH_ENVIRONMENT_FILE_ID = "3149c49c3910/b19839a8ba5d/launch-65f55c308bd9-development" // -> AEM Assets departmental

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let appState = application.applicationState
        // Override point for customization after application launch.
        MobileCore.setLogLevel(.trace)
        
        let extensions: [NSObject.Type] = 
        [Edge.self, Identity.self, Consent.self,
        Messaging.self, Lifecycle.self, Assurance.self]

        MobileCore.registerExtensions(extensions) {
            MobileCore.configureWith(appId: self.LAUNCH_ENVIRONMENT_FILE_ID)
            if appState != .background {
                MobileCore.lifecycleStart(additionalContextData: ["appState": "notBackground", "didFinishLaunchingWithOptions": "data"])
            }
        }
        
        registerForPushNotifications(application)
//        Assurance.startSession(url: URL(string: "adobeassurance://?adb_validation_sessionid=1be92129-2569-469c-81f2-59ad1f43736b"))
//        let collectConsent = ["collect": ["val": "y"]]
//        let currentConsents = ["consents": collectConsent]
//        Consent.update(with: currentConsents)

//        Edge.sendEvent(experienceEvent: ExperienceEvent(xdm: ["didFinishLaunchingWithOptions": "received"]))
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    // To handle deeplink on iOS versions 12 and below
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        #if os(iOS)
        Assurance.startSession(url: url)
        #endif
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        MobileCore.setPushIdentifier(deviceToken)
        
        let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data) }
        let token = tokenParts.joined()
        print("Device token is - \(token)")
        Edge.sendEvent(experienceEvent: ExperienceEvent(xdm: ["didRegisterForRemoteNotificationsWithDeviceToken": "received"]))
    }
    
    func application(_ application: UIApplication,
               didReceiveRemoteNotification userInfo: [AnyHashable : Any],
               fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        // Handle the silent notifications received from AJO in here
        print("silent notification received")
        
        UIApplication.shared.beginBackgroundTask(withName: "TestBG",
                                          expirationHandler: {
            sleep(30)
            Edge.sendEvent(experienceEvent: ExperienceEvent(xdm:
            ["eventType": "didReceiveRemoteNotification-silentnotification"]))
        })
        
        completionHandler(.newData)
      }
    
    func userNotificationCenter(_: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {

        Edge.sendEvent(experienceEvent: ExperienceEvent(xdm: ["userNotificationCenter": "received"]))
//        Messaging.handleNotificationResponse(response, urlHandler: { url in
//            /// return `true` if the app is handling the url or `false` if the Adobe SDK should handle it
//            let appHandlesUrl = false
//            return appHandlesUrl
//        }, closure: { pushTrackingStatus in
//            Edge.sendEvent(experienceEvent: ExperienceEvent(xdm: 
//                ["eventType": "userNotificationCenter-handleremoteresponse",
//                "pushTrackingStatus": pushTrackingStatus.rawValue]))
//            if pushTrackingStatus == .trackingInitiated {
//                // tracking was successful
//                
//            } else {
//                // tracking failed, view the status for more information
//
//            }
//        })

        completionHandler()
    }
    
    // MARK: - Push Notification registration methods
    func registerForPushNotifications(_ application : UIApplication) {
        let center = UNUserNotificationCenter.current()
        // Ask for user permission
        center.requestAuthorization(options: [.badge, .sound, .alert]) { [weak self] granted, _ in
            guard granted else { return }
            
            let pushConsent = ["marketing": 
                                ["push": ["val": "y"], "preferred": "push"]]
            let currentConsents = ["consents": pushConsent]
            Consent.update(with: currentConsents)
            
            center.delegate = self
            
            DispatchQueue.main.async {
                application.registerForRemoteNotifications()
            }
        }
    }
}
