//
//  AppDelegate.swift
//  Mitter Starter
//
//  Created by Vedavyas Bhat on 10/12/18.
//  Copyright © 2018 mitter.io. All rights reserved.
//

import UIKit
import Firebase
import UserNotifications
import Mitter
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let gcmMessageIDKey = "gcm.message_id"
    var mitter: Mitter = Mitter(applicationId: "")


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        IQKeyboardManager.shared.enable = true

        FirebaseApp.configure()
        Messaging.messaging().shouldEstablishDirectChannel = true
        Messaging.messaging().useMessagingDelegateForDirectChannel = true
        Messaging.messaging().delegate = self

        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self

            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }

        application.registerForRemoteNotifications()

//        mitter = Mitter(
//            applicationId: "6AXts-r7DHE-tt49P-TuXE2",
//            userAuthToken: "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJtaXR0ZXItaW8iLCJ1c2VyVG9rZW5JZCI6ImlyVlpGdzh6VjRIUTVBT2MiLCJ1c2VydG9rZW4iOiI1aGYxcHBwMGdzYnVtZGRzdTY2ZmZiYWQ1biIsImFwcGxpY2F0aW9uSWQiOiI2QVh0cy1yN0RIRS10dDQ5UC1UdVhFMiIsInVzZXJJZCI6InVzZXItb25lIn0.Kx_YLz4NqhIRXLYwaAI4UXePhYZ8Hb3EqJL4cIw3WTpuK5ULfRSGb0BKl__udhiJOZ2CzWTu8kc-d_XDd92cAA"
//        )

//        mitter = Mitter(
//            applicationId: "ypBKz-gwtly-ZwDhC-4gna4",
//            userAuthToken: "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJtaXR0ZXItaW8iLCJ1c2VyVG9rZW5JZCI6IjNzeWNucERTbVpmbEJQU1IiLCJ1c2VydG9rZW4iOiJpYm1uMzNvNGZvNGt2N3FscGJoZnBxcHByaiIsImFwcGxpY2F0aW9uSWQiOiJ5cEJLei1nd3RseS1ad0RoQy00Z25hNCIsInVzZXJJZCI6Ik14SXpXLWdOcUx4LTg4QW15LU0xWGFIIn0.c38teANXXwvQjWJ4P-ypx7NKFx8un-yvmH8QTZQUdZ3T_kUc5iQu09qyFnkmveuGxutqosba-4go6_VXTufrGw"
//        )

        mitter = Mitter(
            applicationId: "RZXnp-2llDF-LpJUn-0vT0m",
            userAuthToken: "eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJtaXR0ZXItaW8iLCJ1c2VyVG9rZW5JZCI6InhQc2wxZko3ZEJuejFXYkYiLCJ1c2VydG9rZW4iOiIydWdxbzZyaXZuODZhOTk3a3BuaDRvMDI0MSIsImFwcGxpY2F0aW9uSWQiOiJSWlhucC0ybGxERi1McEpVbi0wdlQwbSIsInVzZXJJZCI6InVzZXItb25lIn0.N7iQpKrIdQSFtFM0WG3Y-FreJaSn45_nINgnQcM2Hh94xP85IxUabeu5CjjpD3yeAeK8_nYBTLe2SSaWvXQv0A"
        )

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    // [START receive_message]
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        // If you are receiving a notification message while your app is in the background,
        // this callback will not be fired till the user taps on the notification launching the application.
        // TODO: Handle data of notification
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID 1: \(messageID)")
        }

        // Print full message.
        print("Message 2 is: \(userInfo)")
    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        // If you are receiving a notification message while your app is in the background,
        // this callback will not be fired till the user taps on the notification launching the application.
        // TODO: Handle data of notification
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID 2: \(messageID)")
        }

        // Print full message.
        print("Message 2 is: \(userInfo)")

        completionHandler(UIBackgroundFetchResult.newData)
    }
    // [END receive_message]

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Unable to register for remote notifications: \(error.localizedDescription)")
    }

    // This function is added here only for debugging purposes, and can be removed if swizzling is enabled.
    // If swizzling is disabled then this function must be implemented so that the APNs token can be paired to
    // the FCM registration token.
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("APNs token retrieved: \(deviceToken.base64EncodedString())")

        InstanceID.instanceID().instanceID { (result, error) in
            if let error = error {
                print("Error fetching remote instange ID: \(error)")
            } else if let result = result {
                print("Remote instance ID token: \(result.token)")

                self.mitter.registerFcmToken(token: result.token) {
                    result in
                    switch result {
                    case .success(let deliveryEndpoint):
                        print("Endpoint is: \(deliveryEndpoint.serializedEndpoint)")
                    case .error:
                        print("Unable to register endpoint!")
                    }
                }
            }
        }

        // With swizzling disabled you must set the APNs token here.
        // Messaging.messaging().apnsToken = deviceToken
    }

}

// [START ios_10_message_handling]
@available(iOS 10, *)
extension AppDelegate : UNUserNotificationCenterDelegate {

    // Receive displayed notifications for iOS 10 devices.
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo

        print("Received data: \(userInfo)")

        let messageString = userInfo["data"] as! String
        let messagingPipelinePayload = mitter.parseFcmMessage(data: messageString)

        processFcmMessage(pipelinePayload: messagingPipelinePayload)

        // Change this to your preferred presentation option
        completionHandler([])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message 4 ID: \(messageID)")
        }

        // Print full message.
        print("Message 4 is: \(userInfo)")

        completionHandler()
    }

    func processFcmMessage(pipelinePayload: MessagingPipelinePayload?) {
        if mitter.isMitterMessage(pipelinePayload) {
            let payload = mitter.processPushMessage(pipelinePayload!)

            switch payload {
                // Handle the new message payload: Add it to the Channel Window View Controller
                case .NewMessagePayload(let message, let channelId):
                    print("Received Message: \(message), for Channel: \(channelId)")
                    if let navController = window?.rootViewController as? UINavigationController {
                        // Get the second controller, which is the ChannelWindowViewController according to the storyboard
                        if let channelWindowViewController = navController.viewControllers[1] as? ChannelWindowViewController {
                            channelWindowViewController.newMessage(channelId: channelId.domainId, message: message)
                        }
                    }
                // Ignore all other payloads
                default:
                    print("Nothing to print!")
            }
        }
    }
}
// [END ios_10_message_handling]

extension AppDelegate : MessagingDelegate {
    // [START refresh_token]
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        print("Firebase registration token: \(fcmToken)")

        let dataDict:[String: String] = ["token": fcmToken]
        NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
        // TODO: If necessary send token to application server.
        // Note: This callback is fired at each app startup and whenever a new token is generated.
    }
    // [END refresh_token]
    // [START ios_10_data_message]
    // Receive data messages on iOS 10+ directly from FCM (bypassing APNs) when the app is in the foreground.
    // To enable direct data messages, you can set Messaging.messaging().shouldEstablishDirectChannel to true.
    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
        print("Received data message: \(remoteMessage.appData)")
        let messagingPipelinePayload = mitter.parseFcmMessage(data: remoteMessage.appData["data"] as! String)
        processFcmMessage(pipelinePayload: messagingPipelinePayload)
    }
    // [END ios_10_data_message]
}
