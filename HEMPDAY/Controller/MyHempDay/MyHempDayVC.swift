//
//  MyHempDayVC.swift
//  HEMPDAY
//
//  Created by admin on 12/29/20.
//  Copyright © 2020 Chandradip. All rights reserved.
//

import UIKit
import MBProgressHUD

class MyHempDayVC: UIViewController {
    
    @IBOutlet weak var offerLbl : UILabel!
    @IBOutlet weak var startLbl : UILabel!
    @IBOutlet weak var endLbl : UILabel!
    @IBOutlet weak var offerVW : UIView!
    @IBOutlet private var btn1: UIButton!
    @IBOutlet private var happyHempDayLbl: UILabel!{
        didSet{
            happyHempDayLbl.text = "TAP TO SEE YOUR GIFT"
        }
    }
    

    var jsonFetch = jasonFetchClass()
    
    let ballon = ["balloon1","balloon2","balloon3","balloon4","balloon5","balloon6","balloon7"]


    override func viewDidLoad() {
        super.viewDidLoad()

        jsonFetch.jsondata = self
        offerVW.isHidden = true
    }
    
   override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
           
    override func viewWillDisappear(_ animated: Bool) {
            self.navigationController?.isNavigationBarHidden = true
        }
    @IBAction func backtButtonAction( _ sender : UIButton){
           self.navigationController?.popViewController(animated: true)
       }
    
    @IBAction func hempButtonAction( _ sender : UIButton){
        fetcchMyHempdata()
    }
    
   
    
    func fetcchMyHempdata() {
           let param = [
              "authorised_key":"SGVtcERheTIwMjAj"
               ]
           print("param",param)
           MBProgressHUD.showAdded(to: (self.view)!, animated: true)
           jsonFetch.fetchData(param, methodtype: "post", url: baseUrl + "/get_offer", jsonname: "get_offer")
       }
}
extension MyHempDayVC : jsonDataDelegate {
    func didReceivedData(_ data: Any, jsonname: String) {
        print("Raw Data>>",data)
        print("Jsonname>>",jsonname)
        if data as? String ==  "NO INTERNET CONNECTION" {
            DispatchQueue.main.async { MBProgressHUD.hide(for: (self.view)!, animated: true) }
            showAlertMessageokkk(alertTitle: "NETWORK !", alertMsg: "CHECK YOUR INTERNET CONNECTION PLEASE")
        } else {
            print(data as! NSDictionary)
            if ((data as! NSDictionary).object(forKey: "status") as! String) == "Yes" {
              
                       UIButton.animate(withDuration: 0.5, delay: 0.0, options: UIButton.AnimationOptions.curveEaseIn, animations: {
                              // HERE
                           self.btn1.transform = CGAffineTransform.identity.scaledBy(x: 1.5, y: 1.5) // Scale your image
                        }) { (finished) in
                            UIView.animate(withDuration: 1, animations: {
                             self.btn1.transform = CGAffineTransform.identity // undo in 1 seconds
                          })
                       }
                
                endLbl.text = ((data as! NSDictionary).object(forKey: "end_date") as! String)
                startLbl.text = ((data as! NSDictionary).object(forKey: "start_date") as! String)
                offerLbl.text = ((data as! NSDictionary).object(forKey: "details") as! String)
                 offerVW.isHidden = false
                happyHempDayLbl.text = "HAPPY HEMP DAY!"
                DispatchQueue.main.async { MBProgressHUD.hide(for: (self.view)!, animated: true) }
            } else {
                //Alert here..
                if ((data as! NSDictionary).object(forKey: "status") as! String) == "No"{
                    DispatchQueue.main.async { MBProgressHUD.hide(for: (self.view)!, animated: true) }
                    showAlertMessageokkk(alertTitle: "HEMPDAY !", alertMsg: "CURRENT OFFER NOT AVAILABLE")
                }else{
                    DispatchQueue.main.async { MBProgressHUD.hide(for: (self.view)!, animated: true) }
                    showAlertMessageokkk(alertTitle: "HEMPDAY !", alertMsg: "PLEASE TRY AGAIN LATER.")
                }
            }
        }
    }
    
    func didFailedReceivedData(_ error: Error) {
        print(error.localizedDescription)
        DispatchQueue.main.async { MBProgressHUD.hide(for: (self.view)!, animated: true) }
        showAlertMessageokkk(alertTitle: "HEMPDAY !", alertMsg: "PLEASE TRY AGAIN LATER.")
    }
}

/*extension MyHempDayVC{

       
       fileprivate func createBallon(x : CGFloat){
         //  var i = 1
           ballon.forEach { (ballonName) in
               let ballonImage = UIImage(named: ballonName)
              let ballonImageView = UIImageView(image: ballonImage)
            print(btn1.frame,"btn")
              
               ballonImageView.frame = CGRect(x: Int(ballonVW.frame.origin.x), y: Int(ballonVW.frame.origin.y + 100), width: 50, height: Int(30))
            print(ballonImageView.frame,"ballonImageView")
             
               ballonImageView.contentMode = .scaleAspectFit
               view.addSubview(ballonImageView)
         //      i += 72
               animateBallon(ballonImageView: ballonImageView)
           }
       }
       
     /*  fileprivate func createBallon1(x : CGFloat){
         //  var i = 1
           ballon.forEach { (ballonName) in
               let ballonImage = UIImage(named: ballonName)
              let ballonImageView = UIImageView(image: ballonImage)
            //   ballonImageView.backgroundColor = UIColor.red
              
               ballonImageView.frame = CGRect(x: Int(btn1.frame.origin.x + 60), y: Int(btn1.frame.origin.y - 30), width: 50, height: Int(30))
             
               ballonImageView.contentMode = .scaleAspectFit
               view.addSubview(ballonImageView)
         //      i += 72
               animateBallon2(ballonImageView: ballonImageView)
           }
       }
       fileprivate func createBallon2(x : CGFloat){
         //  var i = 1
           ballon.forEach { (ballonName) in
               let ballonImage = UIImage(named: ballonName)
              let ballonImageView = UIImageView(image: ballonImage)
            //   ballonImageView.backgroundColor = UIColor.red
              
               ballonImageView.frame = CGRect(x: Int(btn1.frame.origin.x + 30), y: Int(btn1.frame.origin.y - 30), width: 50, height: Int(30))
             
               ballonImageView.contentMode = .scaleAspectFit
               view.addSubview(ballonImageView)
         //      i += 72
               animateBallon3(ballonImageView: ballonImageView)
           }
       }
       fileprivate func createBallon3(x : CGFloat){
         //  var i = 1
           ballon.forEach { (ballonName) in
               let ballonImage = UIImage(named: ballonName)
              let ballonImageView = UIImageView(image: ballonImage)
            //   ballonImageView.backgroundColor = UIColor.red
              
               ballonImageView.frame = CGRect(x: Int(btn1.frame.origin.x + 120), y: Int(btn1.frame.origin.y - 30), width: 50, height: Int(30))
             
               ballonImageView.contentMode = .scaleAspectFit
               view.addSubview(ballonImageView)
         //      i += 72
               animateBallon4(ballonImageView: ballonImageView)
           }
       }
       fileprivate func createBallon4(x : CGFloat){
         //  var i = 1
           ballon.forEach { (ballonName) in
               let ballonImage = UIImage(named: ballonName)
              let ballonImageView = UIImageView(image: ballonImage)
            //   ballonImageView.backgroundColor = UIColor.red
              
               ballonImageView.frame = CGRect(x: Int(btn1.frame.origin.x + 150), y: Int(btn1.frame.origin.y - 30), width: 50, height: Int(30))
             
               ballonImageView.contentMode = .scaleAspectFit
               view.addSubview(ballonImageView)
         //      i += 72
               animateBallon5(ballonImageView: ballonImageView)
           }
       }*/
       
       
       fileprivate func animateBallon(ballonImageView: UIImageView){
           let delay = Int.random(in: 0..<4)
           UIView.animate(withDuration: 2.0, delay: Double(delay), animations: {
               ballonImageView.center.y = -50
           })
       }
       
  /*     fileprivate func animateBallon2(ballonImageView: UIImageView){
           let delay = Int.random(in: 0..<1)
           UIView.animate(withDuration: 4.0, delay: Double(delay), animations: {
               ballonImageView.center.y = -50
           })
       }
       
       fileprivate func animateBallon3(ballonImageView: UIImageView){
           let delay = Int.random(in: 0..<2)
           UIView.animate(withDuration: 5.0, delay: Double(delay), animations: {
               ballonImageView.center.y = -50
           })
       }
       fileprivate func animateBallon4(ballonImageView: UIImageView){
           let delay = Int.random(in: 0..<3)
           UIView.animate(withDuration: 5.0, delay: Double(delay), animations: {
               ballonImageView.center.y = -50
           })
       }
       fileprivate func animateBallon5(ballonImageView: UIImageView){
           let delay = Int.random(in: 0..<1)
           UIView.animate(withDuration: 5.0, delay: Double(delay), animations: {
               ballonImageView.center.y = -50
           })
       }*/
}*/
