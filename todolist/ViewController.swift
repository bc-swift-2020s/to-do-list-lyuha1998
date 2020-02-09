//
//  ViewController.swift
//  todolist
//
//  Created by Huiyi Victoria Lyu on 2/5/20.
//  Copyright © 2020 Huiyi Victoria Lyu. All rights reserved.
//

import UIKit

class TodoListViewController: UIViewController {
    
    
    
    
    var todolistArray = ["Hello", "Learn Swift", "Take Vocation","Love you"]

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.dataSource = self
        tableView.delegate = self
        
        
    }


}

//extension needed for protocol,
extension TodoListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todolistArray.count
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = todolistArray[indexPath.row]
        
        
        return cell
}
}

