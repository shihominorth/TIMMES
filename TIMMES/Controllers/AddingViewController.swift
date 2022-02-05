//
//  AddingViewController.swift
//  checklist
//
//  Created by 北島　志帆美 on 2022-02-05.
//  Copyright © 2022 北島　志帆美. All rights reserved.
//

import UIKit


protocol AddItemTableViewControllerDelegate: AnyObject {
    func addItemTableViewControllerDidCancel(_ controller: AddingViewController)
    func addItemViewController(_ controller: AddingViewController, didFinishAdding item: callingCellItem)
    
}

class AddingViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let context =  (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var item = callingCellItem()
    
    weak var delegate: AddItemTableViewControllerDelegate?
    var datePickerIndexPath: IndexPath?
    
    var inputDate = Date() {
        didSet {
            
            isFirstOpenDatePicker = false
            
            self.tableView.beginUpdates()
            
            self.tableView.reloadRows(at: [IndexPath(row: 0, section: 1)], with: .bottom)
            
            self.tableView.reloadRows(at: [IndexPath(row: 0, section: 3)], with: .bottom)
            
            self.tableView.reloadRows(at: [IndexPath(row: 0, section: 6)], with: .bottom)
            
            self.tableView.endUpdates()
        }
    }
    
    var isFirstOpenDatePicker = false
    var isFirstDateValuePassed: Bool?
    var isEditting: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        tableView.register(DayPickerTableViewCell.self, forCellReuseIdentifier: "datePicker")
        tableView.tableFooterView = UIView()
        
        item.localDate = inputDate
        item.destinationTime = inputDate
        item.localName = TimeZone.current.identifier
        item.destinationName = TimeZone.current.identifier
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    
    @IBAction func addAction(sender: UIBarButtonItem) {
        
        if  item.nameCallingFor == "" || item.destinationName == "" {
            var alertController: UIAlertController?
            var infoUserNeed: String?
            
            if item.nameCallingFor == "" && item.destinationName != "" {
                
                infoUserNeed = "・You'll call"
                
            }
            
            else if item.nameCallingFor != "" && item.destinationName == "" {
                
                infoUserNeed = "・ Where will you call"
                
            }
            
            else if item.destinationName == "" && item.nameCallingFor == "" {
                
                infoUserNeed = "・ You'll call \n・ Where will you call"
                
            }
            
            alertController = UIAlertController(title: "Error", message: "You need to enter simple info below \n\n\(String(describing: infoUserNeed!))", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController!.addAction(defaultAction)
            
            present(alertController!, animated: true, completion: nil)
            
        } else {
            
            delegate?.addItemViewController(self, didFinishAdding: item)
            
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (granted, _) in
                
                if granted {
                    let notificationClass = LocalNortificationDelegate(timezoneIdentifier:
                                                                        self.item.localName, date: self.item.localDate!)
                    notificationClass.setNotificationDate()
                    notificationClass.setNotificationDate(before: Int(self.item.notification)!)
                }
            }
            
            navigationController?.popViewController(animated: true)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "addingNameCallingFor" {
            if let edittingVC = segue.destination as? NameCallingViewController {
                edittingVC.isAdding = true
                edittingVC.text = item.nameCallingFor
                edittingVC.delegate2 = self as NameCallingViewControllerDelegate2
            }
        }
        
        if segue.identifier == "addingLocalName" {
            if let edittingVC = segue.destination as? LocalNameViewController {
                edittingVC.isAdding = true
                edittingVC.text = item.localName
                edittingVC.delegate2 = self as LocalNameViewControllerDelegate2
            }
        }
        
        if segue.identifier == "addingDestinationName" {
            if let edittingVC = segue.destination as? DestinationNameViewController {
                edittingVC.isAdding = true
                edittingVC.text = item.destinationName
                edittingVC.delegate2 = self as DestinationNameViewControllerDelegate2
                //                edittingVC.delegate = self as! nameCallingViewControllerDelegate
            }
        }
        
        if segue.identifier == "addingNotification" {
            if let edittingVC = segue.destination as? NotificationViewController {
                edittingVC.isAdding = true
                edittingVC.text = item.notification
                edittingVC.delegate2 = self as NotificationViewControllerDelegate2
                
                //                edittingVC.delegate = self as! nameCallingViewControllerDelegate
            }
        }
        
        if segue.identifier == "addingplacecallingat" {
            if let edittingVC = segue.destination as? PlaceCallingAtViewController {
                edittingVC.isAdding = true
                edittingVC.text = item.placeCallingAt
                edittingVC.delegate2 = self as PlaceCallingAtViewControllerDelegate2
            }
        }
    }
}

extension AddingViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if (indexPath.section == 1 || indexPath.section == 3 || indexPath.section == 6) && indexPath.row == 0{
            
            tableView.beginUpdates()
            
            if let datePickerIndexPath = datePickerIndexPath {
                
                if datePickerIndexPath.row - 1 == indexPath.row  && isFirstOpenDatePicker{
                    tableView.reloadRows(at: [indexPath], with: .none)
                    tableView.deleteRows(at: [datePickerIndexPath], with: .fade)
                    self.datePickerIndexPath = nil
                    isFirstOpenDatePicker = false
                }
                
            } else {
                // 2
                if let datePickerIndexPath = datePickerIndexPath {
                    tableView.deleteRows(at: [datePickerIndexPath], with: .fade)
                }
                
                datePickerIndexPath = indexPathToInsertDatePicker(indexPath: indexPath)
                tableView.insertRows(at: [datePickerIndexPath!], with: .fade)
                tableView.deselectRow(at: indexPath, animated: true)
                
            }
            tableView.endUpdates()
            
            
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    
    
    func indexPathToInsertDatePicker(indexPath: IndexPath) -> IndexPath {
        if let datePickerIndexPath = datePickerIndexPath, datePickerIndexPath.row < indexPath.row {
            return indexPath
        } else {
            return IndexPath(row: indexPath.row + 1, section: indexPath.section)
        }
    }
    
}

extension AddingViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 9
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 1 && datePickerIndexPath?.section == 1 && isFirstOpenDatePicker == false {
            isFirstOpenDatePicker = true
            return 2
        }
        else if section == 3 && datePickerIndexPath?.section == 3 && isFirstOpenDatePicker == false{
            isFirstOpenDatePicker = true
            return 2
        }
        else if  section == 6 && datePickerIndexPath?.section == 6 && isFirstOpenDatePicker == false {
            isFirstOpenDatePicker = true
            return 2
        }
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if datePickerIndexPath == indexPath {
            let datePickerCell = tableView.dequeueReusableCell(withIdentifier: "datePicker") as!  DayPickerTableViewCell
            
            switch datePickerIndexPath?.section {
            case 1:
                datePickerCell.datePicker.timeZone = TimeZone(identifier: (item.localName)) ?? TimeZone.current
                print(datePickerCell.datePicker.timeZone!)
                datePickerCell.updateCell(date: inputDate, indexPath: indexPath)
                datePickerCell.datePicker.setDate(inputDate, animated: true)
            case 3:
                datePickerCell.datePicker.timeZone = TimeZone(identifier: (item.localName)) ?? TimeZone.current
                print(datePickerCell.datePicker.timeZone!)
                datePickerCell.datePicker.setDate(inputDate, animated: true)
                datePickerCell.updateCell(date: inputDate, indexPath: indexPath)
            case 6:
                datePickerCell.datePicker.timeZone = TimeZone(identifier: (item.destinationName)) ?? TimeZone.current
                print(datePickerCell.datePicker.timeZone!)
                datePickerCell.datePicker.setDate(inputDate, animated: true)
                datePickerCell.updateCell(date: inputDate, indexPath: indexPath)
            default:
                break
            }
            
            datePickerCell.delegate = self
            
            
            switch datePickerIndexPath?.section {
            case 1:
                datePickerCell.datePicker.datePickerMode = .date
            case 3:
                datePickerCell.datePicker.datePickerMode = .time
            case 6:
                datePickerCell.datePicker.datePickerMode = .dateAndTime
                
            default:
                break
            }
            
            return datePickerCell
        }
        if indexPath.section == 0 {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "name calling for", for: indexPath) as? NameCallingForAddingTableViewCell )!
            
            cell.nameLabel.text = item.nameCallingFor
            
            return cell
        }
        else if indexPath.section == 1 {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "local date", for: indexPath) as? LocalDateAddingTableViewCell)!
            
            if isFirstDateValuePassed == true {
                cell.localDateLabel.text = item.localDate?.convertToString(dateformat: .date, timeZoneIdentifier: item.localName)
                
                
            } else {
                cell.updateText(date: inputDate, timeZoneIdentifier: item.localName , indexNumber: 0)
                appDelegate.saveContext()
                //                item.localDate = cell.giveText(date: inputDates[0], timeZoneIdentifier: item.localName, indexNumber: 0)
            }
            
            return cell
        }
        
        else if indexPath.section == 2 {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "local name", for: indexPath) as? LocalNameAddingTableViewCell)!
            
            cell.localNameLabel.text = item.localName
            
            return cell
        }
        else if indexPath.section == 3 {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "local time", for: indexPath) as? LocalTimeAddingTableViewCell)!
            
            if isFirstDateValuePassed == true {
                cell.localTimeLabel.text = item.localDate?.convertToString(dateformat: .time, timeZoneIdentifier: item.localName)
                
                
            } else {
                cell.updateText(date: inputDate, timeZoneIdentifier: item.localName, indexNumber: 1)
                appDelegate.saveContext()
            }
            
            
            return cell
        }
        else if indexPath.section == 4 {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "destination name", for: indexPath) as? DestinationNameAddingTableViewCell)!
            
            cell.destinationNameLabel.text = item.destinationName
            
            return cell
        }
        else if indexPath.section == 5 {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "jet lag", for: indexPath) as? TimeDifferenceAddingTableViewCell)!
            
            
            let getTimeDifference = GetTimeDifference(localName: item.localName, destinationName: item.destinationName, date: nil)
            
            item.jetLag = getTimeDifference.timeDifferenceWithCityNames()
            
            
            cell.timeDifferenceLabel.text = "\(item.jetLag)"
            
            return cell
        }
        else if indexPath.section == 6 {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "destination time", for: indexPath) as? DestinationTimeAddingTableViewCell)!
            
            if isFirstDateValuePassed == true {
                
                cell.destinationTimeLabel.text = item.destinationTime?.convertToString(dateformat: .dateWithTime, timeZoneIdentifier: item.destinationName)
                
                
            } else {
                cell.updateText(date: inputDate, timeZoneIdentifier: item.destinationName, indexNumber: 2)
                appDelegate.saveContext()
            }
            
            
            return cell
        }
        else if indexPath.section == 7 {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "notification", for: indexPath) as? NotificationTimeAddingTableViewCell)!
            
            cell.notificationLabel.text = item.notification
            
            return cell
        }
        else if indexPath.section == 8 {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "place calling at", for: indexPath) as? PlaceCallingAtAddingTableViewCell)!
            
            cell.placeNameLabel.text = item.placeCallingAt
            
            return cell
        }
        //        else if indexPath.section == 9
        //        {
        //            let cell = (tableView.dequeueReusableCell(withIdentifier: "map", for: indexPath) as? MapPlaceCallingAtTableViewCell)!
        //
        //            return cell
        //        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        switch indexPath.row {
        case 1:
            if datePickerIndexPath?.section == 1 {
                return 150.0
            }
            else if datePickerIndexPath?.section == 3 {
                return 150.0
            }
            else if datePickerIndexPath?.section == 6 {
                return 150.0
            }
            
        default:
            break
        }
        
        
        return UITableView.automaticDimension
    }
}

extension AddingViewController: DatePickerDelegate {
    
    func showDateFromTimeDifference(timeDifference: String, date: Date) -> (Int, Int) {
        let tuple = date.getHour(timeZoneIdentifier: item.localName)
        let numTimeDifference = timeDifference.split(separator: " ").index(after: 0)
        
        print(numTimeDifference)
        
        if timeDifference.contains("+") {
            let result =  Int(numTimeDifference) + tuple.hour
            
            if result >= 23 {
                return (tuple.date, result)
            } else {
                return (tuple.date + 1, result - 24)
            }
        }
        else if timeDifference.contains("-"){
            let result =  tuple.hour - Int(numTimeDifference)
            
            if result >= 0 {
                return (tuple.date, result)
            } else {
                return (tuple.date - 1, 24 - result)
            }
        }
        else {
            return (tuple.date, tuple.hour)
        }
        
    }
    
    
    
    func didChangeDate(date: Date, indexPath: IndexPath) {
        
        
        self.isFirstDateValuePassed = false
        isFirstOpenDatePicker = false
        inputDate = date
        
        switch indexPath.section {
        case 1, 3:
            
            item.localDate = date
            item.destinationTime = date
            
            print(item.localDate?.convertToString(dateformat: .dateWithTime, timeZoneIdentifier: item.localName))
            
            
            print(item.destinationTime?.convertToString(dateformat: .dateWithTime, timeZoneIdentifier: item.destinationName))
            
        case 6:
            
            item.destinationTime = date
            item.localDate = date
            
            print(item.localDate?.convertToString(dateformat: .dateWithTime, timeZoneIdentifier: item.localName))
            
            
            print(item.destinationTime?.convertToString(dateformat: .dateWithTime, timeZoneIdentifier: item.destinationName))
            
            
        default:
            break
        }
        
    }
    
}


extension AddingViewController: NameCallingViewControllerDelegate2 {
    func editItemViewController(_ controller: NameCallingViewController, nameCallFor: String) {
        self.item.nameCallingFor = nameCallFor
        tableView.reloadData()
    }
    
}


extension AddingViewController: LocalNameViewControllerDelegate2 {
    func editItemViewController(_ controller: LocalNameViewController, didFinishEditting localName: String!) {
        
        self.item.localName = localName
        tableView.reloadData()
    }
    
}


extension AddingViewController: DestinationNameViewControllerDelegate2 {
    func editItemViewController(_ controller: DestinationNameViewController, destinationName: String) {
        self.item.destinationName = destinationName
        tableView.reloadData()
    }
    
}

extension AddingViewController: NotificationViewControllerDelegate2 {
    func editItemViewController(_ controller: NotificationViewController, didFinishEditting notification: String) {
        
        self.item.notification = notification
        tableView.reloadData()
    }
    
}

extension AddingViewController: PlaceCallingAtViewControllerDelegate2 {
    func editItemViewController(_ controller: PlaceCallingAtViewController, didFinishEditting placeCallingAt: String) {
        self.item.placeCallingAt = placeCallingAt
        tableView.reloadData()
    }
    
}
