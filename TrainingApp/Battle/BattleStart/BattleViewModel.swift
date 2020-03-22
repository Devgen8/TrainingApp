//
//  BattleViewModel.swift
//  TrainingApp
//
//  Created by мак on 22/03/2020.
//  Copyright © 2020 мак. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseStorage

class BattleViewModel {
    
    let battleReference = Firestore.firestore().collection("battle")
    let names = ["Екатерина", "Петр", "Анна", "Анастасия", "Евгений", "Алла", "Василиса", "Игорь", "Олег", "Никита", "Виктория", "Павел", "Алексей", "Стефан"]
    var theme: String?
    
    func getTheme(completion: @escaping (String?, UIImage?) -> ()) {
        battleReference.getDocuments { [weak self] (snapshot, error) in
            guard let `self` = self, error == nil else {
                print("Error reading themes: \(String(describing: error?.localizedDescription))")
                completion(nil, nil)
                return
            }
            if let documents = snapshot?.documents {
                var themes = [String]()
                for document in documents {
                    themes.append(document.data()["name"] as? String ?? "")
                }
                self.theme = themes[Int.random(in: 0..<themes.count)]
                self.downloadPhoto(named: self.theme ?? "") { [weak self] (image) in
                    completion(self?.theme, image)
                }
            } else {
                completion(nil, nil)
            }
        }
    }
    
    func getName() -> String {
        return names[Int.random(in: 0..<names.count)]
    }
    
    func downloadPhoto(named name: String, completion: @escaping (UIImage?) -> ()) {
        let imageRef = Storage.storage().reference().child("battle/\(theme ?? "").jpg")
        imageRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
            guard error == nil else {
                print("Error downloading images: \(String(describing: error?.localizedDescription))")
                completion(nil)
                return
            }
            if let data = data, let image = UIImage(data: data) {
                completion(image)
            } else {
                completion(nil)
            }
        }
    }
}
