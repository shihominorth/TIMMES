//
//  TableViewCell.swift
//  checklist
//
//  Created by 北島　志帆美 on 2019-12-17.
//  Copyright © 2019 北島　志帆美. All rights reserved.
//

import UIKit

class LocalTimeTableViewCell: UITableViewCell {

    
    @IBOutlet weak var LocalTimeLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    
    func updateText(date: Date, timeZoneIdentifier: String, indexNumber: Int) {
        LocalTimeLabel.text = date.convertToString(dateformat: .time, timeZoneIdentifier: timeZoneIdentifier)
    }
    
    func giveText(date: Date, timeZoneIdentifier: String, indexNumber: Int) -> String {
        return date.convertToString(dateformat: .time, timeZoneIdentifier: timeZoneIdentifier)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        questionLabel.text = "What time you will call..."

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
