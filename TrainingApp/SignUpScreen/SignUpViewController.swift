//
//  SignUpViewController.swift
//  TrainingApp
//
//  Created by мак on 13/02/2020.
//  Copyright © 2020 мак. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    let signUpViewModel = SignUpViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        designScreenElements()
    }
    
    func designScreenElements() {
        DesignService.setGradient(for: view)
        DesignService.designBlueButton(signUpButton)
        errorLabel.isHidden = true
    }
    
    @IBAction func signUpTapped(_ sender: UIButton) {
        signUpViewModel.createUser(name: nameTextField.text,
                                   email: emailTextField.text,
                                   password: passwordTextField.text,
                                   confirmPassword: confirmPasswordTextField.text) { [weak self] (error) in
                                    guard let `self` = self else { return }
                                    guard error == nil else {
                                        self.showError(error)
                                        return
                                    }
                                    //self.navigationController?.modalPresentationStyle = .fullScreen
                                    self.present(TabBarViewController(), animated: true)
        }
    }
    
    func showError(_ error: String?) {
        errorLabel.isHidden = false
        errorLabel.text = error
    }
}
