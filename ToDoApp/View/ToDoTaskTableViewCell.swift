//
//  ToDoTaskTableViewCell.swift
//  ToDoApp
//
//  Created by Ivan Nieto on 24/09/22.
//

import UIKit

class ToDoTaskTableViewCell: UITableViewCell {

    @IBOutlet var taskTitleLabel: UILabel!
    var taskUUID : String?
    var taskTitle: String?
    var taskDate: Date?
    var taskNotes: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
