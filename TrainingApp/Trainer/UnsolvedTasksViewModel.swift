//
//  UnsolvedTasksViewModel.swift
//  TrainingApp
//
//  Created by мак on 22/03/2020.
//  Copyright © 2020 мак. All rights reserved.
//

import Foundation

class UnsolvedTasksViewModel {
    var unsolvedTasks = [String:[String]]()
    var theme: String?
    var tasks = [TaskModel]()
    
    func transportData(for viewModel: TaskViewModel, at index: Int) {
        viewModel.numberOfTasks = tasks.count
        viewModel.taskNumber = index + 1
        viewModel.theme = theme
        viewModel.task = tasks[index]
        viewModel.unsolvedTasks = unsolvedTasks
        viewModel.unsolvedTasksUpdater = self
    }
    
    
}

extension UnsolvedTasksViewModel: DataConstructer {
    func constructData(for row: Int) -> String {
        return unsolvedTasks[theme ?? ""]?[row] ?? ""
    }
    
    func getItemsCount() -> Int {
        return unsolvedTasks[theme ?? ""]?.count ?? 0
    }
}

extension UnsolvedTasksViewModel: UnsolvedTaskUpdater {
    func updateUnsolvedTasks(with tasks: [String : [String]]) {
        unsolvedTasks = tasks
    }
}
