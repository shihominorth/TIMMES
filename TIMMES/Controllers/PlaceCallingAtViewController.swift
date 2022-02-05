//
//  PlaceCallingAtViewController.swift
//  checklist
//
//  Created by 北島　志帆美 on 2020-02-12.
//  Copyright © 2020 北島　志帆美. All rights reserved.
//

import UIKit

protocol PlaceCallingAtViewControllerDelegate: class {
    func editItemViewController(_ controller: PlaceCallingAtViewController, didFinishEditting item: Plan)
}

protocol PlaceCallingAtViewControllerDelegate2: class  {
     func editItemViewController(_ controller: PlaceCallingAtViewController, didFinishEditting placeCallingAt: String)
}

class PlaceCallingAtViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    var isAdding: Bool?
    var text: String?
    var original: String?
    
    
    
    var item: Plan?
    var indexPath = IndexPath()
    
    weak var delegate: PlaceCallingAtViewControllerDelegate?
    weak var delegate2: PlaceCallingAtViewControllerDelegate2?
    
    
    @IBAction func done(_ sender: Any) {
          
        if isAdding != true {
        item?.placeCallingAt = textField.text ?? ""
        delegate?.editItemViewController(self, didFinishEditting: item!)
        }
        else {
            if textField.text == "" {
                textField.text = "NONE"
            }
            delegate2?.editItemViewController(self, didFinishEditting: textField.text!)
            }
        navigationController?.popViewController(animated: true)
           
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
       

        if item?.placeCallingAt != nil {
            textField.text = item!.placeCallingAt
            original = item!.placeCallingAt
        }
        else if text != "" {
            textField.text = text
            original = text
        }
        else {
            self.navigationItem.rightBarButtonItem!.isEnabled = false
            textField.text = ""
        }
        
        textField.delegate = self

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func cancel(_ sender: Any) {
        item?.placeCallingAt = original
        navigationController?.popViewController(animated: true)
    }
}

extension PlaceCallingAtViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        self.navigationItem.rightBarButtonItem!.isEnabled = true
        return true
    
    }
}
