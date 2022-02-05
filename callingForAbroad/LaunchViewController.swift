//
//  LaunchViewController.swift
//  checklist
//
//  Created by 北島　志帆美 on 2020-06-07.
//  Copyright © 2020 北島　志帆美. All rights reserved.
//

import UIKit

class LaunchViewController: UIViewController {

    @IBOutlet weak var iconImageView: IconAnimationImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        iconImageView.delegate = self
        
        self.navigationController?.navigationBar.isHidden = true
        
        iconImageView.center.x = self.view.center.x
        iconImageView.frame.origin.y = self.view.frame.origin.y - iconImageView.frame.height
        
        UIView.animate(withDuration: 0.5, animations: {
            
            self.iconImageView.center.y = self.view.center.y

            
        }, completion: { _ in
            self.iconImageView.bounceAction()
        })
        
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

extension LaunchViewController:pushHomeVCDelegate {
    func push() {
        
        self.navigationController?.navigationBar.isHidden = false
        
        guard let vc = self.storyboard?.instantiateViewController(identifier: "home") as? callinglistViewController else {
            fatalError()
        }
        
        self.navigationController?.pushViewController(vc, animated: false)
    }
}
