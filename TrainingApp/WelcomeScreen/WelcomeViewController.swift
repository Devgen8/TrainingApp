//
//  WelcomeViewController.swift
//  TrainingApp
//
//  Created by мак on 12/02/2020.
//  Copyright © 2020 мак. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        designScreenElements()
    }
    
    func designScreenElements() {
        DesignService.styleFilledButton(signInButton)
        DesignService.styleHollowButton(signUpButton)
    }
    
    @IBAction func signInTapped(_ sender: UIButton) {
        let signInViewController = SignInViewController()
        present(signInViewController, animated: true)
    }
    
    @IBAction func signUpTapped(_ sender: UIButton) {
        
    }
}
