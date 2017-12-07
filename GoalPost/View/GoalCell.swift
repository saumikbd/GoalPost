//
//  GoalCell.swift
//  GoalPost
//
//  Created by Sadman Sakib Saumik on 7/12/17.
//  Copyright © 2017 Sadman Sakib Saumik. All rights reserved.
//

import UIKit

class GoalCell: UITableViewCell {
    
    @IBOutlet weak var goalDescription: UILabel!
    @IBOutlet weak var goalType: UILabel!
    @IBOutlet weak var goalAmount: UILabel!
    
    func updateCell(description: String, type: goalType, amount: Int){
        self.goalDescription.text = description
        self.goalType.text = type.rawValue
        self.goalAmount.text = String(amount)
    }
    
}
