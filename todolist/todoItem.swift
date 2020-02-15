//
//  todoItem.swift
//  todolist
//
//  Created by Huiyi Victoria Lyu on 2/9/20.
//  Copyright © 2020 Huiyi Victoria Lyu. All rights reserved.
//

import Foundation
struct ToDoItem: Codable {
       var name: String
       var date: Date
       var notes: String!
    var reminderSet:Bool
   }
