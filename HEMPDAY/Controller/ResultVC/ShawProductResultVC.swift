//
//  ShawProductResultVC.swift
//  HEMPDAY
//
//  Created by admin on 12/28/20.
//  Copyright © 2020 Chandradip. All rights reserved.
//

import UIKit
import MBProgressHUD
import SDWebImage
//import Kingfisher

class ShawProductResultVC: UIViewController {
    
    @IBOutlet weak var productNameLbl : UILabel!
    @IBOutlet weak var productPriceLbl : UILabel!
    @IBOutlet weak var productImg : UIImageView!
    @IBOutlet weak var topView : UIView!
    @IBOutlet weak var plantBTn : UIButton!
    @IBOutlet weak var moreBTn : UIButton!
    
    var jsonFetch = jasonFetchClass()
    var current_exam_id = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        productNameLbl.isHidden = true
        productPriceLbl.isHidden = true
        productImg.isHidden = true
        topView.isHidden = true
        plantBTn.isHidden = true
        moreBTn.isHidden = true
        
        jsonFetch.jsondata = self
        fetcchResultdata()
    }
    
    func fetcchResultdata() {
        let param = [
            "authorised_key":"SGVtcERheTIwMjAj",
            "user_id":UserDefaults.standard.value(forKey: "UserId"),
            "question_id":selectAnswer.selectQuestionID,
            "answer_id":selectAnswer.selectAnswerOptionID
            ]
        print("param",param)
        MBProgressHUD.showAdded(to: (self.view)!, animated: true)
        jsonFetch.fetchData(param, methodtype: "post", url: baseUrl + "/result", jsonname: "result")
    }
    
    @IBAction func GoShopButtonAction( _ sender : UIButton){
       let vc = storyboard?.instantiateViewController(identifier: "ViewPriceVC") as! ViewPriceVC
         vc.exam_id = current_exam_id
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func ShawMeButtonAction( _ sender : UIButton){
          let vc = storyboard?.instantiateViewController(identifier: "ShawmeMoreVC") as! ShawmeMoreVC
        vc.exam_id = current_exam_id
           self.navigationController?.pushViewController(vc, animated: true)
       }
    
    @IBAction func backtButtonAction( _ sender : UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func goHomeButtonAction( _ sender : UIButton){
        for controller in self.navigationController!.viewControllers as Array {
          if controller.isKind(of: HomeVC.self) {
            self.navigationController!.popToViewController(controller, animated: true)
            break
            }
        }
    }
}

extension ShawProductResultVC : jsonDataDelegate {
    func didReceivedData(_ data: Any, jsonname: String) {
        print("Raw Data>>",data)
        print("Jsonname>>",jsonname)
        if data as? String ==  "NO INTERNET CONNECTION" {
            DispatchQueue.main.async { MBProgressHUD.hide(for: (self.view)!, animated: true) }
            showAlertMessageokkk(alertTitle: "NETWORK !", alertMsg: "CHECK YOUR INTERNET CONNECTION PLEASE")
        } else {
            print(data as! NSDictionary)
            if ((data as! NSDictionary).object(forKey: "status") as! String) == "Yes" {
                
                let proImG = ((data as! NSDictionary).object(forKey: "product_image") as! String)
                productImg.sd_imageIndicator = SDWebImageActivityIndicator.gray
              
                productImg.sd_setImage(with: URL(string: proImG), placeholderImage: UIImage(named: "loader"))
                
              // let url = URL(string: ((data as! NSDictionary).object(forKey: "product_image") as! String))
               // productImg.kf.setImage(with: url)
               
                productNameLbl.text = ((data as! NSDictionary).object(forKey: "product_name") as! String)
                
                 productPriceLbl.text = "$\((data as! NSDictionary).object(forKey: "product_prise") as! String)"
                current_exam_id = ((data as! NSDictionary).object(forKey: "exam_id") as! String)
                
                productNameLbl.isHidden = false
                productPriceLbl.isHidden = false
                productImg.isHidden = false
                topView.isHidden = false
                plantBTn.isHidden = false
                moreBTn.isHidden = false
                
                UserDefaults.standard.setValue(false, forKey: "viewResult")
    
                DispatchQueue.main.async { MBProgressHUD.hide(for: (self.view)!, animated: true) }
            } else {
                //Alert here..
            /*    let proImG = "http://developer.marketingplatform.ca/hempday/public/product/Orange_Cookies.jpg"
                  productImg.sd_imageIndicator = SDWebImageActivityIndicator.gray
                
                  productImg.sd_setImage(with: URL(string: proImG), placeholderImage: UIImage(named: "loader"))
                
                productNameLbl.text = "ORANGE COOKIES"
                               
                productPriceLbl.text = "$0"
                productNameLbl.isHidden = false
                               productPriceLbl.isHidden = false
                               productImg.isHidden = false
                               topView.isHidden = false
                               plantBTn.isHidden = false
                               moreBTn.isHidden = false
                 UserDefaults.standard.setValue(false, forKey: "viewResult")*/
                DispatchQueue.main.async { MBProgressHUD.hide(for: (self.view)!, animated: true) }
                showAlertMessageokkk(alertTitle: "HEMPDAY !", alertMsg: "NO PRODUCT AVAILABLE.")
                
            }
        }
    }
    
    func didFailedReceivedData(_ error: Error) {
        print(error.localizedDescription)
        DispatchQueue.main.async { MBProgressHUD.hide(for: (self.view)!, animated: true) }
        showAlertMessageokkk(alertTitle: "HEMPDAY !", alertMsg: "PLEASE TRY AGAIN LATER.")
    }
}
