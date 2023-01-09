//
//  ResultVC.swift
//  HEMPDAY
//
//  Created by admin on 12/24/20.
//  Copyright © 2020 Chandradip. All rights reserved.
//

import UIKit

class ResultVC: UIViewController {
    @IBOutlet weak var usernameLbl : UILabel!
    @IBOutlet weak var usernameBackView : UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameBackView.layer.borderWidth = 1.0
        usernameBackView.layer.borderColor = UIColor.black.cgColor
        if UserDefaults.standard.value(forKey: "isLogin") as? String == "Yes"{
        usernameLbl.text = "\(UserDefaults.standard.value(forKey: "UserName") as! String)!"
        usernameLbl.isHidden = false
        }else{
            usernameLbl.isHidden = true
        }
    }
    
    @IBAction func resultButtonAction( _ sender : UIButton){
        if UserDefaults.standard.value(forKey: "isLogin") as? String == "Yes"{
        let vc = storyboard?.instantiateViewController(identifier: "ShawProductResultVC") as! ShawProductResultVC
        self.navigationController?.pushViewController(vc, animated: true)
        }else{
             for controller in self.navigationController!.viewControllers as Array {
              if controller.isKind(of: LoginVC.self) {
                 UserDefaults.standard.setValue(true, forKey: "viewResult")
                self.navigationController!.popToViewController(controller, animated: true)
                break
                }
            }
        }
    }
    
    @IBAction func backtButtonAction( _ sender : UIButton){
        if UserDefaults.standard.value(forKey: "isLogin") as? String == "Yes"{
            for controller in self.navigationController!.viewControllers as Array {
                if controller.isKind(of: HomeVC.self) {
                    self.navigationController!.popToViewController(controller, animated: true)
                    break
                }
            }
            }else{
             for controller in self.navigationController!.viewControllers as Array {
              if controller.isKind(of: LoginVC.self) {
                self.navigationController!.popToViewController(controller, animated: true)
                break
                }
            }
        }
    }
}
