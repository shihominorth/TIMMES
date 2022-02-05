//
//  TableViewCell.swift
//  checklist
//
//  Created by 北島　志帆美 on 2019-12-17.
//  Copyright © 2019 北島　志帆美. All rights reserved.
//

import UIKit

class JetLagTableViewCell: UITableViewCell {

    @IBOutlet weak var jetLagLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    
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
