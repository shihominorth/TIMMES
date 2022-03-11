//
//  EditingViewController.swift
//  checklist
//
//  Created by 北島　志帆美 on 2020-05-22.
//  Copyright © 2020 北島　志帆美. All rights reserved.
//

import UIKit

class EditingViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var callingCelllist = CallingCellList()
    var edittedItem = Plan()
    var item:callingCellItem?
    var indexPath = IndexPath()
    weak var delegate: EdittingViewControllerDelegate?
    
    var datePickerIndexPath: IndexPath?

    var inputDates = Date()
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let context =  (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var isFirstOpenDatePicker = false
    var isFirstDateValuePassed: Bool?
    var isEditting: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        tableView.tableFooterView = UIView()
        tableView.register(DayPickerTableViewCell.self, forCellReuseIdentifier: "datePicker")
        
        tableView.delegate = self
        tableView.dataSource = self
        
        item = addValue(item: edittedItem)
    }
    
    func addValue(item: Plan) -> callingCellItem{
        let plan = callingCellItem()
        plan.nameCallingFor = item.nameCallingFor!
        plan.localDate = item.localDate
        plan.localName = item.localName!
        plan.destinationName = item.destinationName!
        plan.jetLag = item.jetLag!
        plan.destinationTime = item.destinationTime
        plan.notification = item.notification!
        plan.placeCallingAt = item.placeCallingAt!
        
        return plan
        
    }
    
    func indexPathToInsertDatePicker(indexPath: IndexPath) -> IndexPath {
        if let datePickerIndexPath = datePickerIndexPath, datePickerIndexPath.row < indexPath.row {
            return indexPath
        } else {
            return IndexPath(row: indexPath.row + 1, section: indexPath.section)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "edittingNameCallingFor" {
            if let edittingVC = segue.destination as? NameCallingViewController {
                edittingVC.item = self.edittedItem
                edittingVC.indexPath = self.indexPath
                edittingVC.delegate = self
            }
        }
        else if segue.identifier == "edittingLocalName" {
            if let edittingVC = segue.destination as? LocalNameViewController {
                edittingVC.item = self.edittedItem
                edittingVC.indexPath = self.indexPath
                edittingVC.delegate = self
            }
        }
        else if segue.identifier == "edittingDestinationName" {
            if let edittingVC = segue.destination as? DestinationNameViewController {
                edittingVC.item = self.edittedItem
                edittingVC.indexPath = self.indexPath
                edittingVC.delegate = self
            }
        }
        
        else if segue.identifier == "edittingNotification" {
            if let edittingVC = segue.destination as? NotificationViewController {
                edittingVC.item = self.edittedItem
                edittingVC.indexPath = self.indexPath
                edittingVC.delegate = self as NotificationViewControllerDelegate
            }
        }
        
        else if segue.identifier == "editting place calling at" {
            if let edittingVC = segue.destination as? PlaceCallingAtViewController {
                edittingVC.item = self.edittedItem
                edittingVC.indexPath = self.indexPath
                edittingVC.delegate = self as PlaceCallingAtViewControllerDelegate
            }
        }
    }
    
    
    @IBAction func back() {
        
//        delegate?.DetailCallingTableViewController(self, cancelItem: self.item!, indexPath: self.indexPath)
//        
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func done(_ sender: Any) {
        
        appDelegate.saveContext()
        delegate?.detailCallingTableViewController(self, didFinishEditting: edittedItem, indexPath: self.indexPath)
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (granted, _) in
            
            if granted {
                let notificationClass = LocalNortificationDelegate(timezoneIdentifier: self.edittedItem.localName!, date: self.edittedItem.localDate!)
                notificationClass.setNotificationDate()
                notificationClass.setNotificationDate(before: Int(self.edittedItem.notification!)!)
            }
        }
        
        
        navigationController?.popViewController(animated: true)
    }
}

extension EditingViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 1 || indexPath.section == 3 || indexPath.section == 6 {
            
            tableView.beginUpdates()
            
            if let datePickerIndexPath = datePickerIndexPath, datePickerIndexPath.row - 1 == indexPath.row {
                
                tableView.reloadRows(at: [indexPath], with: .none)
                tableView.deleteRows(at: [datePickerIndexPath], with: .fade)
                self.datePickerIndexPath = nil
                isFirstOpenDatePicker = false
                
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
            
            if let datePickerIndexPath = datePickerIndexPath, let datePickerCell = (tableView.cellForRow(at: datePickerIndexPath) as? DayPickerTableViewCell) {
                
                switch datePickerIndexPath.section {
                case 1, 3:
                    
                    datePickerCell.datePicker.setDate(edittedItem.localDate!, animated: true)
                    
                case 6:
                    
                    datePickerCell.datePicker.setDate(edittedItem.destinationTime!, animated: true)
                    
                default:
                    break
                }
                
                
                
            }
        }
    }
    
    
}

extension EditingViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        if let datePickerIndexPath = datePickerIndexPath {
            
            if section == 1 && datePickerIndexPath.section == 1 && isFirstOpenDatePicker == false {
                isFirstOpenDatePicker = true
                return 2
            }
            else if section == 3 && datePickerIndexPath.section == 3 && isFirstOpenDatePicker == false {
                isFirstOpenDatePicker = true
                return 2
            }
            else if  section == 6 && datePickerIndexPath.section == 6 && isFirstOpenDatePicker == false {
                isFirstOpenDatePicker = true
                return 2
            }
        }
        
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 9
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if datePickerIndexPath == indexPath {
            let datePickerCell = tableView.dequeueReusableCell(withIdentifier: "datePicker") as!  DayPickerTableViewCell
            datePickerCell.indexPath = indexPath
            
            switch datePickerIndexPath?.section {
            case 1:
                
                datePickerCell.datePicker.timeZone = TimeZone(identifier: (edittedItem.localName!)) ?? TimeZone.current
                
                print(datePickerCell.datePicker.timeZone!)
                
                datePickerCell.datePicker.setDate(edittedItem.localDate!, animated: true)
                
                isFirstOpenDatePicker = false
                
                
                
                
            case 3:
                
                datePickerCell.datePicker.timeZone = TimeZone(identifier: (edittedItem.localName!)) ?? TimeZone.current
                
                print(datePickerCell.datePicker.timeZone!)
                
                datePickerCell.datePicker.setDate(edittedItem.localDate!, animated: true)
                
                
            case 6:
                datePickerCell.datePicker.timeZone = TimeZone(identifier: (edittedItem.destinationName!)) ?? TimeZone.current
                
                print(datePickerCell.datePicker.timeZone!)
                
                datePickerCell.datePicker.setDate(edittedItem.localDate!, animated: true)
                
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
        
        switch indexPath.section {
            
        case 0:
            let cell = (tableView.dequeueReusableCell(withIdentifier: "NameCalling", for: indexPath) as? NameCallingForTableViewCell)!
            
            cell.NameCallingForLabel.text = edittedItem.nameCallingFor ?? ""
            
            return cell
            
        case 1:
            let cell = (tableView.dequeueReusableCell(withIdentifier: "date Calling", for: indexPath) as? DateCallingTableViewCell)!
            
            
            // Configure the cell...
            if isFirstDateValuePassed == true {
                cell.DateCallingLabel.text = edittedItem.localDate?.convertToString(dateformat: .date, timeZoneIdentifier: edittedItem.localName!) ?? "None"
                
            } else {
                //                cell.DateCallingLabel.text = item.localDate?.convertToString(dateformat: .date, timeZoneIdentifier: item.localName!) ?? "None"
                cell.updateText(date: edittedItem.localDate!, timeZoneIdentifier: edittedItem.localName ?? TimeZone.current.identifier, indexNumber: 0)
                //                appDelegate.saveContext()
            }
            return cell
            
        case 2:
            let cell = (tableView.dequeueReusableCell(withIdentifier: "local Name", for: indexPath) as? LocalNameTableViewCell)!
            
            // Configure the cell...
            
            
            cell.localNameLabel.text = edittedItem.localName ?? "None"
            
            return cell
            
        case 3:
            let cell = (tableView.dequeueReusableCell(withIdentifier: "local Time", for: indexPath) as? LocalTimeTableViewCell)!
            
            // Configure the cell...
            
            if isFirstDateValuePassed == true {
                cell.LocalTimeLabel.text = edittedItem.localDate?.convertToString(dateformat: .time, timeZoneIdentifier: edittedItem.localName!) ?? "None"
                
            } else {
                
                cell.updateText(date: edittedItem.localDate!, timeZoneIdentifier: edittedItem.localName ?? TimeZone.current.identifier, indexNumber: 1)
                
            }
            
            return cell
            
        case 4:
            let cell = (tableView.dequeueReusableCell(withIdentifier: "destination Name", for: indexPath) as? DestinationNameTableViewCell)!
            
            // Configure the cell...
            
            cell.DestinationNameLabel.text = edittedItem.destinationName ?? "None"
            return cell
            
        case 5:
            let cell = (tableView.dequeueReusableCell(withIdentifier: "jet Lag", for: indexPath) as? JetLagTableViewCell)!
            
            // Configure the cell...
            let getTimeDifference = GetTimeDifference(localName: edittedItem.localName, destinationName: edittedItem.destinationName, date: nil)
            
            edittedItem.jetLag = getTimeDifference.timeDifferenceWithCityNames()
            cell.jetLagLabel.text = edittedItem.jetLag ?? "None"
            
            return cell
            
        case 6:
            let cell = (tableView.dequeueReusableCell(withIdentifier: "destination Time", for: indexPath) as? DestinationTimeTableViewCell)!
            
            
            if isFirstDateValuePassed == true {
                cell.destinationTimeLabel.text = edittedItem.destinationTime?.convertToString(dateformat: .dateWithTime, timeZoneIdentifier: edittedItem.destinationName!)
                
            } else {
                cell.updateText(date: inputDates, timeZoneIdentifier: edittedItem.destinationName ?? TimeZone.current.identifier, indexNumber: 2)
                
            }
            
            return cell
            
        case 7:
            let cell = (tableView.dequeueReusableCell(withIdentifier: "notification", for: indexPath) as? NotificaitonTableViewCell)!
            
            cell.notificateTimelabel.text = edittedItem.notification ?? "None"
            
            return cell
            
        case 8:
            let cell = (tableView.dequeueReusableCell(withIdentifier: "detail place calling at", for: indexPath) as? DetailPlaceCallingAtTableViewCell)!
            
            cell.label.text = edittedItem.placeCallingAt ?? "None"
            
            return cell
            
        default:
            break
        }
        
        fatalError()
        
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

extension EditingViewController: nameCallingViewControllerDelegate {
    func editItemViewController(_ controller: NameCallingViewController, didFinishEditting item: Plan) {
        self.edittedItem = item
        self.tableView.reloadData()
    }
}

extension EditingViewController: LocalNameViewControllerDelegate {
    func editItemViewController(_ controller: LocalNameViewController, didFinishEditting item: Plan) {
        self.edittedItem = item
        //        appDelegate.saveContext()
        self.tableView.reloadData()
    }
}


extension EditingViewController: DestinationNameViewControllerDelegate {
    
    func editItemViewController(_ controller: DestinationNameViewController, didFinishEditting item: Plan) {
        self.edittedItem = item
        //        appDelegate.saveContext()
        self.tableView.reloadData()
    }
    
}

extension EditingViewController: NotificationViewControllerDelegate {
    func editItemViewController(_ controller: NotificationViewController, didFinishEditting item: Plan) {
        self.edittedItem = item
        //        appDelegate.saveContext()
        self.tableView.reloadData()
    }
    
}

extension EditingViewController: PlaceCallingAtViewControllerDelegate {
    func editItemViewController(_ controller: PlaceCallingAtViewController, didFinishEditting item: Plan) {
        self.edittedItem = item
        //        appDelegate.saveContext()
        self.tableView.reloadData()
    }
    
}


extension EditingViewController: DatePickerDelegate {
    
    
    func didChangeDate(date: Date, indexPath: IndexPath) {
        
        inputDates = date

        isFirstOpenDatePicker = false
        self.isFirstDateValuePassed = false
            
    
        switch indexPath.section {
        case 1, 3:
            
            edittedItem.localDate = date
            edittedItem.destinationTime = date
            
             let getTimeDifference = GetTimeDifference(localName: edittedItem.localName, destinationName: edittedItem.destinationName, date: nil)
             edittedItem.jetLag = getTimeDifference.timeDifferenceWithCityNames()
            
            isFirstOpenDatePicker = false
            self.isFirstDateValuePassed = false
            
            
            self.tableView.beginUpdates()
            
            if indexPath.section == 1 {
                
               

                self.tableView.reloadRows(at: [IndexPath(row: 0, section: indexPath.section)], with: .bottom)
                self.tableView.reloadRows(at: [IndexPath(row: 0, section: 3)], with: .bottom)
                
               

            }
            else if indexPath.section == 3 {
                
                self.tableView.reloadRows(at: [IndexPath(row: 0, section: indexPath.section)], with: .automatic)
                self.tableView.reloadRows(at: [IndexPath(row: 0, section: 1)], with: .bottom)

            }
            
             self.tableView.reloadRows(at: [IndexPath(row: 0, section: 6)], with: .bottom)
            
             self.tableView.endUpdates()
            
        case 6:
            
            edittedItem.localDate = date
            edittedItem.destinationTime = date
            
             let getTimeDifference = GetTimeDifference(localName: edittedItem.localName, destinationName: edittedItem.destinationName, date: nil)
             edittedItem.jetLag = getTimeDifference.timeDifferenceWithCityNames()
            
            self.tableView.beginUpdates()

            self.tableView.reloadRows(at: [IndexPath(row: 0, section: 1)], with: .bottom)
            
            self.tableView.reloadRows(at: [IndexPath(row: 0, section: indexPath.section)], with: .bottom)
            self.tableView.reloadRows(at: [IndexPath(row: 0, section: 3)], with: .bottom)
                  
            self.tableView.reloadRows(at: [IndexPath(row: 0, section: 6)], with: .bottom)
            
            self.tableView.endUpdates()


            
        default:
            break
        }
    }
    
}


