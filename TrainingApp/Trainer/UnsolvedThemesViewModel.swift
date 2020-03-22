//
//  UnsolvedThemesViewModel.swift
//  TrainingApp
//
//  Created by мак on 22/03/2020.
//  Copyright © 2020 мак. All rights reserved.
//

import Foundation

class UnsolvedThemesViewModel {
    var unsolvedTasks = [String:[String]]()
}

extension UnsolvedThemesViewModel: DataConstructer {
    func getItemsCount() -> Int {
        return unsolvedTasks.keys.count
    }
    
    func constructData(for row: Int) -> String {
        let theme = Array<String>(unsolvedTasks.keys)[row]
        return "\(theme)(\(unsolvedTasks[theme]?.count ?? 0))"
    }
}

extension UnsolvedThemesViewModel: UnsolvedTaskUpdater {
    func updateUnsolvedTasks(with tasks: [String : [String]]) {
        unsolvedTasks = tasks
    }
}
