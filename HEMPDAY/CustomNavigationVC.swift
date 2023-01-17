//
//  CustomNavigationVC.swift
//  HEMPDAY
//
//  Created by admin on 12/17/20.
//  Copyright © 2020 Chandradip. All rights reserved.
//

import UIKit

class CustomNavigationVC: UIViewController {
    
    @IBOutlet weak var navView : UIView!
    @IBOutlet weak var menuButton : UIButton!
    
     @IBOutlet weak var slideView : UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
            hidemenuview()
       
    }
    @IBAction func menuBtn( _ sender : UIButton) {
        self.slideView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        UIApplication.shared.keyWindow!.addSubview(slideView)
      print(123)
    }
    
    func  hidemenuview() {
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(CustomNavigationVC.dismissmenuview))
        tap.cancelsTouchesInView = false
        slideView.addGestureRecognizer(tap)
    }
    
    @objc func dismissmenuview() {
        slideView.removeFromSuperview()
    }

}
