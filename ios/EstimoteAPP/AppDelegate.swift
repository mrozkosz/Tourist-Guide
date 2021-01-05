//
//  AppDelegate.swift
//  EstimoteAPP
//
//  Created by Mateusz on 02/09/2020.
//  Copyright © 2020 Mateusz. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import UserNotifications
import EstimoteProximitySDK


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    var proximityObserver: ProximityObserver!
    private var beaconsService = BeaconsService()
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
          
        ApplicationDelegate.shared.application(
            application,
            didFinishLaunchingWithOptions: launchOptions
        )
        
        
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.delegate = self
        notificationCenter.requestAuthorization(options: [.alert, .sound]) { granted, error in
            print("notifications permission granted = \(granted), error = \(error?.localizedDescription ?? "(none)")")
        }

        let estimoteCloudCredentials = CloudCredentials(appID: "mateuszrozkosz97-gmail-com-72t", appToken: "6a801bf31ca12adff113be06414b9e2d")

        proximityObserver = ProximityObserver(credentials: estimoteCloudCredentials, onError: { error in
            print("ProximityObserver error: \(error)")
        })

        let zone = ProximityZone(tag: "mateuszrozkosz97-gmail-com-72t", range: ProximityRange.near)
        zone.onEnter = { context in
            let content = UNMutableNotificationContent()
            

            self.beaconsService.getData(beaconsUUIDs: [context.deviceIdentifier]){ result in
                DispatchQueue.main.async {
                    
                    if(result.count >= 1){
                        content.title = result.first?.location ?? ""
                        content.body =  result.first?.name ?? ""
                        content.sound = UNNotificationSound.default
                        let request = UNNotificationRequest(identifier: "enter", content: content, trigger: nil)
                        notificationCenter.add(request, withCompletionHandler: nil)
                    }else{
                        content.title = "Witaj!"
                        content.body =  "Mamy wiele ciekawych miejsc do odwiedzenia!"
                        content.sound = UNNotificationSound.default
                        let request = UNNotificationRequest(identifier: "enter", content: content, trigger: nil)
                        notificationCenter.add(request, withCompletionHandler: nil)
                    }
                    
                }
            }
           
        }
        zone.onExit = { context in
            let content = UNMutableNotificationContent()
            
            content.title = "Bye bye"
            content.body = "You've left the proximity of your tag"
            content.sound = UNNotificationSound.default
            let request = UNNotificationRequest(identifier: "exit", content: content, trigger: nil)
            notificationCenter.add(request, withCompletionHandler: nil)
        }

        proximityObserver.startObserving([zone])
        

        return true
    }
          
    func application(
        _ app: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey : Any] = [:]
    ) -> Bool {

        return ApplicationDelegate.shared.application(
            app,
            open: url,
            sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
            annotation: options[UIApplication.OpenURLOptionsKey.annotation]
        )

    }

}


