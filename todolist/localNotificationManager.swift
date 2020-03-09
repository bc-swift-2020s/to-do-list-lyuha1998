//
//  localNotificationManager.swift
//  todolist
//
//  Created by Huiyi Victoria Lyu on 2/28/20.
//  Copyright © 2020 Huiyi Victoria Lyu. All rights reserved.
//

import UIKit
import UserNotifications

struct LocalNotificationManager {
    static func autherizeLocalNotifications (viewController: UIViewController) { UNUserNotificationCenter
        .current().requestAuthorization(options: [.alert,.sound,.badge]) { (granted, error) in
            guard error == nil else {
                print("Error!")
                return
            }
            if granted {
                print("Granted")
                
            } else {
                print("User has denied notifications!")
                
                
                DispatchQueue.main.async {
                    viewController.oneButtonAlert(title: "User has not alllowed notifications", message: "Open the Settings to receive alerts for the reminder")
                }
                
            }
        }
    }
    
    static func isAuthorized (completed: @escaping (Bool) -> ()) { UNUserNotificationCenter
          .current().requestAuthorization(options: [.alert,.sound,.badge]) { (granted, error) in
              guard error == nil else {
                  print("Error!")
                completed(false)
                  return
              }
              if granted {
                  print("Granted")
                completed(true)
                  
              } else {
                  print("User has denied notifications!")
                  completed(false)
                  
                
                  
              }
          }
      }
      
    
    static func setCalendarNotification(title:String, subtitle:String, body: String, badgeNumber: NSNumber?, sound: UNNotificationSound?, date:Date) -> String {
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = subtitle
        content.body = body
        content.sound = sound
        content.badge = badgeNumber
        
        
        //create trigger
        var dateComponents = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute], from: date)
        dateComponents.second = 00
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        // create request
        let notificationID = UUID().uuidString
        let request = UNNotificationRequest(identifier: notificationID, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) {(error) in
            if let error = error {
                print("ERROR!!!")
            } else {
                print("Notification scheduled!")
            }
        }
        return notificationID
    }
    
    
    

    
}
