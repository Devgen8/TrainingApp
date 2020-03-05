//
//  SignInViewController.swift
//  TrainingApp
//
//  Created by мак on 12/02/2020.
//  Copyright © 2020 мак. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    var viewModel = SignInViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        designScreenElements()
    }
    
    func designScreenElements() {
        DesignService.styleTextField(emailTextField)
        DesignService.styleTextField(passwordTextField)
        DesignService.styleFilledButton(signInButton)
        errorLabel.isHidden = true
    }
    
    @IBAction func signInTapped(_ sender: UIButton) {
        guard
            let email = emailTextField.text,
            let password = passwordTextField.text else {
                self.showError("Please fill in all fields")
                return
        }
        viewModel.authorizeUser(email: email, password: password) { [weak self] (permission) in
            guard let self = self else { return }
            if permission == true {
                let studentViewController = TabBarViewController()
                studentViewController.modalPresentationStyle = .fullScreen
                self.present(studentViewController, animated: true)
            } else {
                self.showError("There is no such a user. Sign up, please")
            }
        }
    }
    
    func showError(_ error: String) {
        errorLabel.isHidden = false
        errorLabel.text = error
    }
}
