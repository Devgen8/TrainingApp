//
//  BattleFinalViewModel.swift
//  TrainingApp
//
//  Created by мак on 22/03/2020.
//  Copyright © 2020 мак. All rights reserved.
//

import Foundation

class BattleFinalViewModel {
    
    var userAnswers = [Bool]()
    var opponentsAnswers = [Bool]()
    var wonBattle: Bool?
    var opponentsName: String?
    var numberOfPlays: Int?
    
    func getScore() -> String {
        var usersScore = 0
        var opponentsScore = 0
        for index in stride(from: 0, to: userAnswers.count, by: 1) {
            usersScore += userAnswers[index] ? 1 : 0
            opponentsScore += opponentsAnswers[index] ? 1 : 0
        }
        if usersScore > opponentsScore {
            wonBattle = true
        } else if usersScore < opponentsScore {
            wonBattle = false
        }
        return "\(usersScore):\(opponentsScore)"
    }
    
    func getResultPhrase() -> String {
        if wonBattle == nil {
            return "Ничья +5 баллов"
        } else {
            if wonBattle == true {
                return "Победа +10 баллов"
            } else {
                return "Поражение -5 баллов"
            }
        }
    }
    
    func getOpponentsName() -> String? {
        return opponentsName
    }
    
}
