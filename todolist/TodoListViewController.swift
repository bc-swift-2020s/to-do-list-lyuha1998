//
//  ViewController.swift
//  todolist
//
//  Created by Huiyi Victoria Lyu on 2/5/20.
//  Copyright © 2020 Huiyi Victoria Lyu. All rights reserved.
//

import UIKit

class TodoListViewController: UIViewController {
    
    //var toDoItems: [ToDoItem] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var addBottom: UIBarButtonItem!
    
    
    var toDoItems = ToDoItems()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        
        tableView.dataSource = self
    
        toDoItems.loadData {
            self.tableView.reloadData()
        }
        
        autherizeLocalNotifications ()
        
        
        
    }
    
    func autherizeLocalNotifications () { UNUserNotificationCenter
        .current().requestAuthorization(options: [.alert,.sound,.badge]) { (granted, error) in
            guard error == nil else {
                print("Error!")
                return
            }
            if granted {
                print("Granted")
                
            } else {
                print("User has denied notifications!")
                
            }
        }
    }
    
    func  setNotifications()
    {guard toDoItems.itemsArray.count > 0 else {
        return
        }
        
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        
        for index in 0..<toDoItems.itemsArray.count {
            if toDoItems.itemsArray[index].reminderSet {
                let toDoItem = toDoItems.itemsArray[index]
                toDoItems.itemsArray[index].notificationID = setCalendarNotification(title: toDoItem.name ,  subtitle: "", body: toDoItem.notes, badgeNumber: nil, sound: .default, date: toDoItem.date)
            }
        }
        
    }
    func setCalendarNotification(title:String, subtitle:String, body: String, badgeNumber: NSNumber?, sound: UNNotificationSound?, date:Date) -> String {
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = subtitle
        content.body = body
        content.sound = sound
        content.badge = badgeNumber
        
        
        //create trigger
        var dateComponents = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        // create request
        let notificationID = UUID().uuidString
        let request = UNNotificationRequest(identifier: notificationID, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) {
            (error) in
            if let error = error {
                print("ERROR!!!")
            } else {
                print("Notification scheduled!")
            }
        }
        return notificationID
    }
    
    
    

    
    
    func saveData () {
        toDoItems.saveData()
        setNotifications()
    }
    
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //display details under namefield
        
        
        if segue.identifier == "ShowDetails" {
            let destination = segue.destination as! TODODETAILSTableViewController
            
            let selectedIndexPath = tableView.indexPathForSelectedRow!
            
            destination.toDoItem = toDoItems.itemsArray[selectedIndexPath.row]
        } else{
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow
            {tableView.deselectRow(at: selectedIndexPath, animated: true)
                
            }
        }
        
    }
    
    @IBAction func unwindFromDetail (segue: UIStoryboardSegue)   {
        // if you wanna change items you just clicked under name field, remember the exit signs!!!!!!!
        let source = segue.source as! TODODETAILSTableViewController
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            toDoItems.itemsArray[selectedIndexPath.row] = source.toDoItem
            
            tableView.reloadRows(at: [selectedIndexPath], with: .automatic
            )
        } else {
            let newIndexPath = IndexPath(row:toDoItems.itemsArray.count,section: 0)
            toDoItems.itemsArray.append(source.toDoItem)
            tableView.insertRows(at: [newIndexPath], with: .bottom)
            tableView.scrollToRow(at: newIndexPath, at: .bottom, animated: true)
        }
        saveData()
        
    }
    
    
    
    @IBAction func EditBottonPressed(_ sender: UIBarButtonItem) {
        
        if tableView.isEditing{
            tableView.setEditing(false, animated: true)
            sender.title = "Edit"
            addBottom.isEnabled = true
            
            
        } else {
            
            tableView.setEditing(true, animated: true)
            sender.title = "Done"
            addBottom.isEnabled = false
            
            
            
        }
        
        
        
    }
    
}
//extension needed for protocol,



extension TodoListViewController: UITableViewDelegate, UITableViewDataSource, ListTableViewCellDelegate  {
    
    
    
    func checkBoxToggle(sender: ListTableViewCell) {
        
        if let selectedIndexPath = tableView.indexPath(for: sender) {
           toDoItems.itemsArray[selectedIndexPath.row].completed = !toDoItems.itemsArray[selectedIndexPath.row].completed
            tableView.reloadRows(at: [selectedIndexPath], with: .automatic)
            saveData()
        }
         
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItems.itemsArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)as! ListTableViewCell
        cell.delegate = self
        cell.toDoItem = toDoItems.itemsArray[indexPath.row]
        return cell
        
        
        
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            toDoItems.itemsArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            saveData()
            
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let itemToMove = toDoItems.itemsArray[sourceIndexPath.row]
        toDoItems.itemsArray.remove(at: sourceIndexPath.row)
        toDoItems.itemsArray.insert(itemToMove, at: destinationIndexPath.row)
        saveData()
        
    }
}








