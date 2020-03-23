//
//  TaskViewModel.swift
//  TrainingApp
//
//  Created by мак on 18/03/2020.
//  Copyright © 2020 мак. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage

class TaskViewModel {
    
    var theme: String?
    let themeReference = Firestore.firestore().collection("trainer")
    let usersReference = Firestore.firestore().collection("users")
    var task: TaskModel?
    var taskNumber: Int?
    var numberOfTasks:  Int?
    var isTaskUnsolved: Bool?
    var unsolvedTasks = [String:[String]]()
    var unsolvedTasksUpdater: UnsolvedTaskUpdater?
    var solvedTasks = [String:[String]]()
    
    func checkAnswer(_ stringAnswer: String?) -> (Bool, String) {
        guard let answer = Float(stringAnswer ?? "") else {
            return (false, "Ответ не должен содержать букв")
        }
        if answer == task?.wrightAnswer {
            isTaskUnsolved = false
            return (true, "Правильно! +1 балл")
        } else {
            isTaskUnsolved = true
            return (false, "Неправильно :(")
            
        }
    }
    
    func updateTaskStatus() {
        guard let theme = theme, let unsolvedTask = self.task?.name else {
            print("Couldn't write unsolved tasks")
            return
        }
        
        if isTaskUnsolved == true {
            if solvedTasks[theme]?.contains(unsolvedTask) ?? false {
                solvedTasks[theme] = solvedTasks[theme]?.filter({ $0 != unsolvedTask })
            }
            if unsolvedTasks[theme] == nil {
                unsolvedTasks[theme] = [unsolvedTask]
            } else {
                if !(unsolvedTasks[theme]?.contains(unsolvedTask) ?? true) {
                    unsolvedTasks[theme]?.append(unsolvedTask)
                }
            }
        }
        if isTaskUnsolved == false {
            if unsolvedTasks[theme]?.contains(unsolvedTask) ?? false {
                unsolvedTasks[theme] = unsolvedTasks[theme]?.filter({ $0 != unsolvedTask })
            }
            if solvedTasks[theme] == nil {
                solvedTasks[theme] = [unsolvedTask]
            } else {
                if !(solvedTasks[theme]?.contains(unsolvedTask) ?? true) {
                    solvedTasks[theme]?.append(unsolvedTask)
                }
            }
        }
        putTaskUnsolved()
    }
    
    func putTaskUnsolved() {
        if let userId = Auth.auth().currentUser?.uid {
            usersReference.document(userId).updateData(["unsolvedTasks" : unsolvedTasks,
                                                     "solvedTasks" : solvedTasks])
        }
    }
    
    func updateParentUnsolvedTasks() {
        unsolvedTasksUpdater?.updateUnsolvedTasks(with: unsolvedTasks, and: solvedTasks)
    }
    
//    func getUsersTask(completion: @escaping (TaskModel?) -> ()) {
//        if let userId = Auth.auth().currentUser?.uid {
//            usersReference.document(userId).collection("tasks").document("trainer").getDocument { [weak self]  (document, error) in
//                guard let `self` = self, error == nil else {
//                    completion(nil)
//                    return
//                }
//                self.currentSerialNumber = document?.data()?[Task.serialNumber.rawValue] as? Int
//                self.userTaskNumber = document?.data()?["taskNumber"] as? Int
//                self.getTasks { (task) in
//                    completion(task)
//                }
//            }
//        } else {
//            completion(nil)
//        }
//    }
//
//    func getTasks(completion: @escaping (TaskModel?) -> ()) {
//        guard let usersTheme = theme else {
//            completion(nil)
//            return
//        }
//        themeReference.document(usersTheme).collection("tasks").order(by: Task.serialNumber.rawValue, descending: false).whereField(Task.serialNumber.rawValue, isGreaterThan: self.currentSerialNumber ?? -1).limit(to: 2).getDocuments { [weak self] (snapshot, error) in
//            guard let `self` = self, error == nil, let documents = snapshot?.documents else {
//                return
//            }
//            for document in documents {
//                var task = TaskModel()
//                task.serialNumber = document.data()[Task.serialNumber.rawValue] as? Int
//                task.name = document.data()["name"] as? String
//                task.wrightAnswer = document.data()[Task.wrightAnswer.rawValue] as? Int
//                self.tasks.append(task)
//            }
//            self.getTaskImages { [weak self] (taskImages) in
//                guard let `self` = self, let images = taskImages else {
//                    completion(nil)
//                    return
//                }
//                var i = 0
//                for _ in images {
//                    self.tasks[i].image = images[i]
//                    i += 1
//                }
//                completion(self.tasks.first)
//            }
//
//        }
//    }
//
//
//    func getTaskImages(completion: @escaping ([Int:UIImage]?) -> ()) {
//        var images = [Int:UIImage]()
//        for index in stride(from: 0, to: 2, by: 1) {
//            let imageRef = Storage.storage().reference().child("trainer/task\(self.tasks[index].serialNumber ?? 0).jpg")
//            imageRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
//                guard error == nil else {
//                    completion(nil)
//                    return
//                }
//                if let data = data, let image = UIImage(data: data) {
//                    images[index] = image
//                }
//                if images.count == 2 {
//                    completion(images)
//                }
//            }
//        }
//    }
}
