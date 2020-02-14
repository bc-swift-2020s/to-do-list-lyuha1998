//
//  TODODETAILSTableViewController.swift
//  todolist
//
//  Created by Huiyi Victoria Lyu on 2/6/20.
//  Copyright © 2020 Huiyi Victoria Lyu. All rights reserved.
//

import UIKit

class TODODETAILSTableViewController: UITableViewController {
    
    
    
    
    @IBOutlet weak var SaveBottonPressed: UIBarButtonItem!
    
    @IBOutlet weak var NameField: UITextField!
    
    @IBOutlet weak var datepicker: UIDatePicker!
    
    
    @IBOutlet weak var noteView: UITextView!
    
    
    var toDoItem: ToDoItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
      
        
        if toDoItem == nil {
           toDoItem = ToDoItem(name: "", date: Date(), notes: "")
        }
        NameField.text = toDoItem.name
        datepicker.date = toDoItem.date
        noteView.text = toDoItem.notes
        
        
    
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        toDoItem = ToDoItem(name:NameField.text!, date: datepicker.date, notes: noteView.text)
    }

   
    @IBAction func cancelbottonpressed(_ sender: UIBarButtonItem) {
        
        
        let isPresentingInAddMode = presentingViewController is UINavigationController
        
        if isPresentingInAddMode {
            dismiss(animated: true, completion: nil)
        }else {
            navigationController?.popViewController(animated: true)
        }
    }
}
