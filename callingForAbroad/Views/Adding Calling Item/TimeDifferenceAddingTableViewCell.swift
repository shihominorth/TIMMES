//
//  JetLagTableViewCell.swift
//  checklist
//
//  Created by 北島　志帆美 on 2019-12-18.
//  Copyright © 2019 北島　志帆美. All rights reserved.
//

import UIKit

class TimeDifferenceAddingTableViewCell: UITableViewCell {

    
    @IBOutlet weak var timeDifferenceLabel: UILabel!
    @IBOutlet weak var questionLabel:UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        questionLabel.text = "The time difference"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
