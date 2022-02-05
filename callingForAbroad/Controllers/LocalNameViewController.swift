//
//  LocalNameViewController.swift
//  callingForAbroad
//
//  Created by 北島　志帆美 on 2020-02-08.
//  Copyright © 2020 北島　志帆美. All rights reserved.
//

import UIKit


protocol LocalNameViewControllerDelegate: class {
    //     func editItemViewController(_ controller: LocalNameViewController, didFinishEditting item: callingCellItem)
    func editItemViewController(_ controller: LocalNameViewController, didFinishEditting item: Plan)
    
}

protocol LocalNameViewControllerDelegate2: class {
    func editItemViewController(_ controller: LocalNameViewController, didFinishEditting localName: String!)
}

class LocalNameViewController: UIViewController {
    
    
    var item: Plan?
    var indexPath = IndexPath()
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var text = ""
    var original: String?
    
    weak var delegate:LocalNameViewControllerDelegate?
    
    var isAdding: Bool?
    weak var delegate2:LocalNameViewControllerDelegate2?
    
    var cityNamesTimezone = TimeZone.knownTimeZoneIdentifiers
    var city = ""
    
    
    func nameRegion() -> [String] {
        
        var names:[String] = []
        
        for identifier in cityNamesTimezone {
            let regionName = identifier.split(separator: "/")
            
            if !names.contains(String(regionName[0])) {
                names.append(String(regionName[0]))
                
                
            }
            
        }
        
        return names
 
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
    
    
    
    //    var picker:UIPickerView?
    
    @IBAction func done(_ sender: Any) {
        
        if isAdding != true {
            item?.localName = placeLabel.text
            delegate?.editItemViewController(self, didFinishEditting: item!)
        } else {
            if placeLabel.text == "type the name of the city" {
                searchBar.text = "NONE"
            }
            
            delegate2?.editItemViewController(self, didFinishEditting: placeLabel.text)
        }
        
        navigationController?.popViewController(animated: true)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        textField.inputView = picker
        
        // Do any additional setup after loading the view.
        
        if item?.localName != nil {
            
            searchBar.text = item!.localName
            placeLabel.text = item!.localName
            original = item!.localName
        
        }
        else if text != "" {
            
            searchBar.text = text
            placeLabel.text = text
            original = text
        }
        else {
            searchBar.text = ""
            placeLabel.text = TimeZone.current.identifier
        }

        
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
        tableView.tableFooterView = UIView()
    }
    
    
    //    @objc func showUpPicker() {
    //        self.picker = UIPickerView(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
    //        self.picker?.delegate = self
    //        self.picker?.dataSource = self
    //        textField.inputView = self.picker
    //
    //        // ToolBar
    //        let toolBar = UIToolbar()
    //        toolBar.barStyle = .default
    //        toolBar.isTranslucent = true
    //        toolBar.tintColor = UIColor(red: 92/255, green: 216/255, blue: 255/255, alpha: 1)
    //        toolBar.sizeToFit()
    
    // Adding Button ToolBar
    //        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(LocalNameViewController.doneClick))
    //        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    //        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(LocalNameViewController.cancelClick))
    //        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
    //        toolBar.isUserInteractionEnabled = true
    //        textField.inputAccessoryView = toolBar
    //    }
    
    //MARK:- Button
    @IBAction func cancel(_ sender: Any) {
        item?.localName = original
        navigationController?.popViewController(animated: true)
    }
    //    @objc func doneClick() {
    //        textField.resignFirstResponder()
    //    }
    //    @objc func cancelClick() {
    //        textField.resignFirstResponder()
    //    }
    
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
   
}

extension LocalNameViewController: UITableViewDelegate {
    
}

extension LocalNameViewController: UITableViewDataSource {
    
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
        
        //        for region in regions {
        //            arr = nameCities(regionName: region)
        //            return arr.count
        //        }
        //
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let regions = nameRegion()
        var cities:[String] = []
        
        let cell = (tableView.dequeueReusableCell(withIdentifier: "localName") as? NameCitiesTableViewCell)!
        
        for (index, region) in regions.enumerated() {
            if indexPath.section == index {
                if region == "GMT" {
                    cities = nameCities(regionName: region)
                    cell.label.text = cities[indexPath.row]
                } else {
                cities = nameCities(regionName: region)
                let onlyCityName = cities[indexPath.row].split(separator: "/")
                    cell.label.text = String(onlyCityName.last!)
                }
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
                       item?.localName = cities[indexPath.row]
                    placeLabel.text = cities[indexPath.row]
                   }
               }
        
        
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        searchBar.resignFirstResponder()
//        self.view.frame.origin.y = -15
//
//    }
//
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.resignFirstResponder()
        self.view.frame.origin.y = -15
    }
}

extension LocalNameViewController: UISearchBarDelegate {
    
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
        searchBar.becomeFirstResponder()
            self.searchBar.endEditing(true)
    //        navigationController?.popViewController(animated: true)
    }
}
