//
//  MenuTableViewController.swift
//  
//
//  Created by 北島　志帆美 on 2019-12-18.
//

import UIKit
import CoreLocation

class MenuTableViewController: UITableViewController {
    
    private let locationManager = CLLocationManager()
    private var status: CLAuthorizationStatus!
    
    private var shouldPerformMapSegue = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.tableFooterView = UIView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.shouldPerformMapSegue = false
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
            
        case 0:
            let cell = (tableView.dequeueReusableCell(withIdentifier: "map", for: indexPath) as? MapTableViewCell)!
            
            // Configure the cell...
            
            cell.label?.text = "Find Wifi"
            
            return cell
            
        case 1:
            let cell = (tableView.dequeueReusableCell(withIdentifier: "account Switch", for: indexPath) as? AboutTableViewCell)!
            
            // Configure the cell...
            
            cell.aboutlabel.text = "About"
            
            return cell
            
        default:
            break
        }
        
        return UITableViewCell()
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == 0 {
            
            locationManager.delegate = self
            locationManager.requestWhenInUseAuthorization()
            
            self.shouldPerformMapSegue = true
            
        }
    
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    //    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
    //
    //        if identifier ==  "mapSegue" {
    //            return false
    //        }
    //
    //        return true
    //    }
    
}

extension MenuTableViewController: CLLocationManagerDelegate {
    
    
    @available(iOS 14.0, *)
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        switch manager.authorizationStatus {
        case .notDetermined:
            print("未設定")
            
        case .restricted:
            print("制限")
            
        case .denied:
            print("拒否")
            
        case .authorized, .authorizedAlways, .authorizedWhenInUse:
            
            if self.shouldPerformMapSegue {
                performSegue(withIdentifier: "mapSegue", sender: nil)
            }
            print("おk 14")
            
        default:
            break
            
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        switch status {
        case .notDetermined:
            print("未設定")
            
        case .restricted:
            print("制限")
            
        case .denied:
            print("拒否")
            
        case .authorized, .authorizedAlways, .authorizedWhenInUse:
            
            if self.shouldPerformMapSegue {
                performSegue(withIdentifier: "mapSegue", sender: nil)
            }
            print("おk")
            
        default:
            break
            
        }
        
        
    }
}
