//
//  AgePermissionViewController.swift
//  HEMPDAY
//
//  Created by Shaoli Ghosh on 04/01/23.
//  Copyright © 2023 Chandradip. All rights reserved.
//

import UIKit

class AgeAlertViewController: UIViewController {
    
    @IBOutlet weak var ageAlertBackView : UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ageAlertBackView.layer.cornerRadius = 50
    }
    
    @IBAction func yesButtonAction( _ sender : UIButton){
        UserDefaults.standard.setValue("Yes", forKey: "ageAlert")
        self.dismiss(animated: true)
    }
    
    @IBAction func noButtonAction( _ sender : UIButton){
        let alertController = UIAlertController(title: "HEMPDAY !", message: "You need to be at least 21 years old to use Hempday.", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) {
            (action: UIAlertAction) in
            alertController.dismiss(animated: true)
        }
     alertController.setBackgroundColor(color: UIColor(named: "Color4")!)
     alertController.setTitlet(font: UIFont(name: "FingerPaint-Regular", size: 25.00), color: UIColor(named: "Color1"))
     alertController.setMessage(font: UIFont(name: "FingerPaint-Regular", size: 16.00), color: UIColor(named: "Color1"))
     OKAction.setValue(UIColor(named: "Color1"), forKey: "titleTextColor")
     alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
