//
//  DestinationNameViewController.swift
//  checklist
//
//  Created by 北島　志帆美 on 2020-02-08.
//  Copyright © 2020 北島　志帆美. All rights reserved.
//

import UIKit

protocol DestinationNameViewControllerDelegate: class {
    func editItemViewController(_ controller: DestinationNameViewController, didFinishEditting item: Plan)
}

protocol DestinationNameViewControllerDelegate2: class {
    func editItemViewController(_ controller: DestinationNameViewController, destinationName: String)
}


class DestinationNameViewController: UIViewController {
    
    
    var item: Plan?
    var indexPath = IndexPath()
    var text: String?
    var original: String?
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var placeLabel: UILabel!
    
    
    weak var delegate:DestinationNameViewControllerDelegate?
    
    weak var delegate2:DestinationNameViewControllerDelegate2?
    
    var isAdding: Bool?
    
    var cityNamesTimezone = TimeZone.knownTimeZoneIdentifiers
    var city = ""
    //    var picker:UIPickerView?
    
    
    
    @IBAction func done(_ sender: Any) {
        
        
        if isAdding != true {
            item?.destinationName = placeLabel.text ?? ""
            delegate?.editItemViewController(self, didFinishEditting: item!)
        } else {
            if placeLabel.text == "Type the place" {
                placeLabel.text = "NONE"
            }
            delegate2?.editItemViewController(self, destinationName: placeLabel.text!)
        }
        navigationController?.popViewController(animated: true)
        
    }
    
    func nameRegion() -> [String] {
        
        var names:[String] = []
        
        for identifier in cityNamesTimezone {
            let regionName = identifier.split(separator: "/")
            
            if !names.contains(String(regionName[0])) {
                names.append(String(regionName[0]))
                
                
            }
            
        }
        
        return names
        //        var names:[String] = []
        //        cityNamesTimezone.map { $0 -> [String] in
        //            var array:[String] = []
        //            let region = $0.split(separator: "/")
        //
        //            if !array.contains(String(region[0])) {
        //                array.append(String(region[0]))
        //            }
        //
        //            return array
        //        }
        
        
        
    }
    
    func nameCities(regionName: String) -> [String] {
        
        var arr:[String] = []
        
        for timezone in cityNamesTimezone {
            let regionFromCityNamesTimeZone = timezone.split(separator: "/")
            if regionName == regionFromCityNamesTimeZone[0] {
                arr.append(String(timezone))
            }
        }
        
        return arr
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        if item?.destinationName != nil {
            
            searchBar.text = item?.destinationName
            placeLabel.text = item?.destinationName
            original = item?.destinationName
        
        }
        else if text != "" {
           
            searchBar.text = text
            placeLabel.text = text
            original = text
        
        }
        else {
        
            searchBar.text = ""
            placeLabel.text = "Type the place"
        
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        
        searchBar.delegate = self
        
        // textField.addTarget(self, action: #selector(showUpPicker), for: .touchDown)
        tableView.tableFooterView = UIView()
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    @IBAction func tapped(_ sender: UITapGestureRecognizer) {
        searchBar.resignFirstResponder()
            self.view.frame.origin.y = -15
            
            if searchBar.isFirstResponder == false {
                sender.isEnabled = false
            }
    }
    
    @IBAction func cancel(_ sender: Any) {
        item?.destinationName = original
        navigationController?.popViewController(animated: true)
    }
        
}


extension DestinationNameViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        let regions = nameRegion()
        
        return regions.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let regions = nameRegion()
        var arr:[String] = []
        
        for (index, region) in regions.enumerated() {
            if section == index {
                arr = nameCities(regionName: region)
                return arr.count
            }
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let regions = nameRegion()
        var cities:[String] = []
        
        let cell  = (tableView.dequeueReusableCell(withIdentifier: "destinationCity") as? DestinationCityNameTableViewCell)!
        
        for (index, region) in regions.enumerated() {
            if indexPath.section == index {
                
                cities = nameCities(regionName: region)
                let onlyCityName = cities[indexPath.row].split(separator: "/")
                cell.label.text = String(onlyCityName.last!)
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        let regions = nameRegion()
        
        return regions[section]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        searchBar.resignFirstResponder()
        let regions = nameRegion()
        
        for (index, region) in regions.enumerated() {
            if indexPath.section == index {
                
                let cities = nameCities(regionName: region)
                item?.destinationName = cities[indexPath.row]
                placeLabel.text = cities[indexPath.row]
                
            }
        }
        
        
        
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        searchBar.resignFirstResponder()
//        self.view.frame.origin.y = -15
//    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
          searchBar.resignFirstResponder()
          self.view.frame.origin.y = -15
      }
    
}

extension DestinationNameViewController: UITableViewDelegate {
    
}


extension DestinationNameViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        var temp: [String] = []
        
        if searchBar.text != "" {
            
            let text = searchBar.text!
            
            cityNamesTimezone = TimeZone.knownTimeZoneIdentifiers
            
            for city in cityNamesTimezone {
                
                if city.contains(text){
                    temp.append(city)
                }
            }
            print(temp)
            
            cityNamesTimezone.removeAll()
            cityNamesTimezone = temp
            
            tableView.reloadData()
            
        } else {
            cityNamesTimezone = TimeZone.knownTimeZoneIdentifiers
            tableView.reloadData()
        }
        
    }

    
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
        searchBar.becomeFirstResponder()
        //        navigationController?.popViewController(animated: true)
    }
    
}
