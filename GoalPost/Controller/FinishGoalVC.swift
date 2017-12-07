//
//  FinishGoalVC.swift
//  GoalPost
//
//  Created by Sadman Sakib Saumik on 8/12/17.
//  Copyright © 2017 Sadman Sakib Saumik. All rights reserved.
//

import UIKit

class FinishGoalVC: UIViewController {
    
    
    @IBOutlet weak var createGoalButton: UIButton!
    var goalDescription: String!
    var goalType: GoalType!
    
    func initData(description: String, type: GoalType){
        self.goalDescription = description
        self.goalType = type
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        createGoalButton.bindToKeyboard()
    }
    @IBAction func backButtonTapped(_ sender: Any) {
        dismissDetail()
    }
    
    
}
