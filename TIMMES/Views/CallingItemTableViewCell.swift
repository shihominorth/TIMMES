//
//  callingItemTableViewCell.swift
//  checklist
//
//  Created by 北島　志帆美 on 2019-12-20.
//  Copyright © 2019 北島　志帆美. All rights reserved.
//

import UIKit

class CallingItemTableViewCell: UITableViewCell {

    
    @IBOutlet weak var nameCallingForLabel: UILabel!
//    @IBOutlet weak var localNameLabel: UILabel!
    @IBOutlet weak var localTimeLabel: UILabel!
    @IBOutlet weak var localDateLabel: UILabel!
    @IBOutlet weak var destinationNameLabel: UILabel!
//    @IBOutlet weak var jetLagLabel: UILabel!
//    @IBOutlet weak var destinationTimeLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
