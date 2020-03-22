//
//  CustomProtocols.swift
//  TrainingApp
//
//  Created by мак on 16/03/2020.
//  Copyright © 2020 мак. All rights reserved.
//

import Foundation

protocol UnsolvedTaskUpdater {
    func updateUnsolvedTasks(with tasks: [String:[String]])
}

protocol DataConstructer {
    var unsolvedTasks: [String:[String]] { set get }
    func constructData(for row: Int) -> String
    func getItemsCount() -> Int
}
