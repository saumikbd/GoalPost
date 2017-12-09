//
//  ViewController.swift
//  GoalPost
//
//  Created by Sadman Sakib Saumik on 7/12/17.
//  Copyright © 2017 Sadman Sakib Saumik. All rights reserved.
//

import UIKit
import CoreData

class GoalVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var goals = [Goal]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        fetch { (success) in
            if success {
                if goals.count >= 1 {
                    self.tableView.isHidden = false
                    tableView.reloadData()
                } else {
                    self.tableView.isHidden = true
                }
            }
        }
        
    }

    @IBAction func addGoalsButtonPressed(_ sender: Any) {
        guard let createGoalVC = storyboard?.instantiateViewController(withIdentifier: "createGoalVC") as? CreateGoalVC else {return}
        presentDetail(createGoalVC)
    }
    
}

extension GoalVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goals.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)-> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "goalCell") as? GoalCell else {return UITableViewCell()}
        //cell.updateCell(description: "Push up 8 days a month and at least 50 days a year", type: .longTerm, amount: 7)
        let goal = goals[indexPath.row]
        cell.updateCell(goal: goal)
        return cell
    }
}

extension GoalVC {
    func fetch(completion: CompletionHandler){
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        let fetchRequest = NSFetchRequest<Goal>(entityName: "Goal")
        do {
            goals = try managedContext.fetch(fetchRequest)
            completion(true)
        } catch{
            debugPrint(error.localizedDescription)
            completion(false)
        }
        
    }
}

