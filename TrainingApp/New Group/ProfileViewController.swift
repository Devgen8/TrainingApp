//
//  ProfileViewController.swift
//  TrainingApp
//
//  Created by мак on 18/03/2020.
//  Copyright © 2020 мак. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var awardsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        designScreenElements()
    }
    
    func designScreenElements() {
        DesignService.setGradient(for: view)
        userImage.layer.cornerRadius = 20
        ratingLabel.layer.cornerRadius = 10
        ratingLabel.textColor = UIColor(displayP3Red: 0, green: 0.57, blue: 0.85, alpha: 1)
        ratingLabel.clipsToBounds = true
    }
}
