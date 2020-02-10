//
//  ViewController.swift
//  todolist
//
//  Created by Huiyi Victoria Lyu on 2/5/20.
//  Copyright © 2020 Huiyi Victoria Lyu. All rights reserved.
//

import UIKit

class TodoListViewController: UIViewController {
    
    var toDoItems: [ToDoItem] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var addBottom: UIBarButtonItem!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        
        tableView.dataSource = self
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //display details under namefield
        
        
        if segue.identifier == "ShowDetails" {
            let destination = segue.destination as! TODODETAILSTableViewController
            
            let selectedIndexPath = tableView.indexPathForSelectedRow!
            
            destination.toDoItem = toDoItems[selectedIndexPath.row]
        } else{
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow
            {tableView.deselectRow(at: selectedIndexPath, animated: true)
                
            }
        }
        
    }
    
    @IBAction func unwindFromDetail (segue: UIStoryboardSegue) {
        // if you wanna change items you just clicked under name field, remember the exit signs!!!!!!!
        let source = segue.source as! TODODETAILSTableViewController
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            toDoItems[selectedIndexPath.row] = source.toDoItem
            
            tableView.reloadRows(at: [selectedIndexPath], with: .automatic
            )
        } else {
            let newIndexPath = IndexPath(row:toDoItems.count,section: 0)
            toDoItems.append(source.toDoItem)
            tableView.insertRows(at: [newIndexPath], with: .bottom)
            tableView.scrollToRow(at: newIndexPath, at: .bottom, animated: true)
        }
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
    
    
    
extension TodoListViewController: UITableViewDelegate, UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return toDoItems.count
            
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            
            cell.textLabel?.text = toDoItems[indexPath.row].name
            
            
            return cell
        }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
           toDoItems.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
    }
        

    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let itemToMove = toDoItems[sourceIndexPath.row]
        toDoItems.remove(at: sourceIndexPath.row)
        toDoItems.insert(itemToMove, at: destinationIndexPath.row)
            
        }
    }
    
    
    
    

    
    
