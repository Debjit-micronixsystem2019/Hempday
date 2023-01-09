//
//  HempDayVC.swift
//  HEMPDAY
//
//  Created by admin on 12/23/20.
//  Copyright © 2020 Chandradip. All rights reserved.
//

import UIKit

class HempDayVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func backButtonAction( _ sender : UIButton){
        self.navigationController?.popViewController(animated: true)
    }

}
