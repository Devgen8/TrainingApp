//
//  TrainerViewModel.swift
//  TrainingApp
//
//  Created by мак on 18/03/2020.
//  Copyright © 2020 мак. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class TrainerViewModel {
    
    let tasksReference = Firestore.firestore().collection("trainer")
    let usersReference = Firestore.firestore().collection("users")
    var unsolvedTasks = [String:[String]]()
    var themes = [String]()
    
    func getThemes(completion: @escaping (Bool) -> ()) {
        tasksReference.getDocuments { [weak self] (snapshot, error) in
            guard let `self` = self, error == nil, let documents = snapshot?.documents else {
                completion(false)
                return
            }
            var allThemes = [String]()
            for document in documents {
                if let themeName = document.data()[Theme.name.rawValue] as? String {
                    allThemes.append(themeName)
                }
            }
            self.themes = allThemes
            completion(true)
        }
    }
    
    func getUnsolvedTasksCount(completion: @escaping (Int) -> ()) {
        var tasksCount = 0
        getUnsolvedTasks { (tasks) in
            if let tasks = tasks {
                for theme in tasks.keys {
                    tasksCount += tasks[theme]?.count ?? 0
                }
            }
            completion(tasksCount)
        }
    }
    
    func getUnsolvedTasks(completion: @escaping ([String : [String]]?) -> ()) {
        if let userId = Auth.auth().currentUser?.uid {
            usersReference.document(userId).getDocument { [weak self] (document, error) in
                guard let `self` = self, error == nil, let document = document else {
                    print("Error reading unsolved tasks: \(String(describing: error?.localizedDescription))")
                    completion(nil)
                    return
                }
                let tasks = document.data()?["unsolvedTasks"] as? [String : [String]]
                completion(tasks)
                self.unsolvedTasks = tasks ?? [String:[String]]()
            }
        }
    }
    
    func transportDataTo(_ viewModel: TasksListViewModel, at index: Int) {
        viewModel.theme = themes[index]
        viewModel.unsolvedTasks = unsolvedTasks
    }
}
