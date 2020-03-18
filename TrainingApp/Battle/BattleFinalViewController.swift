//
//  BattleFinalViewController.swift
//  TrainingApp
//
//  Created by мак on 16/03/2020.
//  Copyright © 2020 мак. All rights reserved.
//

import UIKit

class BattleFinalViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var finishButton: UIButton!
    @IBOutlet var userAnswersImages: [UIImageView]!
    @IBOutlet var opponentsAnswersImages: [UIImageView]!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var gamesNumberLabel: UILabel!
    
    var userAnswers = [Int]()
    var opponentsAnswers = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        designScreenElements()
    }
    
    func designScreenElements() {
        DesignService.setGradient(for: view)
        DesignService.designBlueButton(finishButton)
        designResultLabel()
        setupScore()
        setupAnswersImages()
    }
    
    func setupScore() {
        var usersScore = 0
        var opponentsScore = 0
        for index in stride(from: 0, to: userAnswers.count, by: 1) {
            usersScore += userAnswers[index]
            opponentsScore += opponentsAnswers[index]
        }
        scoreLabel.text = "\(usersScore):\(opponentsScore)"
    }
    
    func setupAnswersImages() {
        let answers = [#imageLiteral(resourceName: "close"), #imageLiteral(resourceName: "checked")]
        for index in stride(from: 0, to: userAnswers.count, by: 1) {
            userAnswersImages[index].image = answers[userAnswers[index]]
            opponentsAnswersImages[index].image = answers[opponentsAnswers[index]]
        }
    }
    
    func designResultLabel() {
        let shadows = UIView()
        shadows.frame = resultLabel.frame
        shadows.clipsToBounds = false
        resultLabel.addSubview(shadows)

        let shadowPath = UIBezierPath(roundedRect: shadows.bounds, cornerRadius: 0)
        let layer = CALayer()
        layer.shadowPath = shadowPath.cgPath
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        layer.shadowOpacity = 1
        layer.shadowRadius = 4
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.bounds = shadows.bounds
        layer.position = shadows.center
        shadows.layer.addSublayer(layer)
        resultLabel.textColor = UIColor(red: 0, green: 0.776, blue: 0.369, alpha: 0.99)
    }
    @IBAction func finishTapped(_ sender: UIButton) {
        view.window?.rootViewController?.dismiss(animated: true)
    }
}
