//
//  BattleViewController.swift
//  TrainingApp
//
//  Created by мак on 05/03/2020.
//  Copyright © 2020 мак. All rights reserved.
//

import UIKit

class BattleViewController: UIViewController {
    @IBOutlet weak var themeOutlet: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var themeImage: UIImageView!
    @IBOutlet weak var opponentsName: UILabel!
    @IBOutlet weak var themeLabel: UILabel!
    @IBOutlet weak var playingWithYouLabel: UILabel!
    
    var viewModel = BattleViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        designScreen()
        prepareData()
        
    }
    
    func designScreen() {
        DesignService.setGradient(for: view)
        DesignService.designBlueButton(playButton)
        themeOutlet.isHidden = true
        themeImage.isHidden = true
        themeImage.layer.cornerRadius = 30
        opponentsName.isHidden = true
        themeLabel.alpha = 0
        playingWithYouLabel.alpha = 0
    }
    
    func prepareData() {
        viewModel.getTheme { [weak self] (theme, image) in
            if let `self` = self, let theme = theme, let image = image {
                self.themeOutlet.text = theme
                self.themeImage.image = image
            }
        }
        opponentsName.text = viewModel.getName()
    }
    
    func returnFirstState() {
        prepareData()
        playButton.setTitle("Играть", for: .normal)
    }
    
    @IBAction func playTapped(_ sender: UIButton) {
        if playButton.titleLabel?.text == "Играть" {
            themeOutlet.isHidden = false
            UIView.transition(with: themeOutlet, duration: 0.3, options: .transitionFlipFromLeft, animations: nil, completion: nil)
            themeImage.isHidden = false
            UIView.transition(with: themeImage, duration: 0.3, options: .transitionFlipFromLeft, animations: nil, completion: nil)
            opponentsName.isHidden = false
            UIView.transition(with: opponentsName, duration: 0.3, options: .transitionFlipFromLeft, animations: nil, completion: nil)
            UIView.animate(withDuration: 1) {
                self.playingWithYouLabel.alpha = 1
                self.themeLabel.alpha = 1
                self.playButton.setTitle("Поехали!", for: .normal)
            }
        } else {
            designScreen()
            returnFirstState()
            let answerChooserViewController = AnswerChooserViewController()
            answerChooserViewController.modalPresentationStyle = .fullScreen
            present(answerChooserViewController, animated: true)
        }
    }
}
