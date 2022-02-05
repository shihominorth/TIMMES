//
//  DestinationTimeTableViewCell.swift
//  checklist
//
//  Created by 北島　志帆美 on 2019-12-17.
//  Copyright © 2019 北島　志帆美. All rights reserved.
//

import UIKit

class DestinationTimeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var destinationTimeLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    
    func updateText(date: Date, timeZoneIdentifier: String, indexNumber: Int) {
        destinationTimeLabel.text = date.convertToString(dateformat: .dateWithTime, timeZoneIdentifier: timeZoneIdentifier)
    }
    
    func giveText(date: Date, timeZoneIdentifier: String, indexNumber: Int) -> String {
        return date.convertToString(dateformat: .dateWithTime, timeZoneIdentifier: timeZoneIdentifier)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        questionLabel.text = "The time in where he/she/they are"

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
