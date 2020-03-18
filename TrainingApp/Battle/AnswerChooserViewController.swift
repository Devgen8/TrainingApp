//
//  AnswerChooserViewController.swift
//  TrainingApp
//
//  Created by мак on 13/03/2020.
//  Copyright © 2020 мак. All rights reserved.
//

import UIKit

class AnswerChooserViewController: UIViewController {

    @IBOutlet weak var clockView: UIView!
    @IBOutlet weak var opponentsNameLabel: UILabel!
    @IBOutlet var userAnswerImages: [UIImageView]!
    @IBOutlet var opponentsAnswerImages: [UIImageView]!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var questionNumberLabel: UILabel!
    @IBOutlet weak var questionImage: UIImageView!
    @IBOutlet var answerButtons: [UIButton]!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet var opponentsLetters: [UILabel]!
    
    let clock = CAShapeLayer()
    let answerDuration = 15.0
    var currentDuration = 15.0
    let timeDifference = 0.01
    var timer = Timer()
    var questionNumber = 0
    var answers = [["100 км/ч", "50 км/ч", "150 км/ч", "30 км/ч"], ["40 км/ч", "60 км/ч", "70 км/ч", "80 км/ч"]]
    var rightAnswer = "100 км/ч"
    var computersAnswer = "50 км/ч"
    var userAnswers = [1, 1, 1, 1, 1]
    var opponensAnswers = [1, 1, 1, 1, 1]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        designScreen()
        questionUpdate()
        startClockAnimation()
        prepareData()
    }
    
    func prepareData() {
        questionImage.image = questionNumber == 0 ? #imageLiteral(resourceName: "pic39") : #imageLiteral(resourceName: "unnamed")
        var count = 0
        for button in answerButtons {
            button.setTitle(answers[questionNumber][count], for: .normal)
            count += 1
        }
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: timeDifference, repeats: true) { [weak self] (_) in
            guard let `self` = self else { return }
            self.currentDuration -= self.timeDifference
            let precentage = 1.0 - Float(self.currentDuration) / Float(self.answerDuration)
            self.clock.strokeEnd = CGFloat(precentage - precentage * 0.16)
            self.timeLabel.text = "\(Int(self.currentDuration))"
            if self.currentDuration <= 0 {
                self.timer.invalidate()
                self.userAnswerImages[self.questionNumber].image = #imageLiteral(resourceName: "close")
                self.userAnswers[self.questionNumber] = 0
                self.showRightAnswer()
            }
        }
    }
    
    func showRightAnswer() {
        if rightAnswer != computersAnswer {
            opponentsAnswerImages[questionNumber].image = #imageLiteral(resourceName: "close")
            opponensAnswers[questionNumber] = 0
        }
        UIView.animate(withDuration: 1.5) {
            self.nextButton.alpha = 1
            self.opponentsAnswerImages[self.questionNumber].alpha = 1
            self.userAnswerImages[self.questionNumber].alpha = 1
        }
        for button in answerButtons {
            if button.titleLabel?.text == rightAnswer {
                button.layer.borderWidth = 5
                button.layer.borderColor = UIColor.green.cgColor
                UIView.animate(withDuration: 1) {
                    UIView.setAnimationRepeatCount(2)
                    button.backgroundColor = .green
                    button.backgroundColor = .white
                }
            }
        }
    }
    
    func designScreen() {
        DesignService.setGradient(for: view)
        DesignService.designBlueButton(nextButton)
        questionImage.layer.cornerRadius = 30
        for button in answerButtons {
            button.layer.cornerRadius = 15
            button.backgroundColor = .white
        }
        for index in stride(from: 0, to: userAnswerImages.count, by: 1) {
            userAnswerImages[index].alpha = 0
            opponentsAnswerImages[index].alpha = 0
        }
    }
    
    func questionUpdate() {
        questionNumberLabel.text = "Вопрос \(questionNumber + 1)/5"
        rightAnswer = answers[questionNumber][0]
        computersAnswer = answers[questionNumber][1]
        for button in answerButtons {
            button.layer.borderWidth = 0
            button.backgroundColor = .white
        }
        for letter in opponentsLetters {
            letter.alpha = 0
        }
        nextButton.alpha = 0
        UIView.transition(with: questionImage, duration: 1, options: .transitionFlipFromLeft, animations: nil, completion: nil)
        for button in answerButtons {
            UIView.transition(with: button, duration: 1, options: .transitionFlipFromLeft, animations: nil, completion: nil)
        }
        prepareData()
        currentDuration = answerDuration
        startTimer()
    }
    
    func startClockAnimation() {
        let radius = 0.4 * clockView.frame.size.width
        let center = clockView.center
        let circularPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: CGFloat(-Float.pi / 2), endAngle: CGFloat(2 * Float.pi), clockwise: true)
        
        let trackLayer = CAShapeLayer()
        trackLayer.path = circularPath.cgPath
        trackLayer.strokeColor = #colorLiteral(red: 0.512926101, green: 0.7700839616, blue: 1, alpha: 1)
        trackLayer.lineWidth = 5
        trackLayer.fillColor = UIColor.clear.cgColor
        view.layer.addSublayer(trackLayer)
        
        clock.path = circularPath.cgPath
        clock.strokeColor = UIColor.white.cgColor
        clock.lineWidth = 5
        clock.fillColor = UIColor.clear.cgColor
        clock.lineCap = .round
        clock.strokeEnd = 0
        view.layer.addSublayer(clock)
    }
    @IBAction func userAnswered(_ sender: UIButton) {
        timer.invalidate()
        var labelNumber = 0
        for button in answerButtons {
            if computersAnswer == button.titleLabel?.text {
                UIView.animate(withDuration: 1.5) {
                    let letter = self.opponentsNameLabel.text?.first
                    self.opponentsLetters[labelNumber].text = String([(letter ?? "O"), "."])
                    self.opponentsLetters[labelNumber].alpha = 1
                }
            }
            labelNumber += 1
        }
        if sender.titleLabel?.text != rightAnswer {
            sender.backgroundColor = .red
            userAnswerImages[questionNumber].image = #imageLiteral(resourceName: "close")
            userAnswers[questionNumber] = 0
        }
        showRightAnswer()
    }
    
    @IBAction func nextTapped(_ sender: UIButton) {
        if questionNumber == 1 {
            let battleFinalViewController = BattleFinalViewController()
            battleFinalViewController.userAnswers = userAnswers
            battleFinalViewController.opponentsAnswers = opponensAnswers
            battleFinalViewController.modalPresentationStyle = .fullScreen
            present(battleFinalViewController, animated: true)
        } else {
            questionNumber += 1
            questionUpdate()
        }
    }
}
