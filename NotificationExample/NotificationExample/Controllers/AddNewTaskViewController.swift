//
//  AddNewTaskViewController.swift
//  NotificationExample
//
//  Created by Bao on 2/21/17.
//  Copyright © 2017 TMA Solutions. All rights reserved.
//

import UIKit

class AddNewTaskViewController: UIViewController {

    //Mark: IBOutlets
    
    @IBOutlet weak var taskNameTextField: UITextField!
    
    @IBOutlet weak var taskTimeDatePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //Mark: IBActions
    
    @IBAction func saveNewTaskButton(_ sender: Any) {
        let taskItem = TaskItem(name: taskNameTextField.text!, deadline: taskTimeDatePicker.date, UUID: UUID().uuidString)
        TaskList.sharedInstance.addItem(taskItem) // schedule a local notification to persist this item
        let _ = self.navigationController?.popToRootViewController(animated: true)
    }

}
