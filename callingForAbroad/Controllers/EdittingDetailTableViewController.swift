//////
//////  EdittingDetailTableViewController.swift
//////  checklist
//////
//////  Created by 北島　志帆美 on 2019-12-18.
//////  Copyright © 2019 北島　志帆美. All rights reserved.
//////
////
//import UIKit
////
//protocol EditItemTableViewControllerDelegate: class {
////    func editItemViewController(_ controller: EdittingDetailTableViewController, didFinishEditting item: callingCellItem, original originalItem: callingCellItem)
//}
//
//class EdittingDetailTableViewController: UITableViewController {
//
//    private let context =  (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//    weak var editItem:Plan?
//    var indexPath = IndexPath()
//    weak var delegate: EditItemTableViewControllerDelegate?
//    weak var callingCellList:CallingCellList?
//    let detailVC = DetailCallingTableViewController()
//    
//    
//    @IBAction func done(_ sender: Any) {
//        let edittedItem = Plan(entity: Plan.entity(), insertInto: context)
//        if let cell:EdittingNameCallingForTableViewCell
//            = (tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? EdittingNameCallingForTableViewCell)!{
//            edittedItem.nameCallingFor = cell.textField.text ?? ""
//        }
//        if let cell:EdittingLocalDateCallingTableViewCell
//            = (tableView.cellForRow(at: IndexPath(row: 0, section: 1)) as? EdittingLocalDateCallingTableViewCell)! {
//            let date = cell.textField.text?.convertStringToDate(dateformat: .dateWithTime, timeZoneIdentifier: edittedItem.localName!)
//            edittedItem.localDate = date
//        if let cell:EdittingLocalNameTableViewCell
//            = (tableView.cellForRow(at: IndexPath(row: 0, section: 2)) as? EdittingLocalNameTableViewCell)! {
//            edittedItem.localName = cell.textField.text ?? ""
//        }
//        if let cell:EdittingLocalTimeTableViewCell
//            = (tableView.cellForRow(at: IndexPath(row: 0, section: 3)) as? EdittingLocalTimeTableViewCell)! {
//            let date = cell.textField.text?.convertStringToDate(dateformat: .dateWithTime, timeZoneIdentifier: edittedItem.localName!)
//            edittedItem.localDate = date
//        }
//        if let cell:EdittingDestinationNameTableViewCell
//            = (tableView.cellForRow(at: IndexPath(row: 0, section: 4)) as? EdittingDestinationNameTableViewCell)! {
//            edittedItem.destinationName = cell.textField.text ?? ""
//        }
//        if let cell:EdittingJetLagTableViewCell
//            = (tableView.cellForRow(at: IndexPath(row: 0, section: 5)) as? EdittingJetLagTableViewCell)! {
//            edittedItem.jetLag = cell.textField.text ?? ""
//        }
//        if let cell:EdittingDestinationTimeTableViewCell
//            = (tableView.cellForRow(at: IndexPath(row: 0, section: 6)) as? EdittingDestinationTimeTableViewCell)! {
//            edittedItem.destinationTime = cell.textField.text?.convertStringToDate(dateformat: .dateWithTime, timeZoneIdentifier: edittedItem.destinationName!)
//            
//        }
//            
//        
////        delegate?.editItemViewController(self, didFinishEditting: edittedItem, original: callingCellItem?)
//        
////        let detailVC = storyboard?.instantiateViewController(identifier: "detail") as! DetailCallingTableViewController
////        detailVC.item = edittedItem ?? detailVC.item
//        navigationController?.popViewController(animated: true)
//        }
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Uncomment the following line to preserve selection between presentations
////        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: NSNotification.Name.UIResponder.keyboardWillShowNotification, object: nil)
////        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: NSNotification.Name.UIResponder.keyboardWillHideNotification, object: nil)
//////        }
//        func keyboardWillShow(_ notification: NSNotification){
//            let userInfo = notification.userInfo ?? [:]
//            let keyboardFrame = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
//            let height = keyboardFrame.height + 20
//        }
//        func keyboardWillHide(_ notification: NSNotification){
//            
//        }
//            
//     
//            
//      
//    }
//
//    // MARK: - Table view data source
//
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 7
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 1
//    }
//
//    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//           
//        if indexPath.section == 0 {
//            let cell = (tableView.dequeueReusableCell(withIdentifier: "edit nameCallingFor", for: indexPath) as? EdittingNameCallingForTableViewCell)!
//            
//            cell.textField.text = editItem?.nameCallingFor
//            cell.textField.delegate = self
//            
//            // Configure the cell...
//            
//            return cell
//        }
//        else if indexPath.section == 1 {
//            let cell = (tableView.dequeueReusableCell(withIdentifier: "edit localDate", for: indexPath) as? EdittingLocalDateCallingTableViewCell)!
//            
//            // Configure the cell...
//            cell.textField.text = editItem?.localDate?.convertToString(dateformat: .date, timeZoneIdentifier: editItem!.localName!)
//            cell.textField.delegate = self
//            
//            return cell
//            
//        }
//        else if indexPath.section == 2 {
//            let cell = (tableView.dequeueReusableCell(withIdentifier: "edit localName", for: indexPath) as? EdittingLocalNameTableViewCell)!
//            
//            // Configure the cell...
//            
//            cell.textField.text = editItem?.localName
//            cell.textField.delegate = self
//            
//            return cell
//        }
//            
//        else if indexPath.section == 3 {
//            let cell = (tableView.dequeueReusableCell(withIdentifier: "edit localTime", for: indexPath) as? EdittingLocalTimeTableViewCell)!
//            
//            // Configure the cell...
//            cell.textField.text = editItem?.localDate?.convertToString(dateformat: .time, timeZoneIdentifier: editItem!.localName!)
//            cell.textField.delegate = self
//            
//            return cell
//        }
//        else if indexPath.section == 4 {
//            let cell = (tableView.dequeueReusableCell(withIdentifier: "edit destinationName", for: indexPath) as? EdittingDestinationNameTableViewCell)!
//            
//            // Configure the cell...
//            
//            cell.textField.text = editItem?.destinationName
//            cell.textField.delegate = self
//            return cell
//        }
//        else if indexPath.section == 5 {
//            let cell = (tableView.dequeueReusableCell(withIdentifier: "edit jetLag", for: indexPath) as? EdittingJetLagTableViewCell)!
//            
//            // Configure the cell...
//            cell.textField.text = editItem?.jetLag
//            cell.textField.delegate = self
//            
//            return cell
//        }
//        else if indexPath.section == 6 {
//            let cell = (tableView.dequeueReusableCell(withIdentifier: "edit destinationTime", for: indexPath) as? EdittingDestinationTimeTableViewCell)!
//            
//            // Configure the cell...
//            cell.textField.text = editItem?.destinationTime?.convertToString(dateformat: .dateWithTime, timeZoneIdentifier: editItem!.destinationName!)
//            cell.textField.delegate = self
//            
//            return cell
//        }
//        
//        let cell = UITableViewCell()
//        return cell
//    }
//    
//
//    /*
//    // Override to support conditional editing of the table view.
//    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        // Return false if you do not want the specified item to be editable.
//        return true
//    }
//    */
//
//    /*
//    // Override to support editing the table view.
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            // Delete the row from the data source
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        } else if editingStyle == .insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//        }
//    }
//    */
//
//    /*
//    // Override to support rearranging the table view.
//    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
//
//    }
//    */
//
//    /*
//    // Override to support conditional rearranging of the table view.
//    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
//        // Return false if you do not want the item to be re-orderable.
//        return true
//    }
//    */
//
//    
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
////    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
////        if segue.identifier == "editting Segue" {
////            if let detailVC = segue.destination as? DetailCallingTableViewController {
////                detailVC.item = self.editItem!
////                detailVC.indexPath = self.indexPath
////            }
////        }
////    }
//
//    
//
//}
//
//
//
//extension EdittingDetailTableViewController :UITextFieldDelegate {
//    
//    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//    
//        switch textField.tag {
//        case 0:
//            textField.resignFirstResponder()
//            let cell = tableView(self.tableView, cellForRowAt: IndexPath(row: 0, section: 1)) as? EdittingLocalDateCallingTableViewCell
//            
//            
//            
////            let cell = (tableView.dequeueReusableCell(withIdentifier: "edit nameCallingFor", for: indexPath) as? EdittingNameCallingForTableViewCell)!
////            let nextCell = (tableView.dequeueReusableCell(withIdentifier: "edit localDate", for: indexPath) as? EdittingLocalDateCallingTableViewCell)!
//            if let nextcell = cell {
//                nextcell.isEditing=true
//                nextcell.textField.text="dfsdfsd"
//                nextcell.textField.becomeFirstResponder()
//            }
//            
//        //     cell.resignFirstResponder()
//         //   nextCell.becomeFirstResponder()
//        default:
//            break
//        }
//        return true
//    }
//      
//       
//}
