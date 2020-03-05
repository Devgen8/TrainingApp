//
//  SignUpViewModel.swift
//  TrainingApp
//
//  Created by мак on 17/02/2020.
//  Copyright © 2020 мак. All rights reserved.
//

import Foundation
import FirebaseAuth

class SignUpViewModel {
    func checkUsersData(name: String?,
                        email: String?,
                        password: String?,
                        confirmPassword: String?) -> String? {
        guard
            let name = name,
            name.trimmingCharacters(in: .whitespacesAndNewlines) != "",
            let email = email,
            let password = password,
            let confirmPassword = confirmPassword else {
                return "Заполнены не все поля"
        }
        if let emailChecking = checkEmail(email) {
            return emailChecking
        }
        if let passwordChecker = checkPassword(password: password, confirmPassword: confirmPassword) {
            return passwordChecker
        }
        return nil
    }
    
    func checkEmail(_ email: String) -> String? {
        if !(email.contains("@") && email.contains(".")),
            email.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Пожалуйста, заполните почту в соответствии со следующим форматом: example@gmail.com"
        }
        return nil
    }
    
    func checkPassword(password: String, confirmPassword: String) -> String? {
        if password.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            password.count < 8 {
            return "Пароль должен быть не менее 8 символов"
        }
        if password != confirmPassword {
            return "Пароли не совпадают, попробуйте еще раз"
        }
        return nil
    }
    
    func createUser(name: String?,
                    email: String?,
                    password: String?,
                    confirmPassword: String?,
                    completion: @escaping (String?) -> ()) {
        if let fieldFillingError = checkUsersData(name: name, email: email, password: password, confirmPassword: confirmPassword) {
            completion(fieldFillingError)
            return
        }
        guard let email = email,
            let password = password else {
                completion("Заполните все поля")
                return
        }
        Auth.auth().createUser(withEmail: email, password: password) { (_, error) in
            if error != nil {
                completion("Возникли некоторые сложности, попробуйте чуть позже")
            } else {
                completion(nil)
            }
        }
    }
}
