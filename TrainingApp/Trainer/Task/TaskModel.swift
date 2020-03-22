//
//  TaskModel.swift
//  TrainingApp
//
//  Created by мак on 18/03/2020.
//  Copyright © 2020 мак. All rights reserved.
//

import UIKit

struct TaskModel {
    var name: String?
    var serialNumber: Int?
    var image: UIImage?
    var wrightAnswer: Float?
}

enum Task: String {
    case serialNumber = "serialNumber"
    case image = "image"
    case wrightAnswer = "wrightAnswer"
}
