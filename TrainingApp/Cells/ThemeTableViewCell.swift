//
//  ThemeTableViewCell.swift
//  TrainingApp
//
//  Created by мак on 16/03/2020.
//  Copyright © 2020 мак. All rights reserved.
//

import UIKit

class ThemeTableViewCell: UITableViewCell {

    @IBOutlet weak var decorativeView: UIView!
    @IBOutlet weak var themeName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        designScreenElements()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func designScreenElements() {
        decorativeView.layer.cornerRadius = 30
    }
    
}
