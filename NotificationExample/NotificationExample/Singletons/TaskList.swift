//
//  TaskList.swift
//  NotificationExample
//
//  Created by Bao on 2/21/17.
//  Copyright © 2017 TMA Solutions. All rights reserved.
//

import Foundation
import UserNotifications
import UIKit

class TaskList {
    fileprivate let ITEMS_KEY = "todoItems"
    class var sharedInstance : TaskList {
        struct Static {
            static let instance: TaskList = TaskList()
        }
        return Static.instance
    }
    
    func addItem(_ item: TaskItem) {
        var taskDictionary = UserDefaults.standard.dictionary(forKey: ITEMS_KEY) ?? Dictionary()
        taskDictionary[item.UUID] = ["name": item.name, "deadline": item.deadline, "UUID": item.UUID]
        UserDefaults.standard.set(taskDictionary, forKey: ITEMS_KEY)
        
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents(in: .current, from: item.deadline)
        let newComponents = DateComponents(calendar: calendar, timeZone: .current, month: components.month, day: components.day, hour: components.hour, minute: components.minute)
        
        let content = UNMutableNotificationContent()
        content.title = "\(item.name)"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "'Due' MMM dd 'at' h:mm a"
        content.body = dateFormatter.string(from: item.deadline)
        content.sound = UNNotificationSound.default()
        //content.badge = (UIApplication.shared.applicationIconBadgeNumber + 1) as NSNumber
        
//        UNUserNotificationCenter.current().getPendingNotificationRequests { (requests) in
//            content.badge = requests.count as NSNumber
//        }
        
        content.categoryIdentifier = "\(item.UUID)"
        let trigger = UNCalendarNotificationTrigger(dateMatching: newComponents, repeats: false)
        let request = UNNotificationRequest.init(identifier: item.UUID, content: content, trigger: trigger)
        
        //UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().add(request) {(error) in
            if let error = error {
                print("Uh oh! We had an error: \(error)")
            }
        }
    }
    
    func removeItem(_ item: TaskItem) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [item.UUID])
        
        if var taskItems = UserDefaults.standard.dictionary(forKey: ITEMS_KEY) {
            taskItems.removeValue(forKey: item.UUID)
            UserDefaults.standard.set(taskItems, forKey: ITEMS_KEY)
        }
    }
    
    func allItems() -> [TaskItem] {
        let taskDictionary = UserDefaults.standard.dictionary(forKey: ITEMS_KEY) ?? [:]
        let items = Array(taskDictionary.values)
        return items.map({
            let item = $0 as! [String:AnyObject]
            return TaskItem(name: item["name"] as! String, deadline: item["deadline"] as! Date, UUID: item["UUID"] as! String!)
        }).sorted(by: {(left: TaskItem, right:TaskItem) -> Bool in
            (left.deadline.compare(right.deadline) == .orderedAscending)
        })
    }
}
