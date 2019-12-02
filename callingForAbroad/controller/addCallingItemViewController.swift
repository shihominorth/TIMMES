//
//  addCallingItemViewController.swift
//  checklist
//
//  Created by 北島　志帆美 on 2019-11-14.
//  Copyright © 2019 北島　志帆美. All rights reserved.
//

import UIKit

protocol AddViewControllerDelegate: class {
    func addItemViewControllerDidCancel(_ controller: addCallingItemViewController)
    func addItemViewController(_ controller: addCallingItemViewController, didFinishAdding item: callingCellItem)
}

class addCallingItemViewController: UIViewController {
    
    weak var delegate: AddViewControllerDelegate?
    weak var itemList: callingCellList?
    weak var itemToEdit: callingCellItem?
    var toolBar = UIToolbar()
   
    @IBOutlet weak var cancelBarButton: UIBarButtonItem!
    
    @IBOutlet weak var addBarButton: UIBarButtonItem!
    
    @IBOutlet weak var textfield: UITextField!
    
    @IBOutlet weak var LocalTimeForCalling: UITextField!
    @IBOutlet weak var reminderTextfiled: UITextField!
    
    // when you connect bar item button with IBAction, the name of function should be same as the name of bar button item.
    @IBAction func Add(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        delegate?.addItemViewControllerDidCancel(self)
    }
    
    @IBAction func Cancel(_ sender: Any) {
        
        // it doesn't show any error if the code was comment out.
        navigationController?.popViewController(animated: true)
        delegate?.addItemViewControllerDidCancel(self)
        let item = callingCellItem()
        if let textFiledText = textfield.text {
            item.NameCallingFor = textFiledText
        }
        item.checked = false
        delegate?.addItemViewController(self, didFinishAdding: item)
    }
    
    @IBOutlet weak var callingNametextFild: UITextField!

    
    override func viewDidLoad() {
        super.viewDidLoad()
       // navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.prefersLargeTitles = false
        
        
        
        
        if let item = itemToEdit {
            title = "Edit Item"
            textfield.text = item.NameCallingFor
            addBarButton.isEnabled = true
        }

        // Do any additional setup after loading the view.
        let app = UINavigationBarAppearance()
//         app.backgroundColor = UIColor(red: 0.0, green: 206.0/255.0, blue: 206.0/255.0, alpha: 1)
//         self.navigationController?.navigationBar.scrollEdgeAppearance = app
//        self.navigationController?.navigationBar.backgroundColor = UIColor(red: 0.0, green: 206.0/255.0, blue: 206.0/255.0, alpha: 1)
//        self.navigationController?.navigationBar.backgroundColor = UIColor(red: 0.0, green: 206.0/255.0, blue: 206.0/255.0, alpha: 1)
        
        toolBar = UIToolbar()
        toolBar.sizeToFit()
        let toolBarBtn = UIBarButtonItem(title: "DONE", style: .plain, target: self, action: "doneBtn")
        toolBar.items = [toolBarBtn]
        LocalTimeForCalling.inputAccessoryView = toolBar
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // without tapping, the keyboard will show automatically.
        callingNametextFild.becomeFirstResponder()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

// need the function that make sure everything is filled and that change value of adddBarButton.isEnabled after check that.

extension addCallingItemViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        callingNametextFild.resignFirstResponder()
        return false
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let oldText = textField.text,
            let stringRange = Range(range, in: oldText) else {
                return false
        }
        
        
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        if newText.isEmpty {
            addBarButton.isEnabled = false
        } else {
            addBarButton.isEnabled = true
        }
        
        return true
    }
    
    //テキストフィールドが選択されたらdatepickerを表示
    @IBAction func timeEditing(sender: UITextField) {
        let datePickerView:UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePicker.Mode.date
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: Selector("datePickerValueChanged"), for: UIControl.Event.valueChanged)
    }
    
    
    //datepickerが選択されたらtextfieldに表示
    func datePickerValueChanged(sender:UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat  = "yyyy/MM/dd";
        LocalTimeForCalling.text = dateFormatter.string(from: sender.date)
    }
    
    func doneBtn(){
        LocalTimeForCalling.resignFirstResponder()
    }
}



