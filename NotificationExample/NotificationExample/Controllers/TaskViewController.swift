//
//  TaskViewController.swift
//  NotificationExample
//
//  Created by Bao on 2/21/17.
//  Copyright © 2017 TMA Solutions. All rights reserved.
//

import UIKit

class TaskViewController: UIViewController {
    
    //Mark: IBOutlets
    @IBOutlet weak var taskListTableView: UITableView!
    
    var taskItems = [TaskItem]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.refreshList()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func refreshList() {
        taskItems = TaskList.sharedInstance.allItems()
        taskListTableView.reloadData()
    }
    
}

extension TaskViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let taskItem = taskItems[indexPath.row]
        
        let cellIdentifier = "cellIdentifier"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        cell.textLabel?.text = taskItem.name
        if (taskItem.isOverdue) { // the current time is later than the to-do item's deadline
            cell.detailTextLabel?.textColor = UIColor.red
        } else {
            cell.detailTextLabel?.textColor = UIColor.black // we need to reset this because a cell with red subtitle may be returned by dequeueReusableCellWithIdentifier:indexPath:
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "'Due' MMM dd 'at' h:mm a"
        cell.detailTextLabel?.text = dateFormatter.string(from: taskItem.deadline as Date)
        return cell
        
    }
}

extension TaskViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let taskItemSelected = taskItems[indexPath.row]
        if let taskDetailViewController = AppDelegate.mainStoryBoard.instantiateViewController(withIdentifier: "TaskDetailViewController") as? TaskDetailViewController {
            taskDetailViewController.taskItem = taskItemSelected
            self.navigationController?.pushViewController(taskDetailViewController, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            let taskItemSelected = taskItems[indexPath.row]
            TaskList.sharedInstance.removeItem(taskItemSelected)
            refreshList()
        }
    }
}






