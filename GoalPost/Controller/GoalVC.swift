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
       // tableView.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        fetchGoalObjects()
        tableView.reloadData()
    }
    
    func fetchGoalObjects() {
        fetch { (success) in
            if success {
                if goals.count >= 1 {
                    self.tableView.isHidden = false
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
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .none
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "DELETE") { (rowAction, indexPath) in
            self.removeGoal(atIndexPath: indexPath)
            self.fetchGoalObjects()
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        }
        let addAction = UITableViewRowAction(style: UITableViewRowActionStyle.normal, title: "ADD 1") { (rowAction, indexPath) in
            self.setGoalProgress(atIndexPath: indexPath)
            self.tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        }
        
        addAction.backgroundColor = #colorLiteral(red: 0.9597846866, green: 0.6503693461, blue: 0.1371207833, alpha: 1)
        deleteAction.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        if(goals[indexPath.row].goalCompletionValue==goals[indexPath.row].goalProgress){
            return [deleteAction]
        }
        return [deleteAction, addAction]
    }
}

extension GoalVC {
    func setGoalProgress(atIndexPath indexPath: IndexPath){
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        let selectedGoal = goals[indexPath.row]
        if selectedGoal.goalProgress < selectedGoal.goalCompletionValue{
            selectedGoal.goalProgress = selectedGoal.goalProgress + 1
        } else {
            return
        }
        do{
            try managedContext.save()
        }catch{
            debugPrint(error.localizedDescription)
        }
        
    }
    
    func removeGoal(atIndexPath indexPath: IndexPath){
        guard let managedCotext = appDelegate?.persistentContainer.viewContext else {return}
        managedCotext.delete(goals[indexPath.row])
        do {
            try managedCotext.save()
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
    
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

