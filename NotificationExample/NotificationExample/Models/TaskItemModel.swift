//
//  TaskItemModel.swift
//  NotificationExample
//
//  Created by Bao on 2/21/17.
//  Copyright © 2017 TMA Solutions. All rights reserved.
//

import Foundation

struct TaskItem {
    
    var name: String
    var deadline: Date
    var UUID: String
    var isOverdue: Bool {
        return (Date().compare(self.deadline) == ComparisonResult.orderedDescending)
    }
    
    init(name: String, deadline: Date, UUID: String) {
        self.name = name
        self.deadline = deadline
        self.UUID = UUID
    }
    
}
