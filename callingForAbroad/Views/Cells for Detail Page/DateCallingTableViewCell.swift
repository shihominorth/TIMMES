//
//  TableViewCell.swift
//  
//
//  Created by 北島　志帆美 on 2019-12-17.
//

import UIKit

// Date Format type
enum DateFormatType: String {
    /// Time
    case time = "HH:mm"
    
    /// Date with hours
    case dateWithTime = "EEE, MMMM d, yyyy  H:mm"
    
    /// Date
    case date = "EEE, MMMM d, yyyy"
}

class DateCallingTableViewCell: UITableViewCell {

    @IBOutlet weak var DateCallingLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    
    func updateText(date: Date, timeZoneIdentifier: String, indexNumber: Int) {
        DateCallingLabel.text = date.convertToString(dateformat: .date, timeZoneIdentifier: timeZoneIdentifier)
    }
    
    func giveText(date: Date, timeZoneIdentifier: String) -> String{
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


