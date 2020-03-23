//
//  TasksListViewModel.swift
//  TrainingApp
//
//  Created by мак on 19/03/2020.
//  Copyright © 2020 мак. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage
import FirebaseAuth

class TasksListViewModel {
    var theme: String?
    var tasks = [TaskModel]()
    var usersSolvedTasks = [String:[String]]()
    var unsolvedTasks = [String:[String]]()
    let themeReference = Firestore.firestore().collection("trainer")
    let userReference = Firestore.firestore().collection("users")
    var lookingForUnsolvedTasks: Bool?
    var unsolvedTaskUpdater: UnsolvedTaskUpdater?
    
    func getTasks(completion: @escaping (Bool) -> ()) {
        getUsersStats()
        guard let theme = theme else {
            completion(false)
            return
        }
        themeReference.document(theme).collection("tasks").getDocuments { (snapshot, error) in
            guard error == nil else {
                print("Error reading tasks: \(String(describing: error?.localizedDescription))")
                return
            }
            self.getUsersStats()
            if let documents = snapshot?.documents {
                for document in documents {
                    var task = TaskModel()
                    task.serialNumber = document.data()[Task.serialNumber.rawValue] as? Int
                    task.wrightAnswer = document.data()[Task.wrightAnswer.rawValue] as? Float
                    task.name = "Задача №\(task.serialNumber ?? 1)"
                    if self.lookingForUnsolvedTasks ?? false {
                        if self.unsolvedTasks[theme]?.filter({ $0 == task.name }).count ?? 0 > 0 {
                            self.tasks.append(task)
                        }
                    } else {
                        self.tasks.append(task)
                    }
                }
                completion(true)
                self.downloadPhotos()
            }
        }
    }
    
    func getUsersStats() {
        if let userId = Auth.auth().currentUser?.uid {
            userReference.document(userId).getDocument { [weak self] (document, error) in
                guard let `self` = self, error == nil else { return }
                if let solvedTasks = document?.data()?["solvedTasks"] as? [String:[String]] {
                    self.usersSolvedTasks = solvedTasks
                }
            }
        }
    }
    
    func downloadPhotos() {
        for index in stride(from: 0, to: tasks.count, by: 1) {
            let imageRef = Storage.storage().reference().child("trainer/\(theme ?? "")/task\(self.tasks[index].serialNumber ?? 0).jpg")
            imageRef.getData(maxSize: 1 * 1024 * 1024) { [weak self] data, error in
                guard let `self` = self, error == nil else {
                    print("Error downloading images: \(String(describing: error?.localizedDescription))")
                    return
                }
                if let data = data, let image = UIImage(data: data) {
                    self.tasks[index].image = image
                }
            }
        }
    }
    
    func transportData(for viewModel: TaskViewModel, at index: Int) {
        viewModel.numberOfTasks = tasks.count
        viewModel.taskNumber = index + 1
        viewModel.theme = theme
        viewModel.task = tasks[index]
        viewModel.unsolvedTasks = unsolvedTasks
        viewModel.unsolvedTasksUpdater = self
        viewModel.solvedTasks = usersSolvedTasks
    }
}

extension TasksListViewModel: UnsolvedTaskUpdater {
    func updateUnsolvedTasks(with unsolvedTasks: [String : [String]], and solvedTasks: [String : [String]]?) {
        self.unsolvedTasks = unsolvedTasks
        usersSolvedTasks = solvedTasks ?? [:]
        if lookingForUnsolvedTasks ?? false {
            self.tasks = self.tasks.filter({ unsolvedTasks[theme ?? ""]?.contains($0.name ?? "") ?? true })
        }
        unsolvedTaskUpdater?.updateUnsolvedTasks(with: unsolvedTasks, and: nil)
    }
}
