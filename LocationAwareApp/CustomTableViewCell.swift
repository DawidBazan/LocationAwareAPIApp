//
//  CustomTableViewCell.swift
//  AssignmentApp
//
//  Created by Dawid  on 29/01/2018.
//  Copyright © 2018 Dawid Bazan. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var imageCell: UIImageView!
    @IBOutlet weak var labelCell: UILabel!
    @IBOutlet weak var labelCell2: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
