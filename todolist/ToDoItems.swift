//
//  ToDoItems.swift
//  todolist
//
//  Created by Huiyi Victoria Lyu on 2/27/20.
//  Copyright © 2020 Huiyi Victoria Lyu. All rights reserved.
//

import Foundation
class ToDoItems: Codable {
    var itemsArray: [ToDoItem] = []
    
    func saveData() {
        let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let documentURL = directoryURL.appendingPathComponent("todos").appendingPathExtension("json")
        
        let jsonEncoder = JSONEncoder()
        let data = try?jsonEncoder.encode(itemsArray)
        
        do {
            try data?.write(to:documentURL, options: .noFileProtection) }
        catch {
            print("ERROR: Could not save data \(error.localizedDescription)")
        }
        
        
        
    }
    
    func loadData(completed:@escaping  ()->()  ) {
       
                   let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                   let documentURL = directoryURL.appendingPathComponent("todos").appendingPathExtension("json")
                   
                   
                   guard let data = try? Data(contentsOf: documentURL) else {return}
                   let jsonDecoder = JSONDecoder ()
                   do {
                       itemsArray = try jsonDecoder.decode(Array<ToDoItem>.self, from:data)
                   
                       
                   } catch {
                       print("ERROR: Could not save data \(error.localizedDescription)")
                   }
                   completed()
}

}
