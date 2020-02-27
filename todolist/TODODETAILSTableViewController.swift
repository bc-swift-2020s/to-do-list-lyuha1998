//
//  TODODETAILSTableViewController.swift
//  todolist
//
//  Created by Huiyi Victoria Lyu on 2/6/20.
//  Copyright © 2020 Huiyi Victoria Lyu. All rights reserved.
//

import UIKit

private let dateFormatter: DateFormatter = {
    print("I JUST CREATED A DATE FORMATTER!")
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .short
    dateFormatter.timeStyle = .short
    return dateFormatter
} ()

class TODODETAILSTableViewController: UITableViewController {
    
    
    
    
    @IBOutlet weak var SaveBottonPressed: UIBarButtonItem!
    
    @IBOutlet weak var NameField: UITextField!
    
    @IBOutlet weak var datepicker: UIDatePicker!
    
    
    @IBOutlet weak var noteView: UITextView!
    
    @IBOutlet weak var ReminderSwitch: UISwitch!
    
    
    @IBOutlet weak var dateLabel: UILabel!
    
    var toDoItem: ToDoItem!
    
    
    
    let datePickerIndexPath = IndexPath(row: 1, section: 1)
    let notesTextViewIndexPath = IndexPath(row: 0, section: 2)
    let notesRowHeight : CGFloat = 200
    let defaultRowHeight: CGFloat = 44
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        if toDoItem == nil {
            toDoItem = ToDoItem(name: " ", date: Date().addingTimeInterval(24*60*60), notes: "", reminderSet: false,  completed: false )
        }
        NameField.text = toDoItem.name
        datepicker.date = toDoItem.date
        noteView.text = toDoItem.notes
        ReminderSwitch.isOn = toDoItem.reminderSet
        dateLabel.textColor = (ReminderSwitch.isOn ? .black : .gray)
        dateLabel.text = dateFormatter.string(from: toDoItem.date)
        
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        toDoItem = ToDoItem(name:NameField.text!, date: datepicker.date, notes: noteView.text,reminderSet:ReminderSwitch.isOn, completed: toDoItem.completed )
        
    }
    
    
    @IBAction func cancelbottonpressed(_ sender: UIBarButtonItem) {
        
        
        let isPresentingInAddMode = presentingViewController is UINavigationController
        
        if isPresentingInAddMode {
            dismiss(animated: true, completion: nil)
        }else {
            navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func reminderSwitchChanged(_ sender: Any) {
        dateLabel.textColor = (ReminderSwitch.isOn ? .black : .gray)
        tableView.beginUpdates()
        tableView.endUpdates()
        
    }
    
    
    @IBAction func datePickerChanged(_ sender: Any) {
        dateLabel.text = dateFormatter.string(from:  (sender as AnyObject).date)
    }
    
}
    
extension TODODETAILSTableViewController {
        
        override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            switch indexPath {
            case IndexPath(row: 1, section: 1):
                return ReminderSwitch.isOn ?  datepicker.frame.height:0
            case notesTextViewIndexPath:
                return notesRowHeight
            default:
                return defaultRowHeight
            }

        }
    }

