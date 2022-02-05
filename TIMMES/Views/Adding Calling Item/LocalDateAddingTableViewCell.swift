//
//  LocalDateTableViewCell.swift
//  checklist
//
//  Created by 北島　志帆美 on 2019-12-18.
//  Copyright © 2019 北島　志帆美. All rights reserved.
//

import UIKit

class LocalDateAddingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var localDateLabel: UILabel!
    @IBOutlet weak var questionLabel:UILabel!
    
    func updateText(date: Date, timeZoneIdentifier: String, indexNumber: Int) {
        localDateLabel.text = date.convertToString(dateformat: .date, timeZoneIdentifier: timeZoneIdentifier)
          }
          
    func giveText(date: Date, timeZoneIdentifier: String, indexNumber: Int) -> String {
        return  date.convertToString(dateformat: .date, timeZoneIdentifier: timeZoneIdentifier)
       }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        questionLabel.text = "The date you will call..."
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
