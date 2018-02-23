//
//  dataObject.swift
//  Time Tracking App
//
//  Created by Lasha Gejadze on 21.02.18.
//  Copyright © 2018 APP3null. All rights reserved.
//

import UIKit

class TaskObject {
    
    var taskTitle: String?
    var taskDescription: String?
    var duration: String!
    
    init(title: String? = "Custom Task", description: String? = "APP3null Hello", duration: String) {
        self.taskTitle = title
        self.taskDescription = description
        self.duration = duration
    }
    
}
