//
//  NotificaitonTableViewCell.swift
//  checklist
//
//  Created by 北島　志帆美 on 2020-02-10.
//  Copyright © 2020 北島　志帆美. All rights reserved.
//

import UIKit

class NotificaitonTableViewCell: UITableViewCell {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var notificateTimelabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        questionLabel.text = "Notification before..."

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
