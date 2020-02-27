//
//  ListTableViewCell.swift
//  todolist
//
//  Created by Huiyi Victoria Lyu on 2/26/20.
//  Copyright © 2020 Huiyi Victoria Lyu. All rights reserved.
//

import UIKit
protocol ListTableViewCellDelegate: class {
    func checkBoxToggle(sender: ListTableViewCell)
    
}
class ListTableViewCell: UITableViewCell {
    
    
    weak var delegate: ListTableViewCellDelegate?

    @IBOutlet weak var checkBoxBotton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    
    
    @IBAction func checkToggled(_ sender: UIButton) {
        delegate?.checkBoxToggle(sender: self)
    }
    
}


