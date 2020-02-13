//
//  DesignService.swift
//  TrainingApp
//
//  Created by мак on 12/02/2020.
//  Copyright © 2020 мак. All rights reserved.
//

import UIKit

class DesignService {
    static func styleTextField(_ textField: UITextField) {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: textField.frame.height - 2, width: textField.frame.width, height: 2)
        bottomLine.backgroundColor = UIColor.init(red: 48/255, green: 173/255, blue: 99/255, alpha: 1).cgColor
        textField.borderStyle = .none
        textField.layer.addSublayer(bottomLine)
        textField.attributedPlaceholder = NSAttributedString(string: textField.placeholder ?? "Text", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
    }
    
    static func styleFilledButton(_ button: UIButton) {
        button.backgroundColor = UIColor.systemGreen
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.white
    }
    
    static func styleHollowButton(_ button: UIButton) {
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.white
    }
    
//    static func getCellsLayout() -> UICollectionViewFlowLayout {
//        let itemSize = UIScreen.main.bounds.width/2 - 2
//        let layout = UICollectionViewFlowLayout()
//        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
//        layout.itemSize = CGSize(width: itemSize, height: itemSize)
//        layout.minimumInteritemSpacing = 2
//        layout.minimumLineSpacing = 2
//        return layout
//    }
}
