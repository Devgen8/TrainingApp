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
    @IBOutlet weak var genderSwitchControl: UISegmentedControl!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        designScreenElements()
    }
    
    func designScreenElements() {
        DesignService.styleTextField(nameTextField)
        DesignService.styleTextField(emailTextField)
        DesignService.styleTextField(passwordTextField)
        DesignService.styleTextField(confirmPasswordTextField)
        DesignService.styleFilledButton(signUpButton)
        errorLabel.isHidden = true
    }
}
