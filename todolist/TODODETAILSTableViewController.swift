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
        
        
        
        
        //hide key board if we click else where!!!! UX tips!!!!
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        
        NameField.delegate = self
        
        
        
        
        
        
        if toDoItem == nil {
            toDoItem = ToDoItem(name: " ", date: Date().addingTimeInterval(24*60*60), notes: "", reminderSet: false,  completed: false )
            NameField.becomeFirstResponder()
            
        }
        NameField.text = toDoItem.name
        datepicker.date = toDoItem.date
        noteView.text = toDoItem.notes
        ReminderSwitch.isOn = toDoItem.reminderSet
        dateLabel.textColor = (ReminderSwitch.isOn ? .black : .gray)
        dateLabel.text = dateFormatter.string(from: toDoItem.date)
        enableDisableSaveButton(text: NameField.text!)
        
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        toDoItem = ToDoItem(name:NameField.text!, date: datepicker.date, notes: noteView.text,reminderSet:ReminderSwitch.isOn, completed: toDoItem.completed )
        
    }
    
    func enableDisableSaveButton (text:String) {
        if text .count>0 {
           
            SaveBottonPressed.isEnabled = true
        } else {
             SaveBottonPressed.isEnabled = false
        }
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
        self.view.endEditing(true)
        dateLabel.textColor = (ReminderSwitch.isOn ? .black : .gray)
        tableView.beginUpdates()
        tableView.endUpdates()
        
    }
    
    
    @IBAction func datePickerChanged(_ sender: Any) {
        self.view.endEditing(true) // this line is for getting rid of keyboard when selecting amongst the calendar, same as above!!!
        dateLabel.text = dateFormatter.string(from:  (sender as AnyObject).date)
    }
    
    @IBAction func textfieldeditingchanged(_ sender: UITextField) {
        enableDisableSaveButton(text: sender.text!)
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
 

//type return jum from to do item to Notes!!! UX design tips::)))
 
extension TODODETAILSTableViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        noteView.becomeFirstResponder()
        return true
    }
}
