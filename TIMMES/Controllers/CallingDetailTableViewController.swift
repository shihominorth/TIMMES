//
//  CallingDetailViewController.swift
//  checklist
//
//  Created by 北島　志帆美 on 2019-11-22.
//  Copyright © 2019 北島　志帆美. All rights reserved.
//

import UIKit

class CallingDetailViewController: UITableViewController {
    
    let CallinglistViewController = callinglistViewController()
    
    var CallingCelllist = callingCellList()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditItemSegue" {
        if let addItemViewController = segue.destination as? addCallingItemViewController {
            if let cell = sender as? UITableViewCell, let indexPath = CallinglistViewController.tableView.indexPath(for: cell) {
                let item = CallingCelllist.callingList[indexPath.row]
                addItemViewController.itemToEdit = item
            }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}}
}
