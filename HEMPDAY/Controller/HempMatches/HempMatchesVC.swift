//
//  HempMatchesVC.swift
//  HEMPDAY
//
//  Created by admin on 12/18/20.
//  Copyright © 2020 Chandradip. All rights reserved.
//

import UIKit

class HempMatchesVC: UIViewController {
    
    @IBOutlet weak var takeQuizBackView : UIView!


    override func viewDidLoad() {
        super.viewDidLoad()

       takeQuizBackView.layer.borderWidth = 2.0
       takeQuizBackView.layer.borderColor = UIColor.darkGray.cgColor
     
    }
    
    @IBAction func backButtonAction( _ sender : UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func takeTheQuizButtonAction( _ sender : UIButton){
        let vc = storyboard?.instantiateViewController(identifier: "TakeQuizVC") as! TakeQuizVC
        self.navigationController?.pushViewController(vc, animated: true)
      }
}
