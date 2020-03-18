//
//  TaskViewController.swift
//  TrainingApp
//
//  Created by мак on 16/03/2020.
//  Copyright © 2020 мак. All rights reserved.
//

import UIKit

class TaskViewController: UIViewController {

    @IBOutlet weak var themeLabel: UILabel!
    @IBOutlet weak var taskNumberLabel: UILabel!
    @IBOutlet weak var taskImage: UIImageView!
    @IBOutlet weak var answerTextField: UITextField!
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var writeButton: UIButton!
    
    var theme = "Механика"
    var taskNumber = 1
    var allTasksNumber = 67
    
    override func viewDidLoad() {
        super.viewDidLoad()
        designScreenElements()
    }
    
    func designScreenElements() {
        DesignService.setGradient(for: view)
        themeLabel.text = theme
        taskNumberLabel.text = "Задача \(taskNumber) из \(allTasksNumber)"
        taskImage.image = #imageLiteral(resourceName: "img3")
        taskImage.layer.cornerRadius = 30
        DesignService.designBlueButton(checkButton)
        checkButton.layer.cornerRadius = 5
        resultLabel.textColor = UIColor(displayP3Red: 0, green: 0.78, blue: 0.37, alpha: 0.99)
        DesignService.designWhiteButton(skipButton)
        DesignService.designWhiteButton(writeButton)
        writeButton.layer.cornerRadius = 0.5 * writeButton.bounds.size.width
        writeButton.imageEdgeInsets = UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)
        resultLabel.alpha = 0
    }
    
    @IBAction func backTapped(_ sender: UIButton) {
        modalTransitionStyle = .flipHorizontal
        dismiss(animated: true)
    }
    
    @IBAction func checkTapped(_ sender: UIButton) {
    }
    @IBAction func skipTapped(_ sender: UIButton) {
    }
    
    @IBAction func writeTapped(_ sender: UIButton) {
        let formSheetViewController = FormSheetViewController()
        present(formSheetViewController, animated: true)
    }
    
    @IBAction func imageTapped(_ sender: UITapGestureRecognizer) {
        let imagePreviewViewController = ImagePreviewViewController()
        imagePreviewViewController.taskImage = taskImage.image
        imagePreviewViewController.modalPresentationStyle = .fullScreen
        present(imagePreviewViewController, animated: true)
    }
}
