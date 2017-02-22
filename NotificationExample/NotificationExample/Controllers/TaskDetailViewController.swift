//
//  TaskDetailViewController.swift
//  NotificationExample
//
//  Created by Bao on 2/21/17.
//  Copyright © 2017 TMA Solutions. All rights reserved.
//

import UIKit
import UserNotifications

class TaskDetailViewController: UIViewController {

    //Mark: IBOutlets
    
    @IBOutlet weak var taskDetailLabel: UILabel!
    
    var taskItem: TaskItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let taskItem = taskItem {
            
            taskDetailLabel.text = taskItem.name
            UNUserNotificationCenter.current().getDeliveredNotifications { (deliveredNotifications) in
                
                for deliveredNotification in deliveredNotifications {
                    if deliveredNotification.request.identifier == taskItem.UUID {
                        UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: [taskItem.UUID])
                        UIApplication.shared.applicationIconBadgeNumber = UIApplication.shared.applicationIconBadgeNumber - 1
                    }
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
