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
    @IBOutlet weak var completionView: UIView!
    
    func updateCell(goal: Goal){
        self.goalDescription.text = goal.goalDescription
        self.goalType.text = goal.goalType
        self.goalAmount.text = String(goal.goalProgress)
        
        if goal.goalCompletionValue == goal.goalProgress {
            completionView.isHidden = false
        } else {
            completionView.isHidden = true
        }
    }
    
}
