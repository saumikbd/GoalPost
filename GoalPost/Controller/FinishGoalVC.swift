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
    @IBOutlet weak var pointsLabel: UITextField!
    
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
    @IBAction func createGoalButtonTapped(_ sender: Any) {
        if pointsLabel.text != "" {
            self.save(completion: { (success) in
                if success {
                    print("Goal Added Successfully")
                    self.dismiss(animated: true, completion: nil)
                }
            })
        }
    }
    
    func save(completion: @escaping CompletionHandler){
        guard let managedContext = appDelegate?.persistentContainer.viewContext else{return}
        let goal = Goal(context: managedContext)
        goal.goalDescription = goalDescription
        goal.goalType = goalType.rawValue
        goal.goalCompletionValue = Int32(pointsLabel.text!)!
        goal.goalProgress = 0
        
        do{
            try managedContext.save()
            completion(true)
        } catch {
            debugPrint(error.localizedDescription)
            completion(false)
        }
    }
    
}
