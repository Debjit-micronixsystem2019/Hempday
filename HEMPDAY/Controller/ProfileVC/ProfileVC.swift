//
//  ProfileVC.swift
//  HEMPDAY
//
//  Created by admin on 12/23/20.
//  Copyright © 2020 Chandradip. All rights reserved.
//

import UIKit
import ACFloatingTextfield_Swift
import MBProgressHUD
import SDWebImage

class ProfileVC: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var nameTextfield : ACFloatingTextfield!
    @IBOutlet weak var usernameTextfield : ACFloatingTextfield!
    @IBOutlet weak var emailnameTextfield : ACFloatingTextfield!
    @IBOutlet weak var dateofbithTextfield : ACFloatingTextfield!
    
    @IBOutlet weak var passportImgVW : UIImageView!
    @IBOutlet weak var identificationImgVW : UIImageView!

    
    var jsonFetch = jasonFetchClass()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        jsonFetch.jsondata = self
        fetcchProfiledata()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
           
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func setupUI() {
       
        usernameTextfield.delegate = self
        dateofbithTextfield.delegate = self
        nameTextfield.delegate = self
        emailnameTextfield.delegate = self
        
        nameTextfield.placeholder = "NAME"
        nameTextfield.placeHolderColor = UIColor(named: "Color4")!
        nameTextfield.selectedPlaceHolderColor = UIColor(named: "Color4")!
        emailnameTextfield.placeholder = "EMAIL"
        emailnameTextfield.placeHolderColor = UIColor(named: "Color4")!
        emailnameTextfield.selectedPlaceHolderColor = UIColor(named: "Color4")!
        usernameTextfield.placeholder = "USERNAME"
        usernameTextfield.placeHolderColor = UIColor(named: "Color4")!
        usernameTextfield.selectedPlaceHolderColor = UIColor(named: "Color4")!
        dateofbithTextfield.placeholder = "DATE OF BIRTH"
        dateofbithTextfield.placeHolderColor = UIColor(named: "Color4")!
        dateofbithTextfield.selectedPlaceHolderColor = UIColor(named: "Color4")!
       
    }
    

    @IBAction func changePasswordButtonAction( _ sender : UIButton){
       let vc = storyboard?.instantiateViewController(identifier: "ChangePasswordVC") as! ChangePasswordVC
       self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func backButtonAction( _ sender : UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    func fetcchProfiledata() {
        let param = [
            "authorised_key":"SGVtcERheTIwMjAj",
            "user_id":UserDefaults.standard.value(forKey: "UserId")
        ]
        print("param",param)
        MBProgressHUD.showAdded(to: (self.view)!, animated: true)
        jsonFetch.fetchData(param, methodtype: "post", url: baseUrl + "/fetch_profile", jsonname: "fetch_profile")
    }
    
    
}

extension ProfileVC : jsonDataDelegate {
    func didReceivedData(_ data: Any, jsonname: String) {
        print("Raw Data>>",data)
        print("Jsonname>>",jsonname)
        if data as? String ==  "NO INTERNET CONNECTION" {
            DispatchQueue.main.async { MBProgressHUD.hide(for: (self.view)!, animated: true) }
            showAlertMessageokkk(alertTitle: "NETWORK !", alertMsg: "CHECK YOUR INTERNET CONNECTION PLEASE")
        } else {
            print(data as! NSDictionary)
            if ((data as! NSDictionary).object(forKey: "status") as! String) == "Yes" {
                
                nameTextfield.text = (((data as! NSDictionary).object(forKey: "data") as! NSDictionary).value(forKey: "name") as! String)
                usernameTextfield.text = (((data as! NSDictionary).object(forKey: "data") as! NSDictionary).value(forKey: "user_name") as! String)
                emailnameTextfield.text = (((data as! NSDictionary).object(forKey: "data") as! NSDictionary).value(forKey: "email") as! String)
                dateofbithTextfield.text = (((data as! NSDictionary).object(forKey: "data") as! NSDictionary).value(forKey: "birthday") as! String)
                
                let passImG = (((data as! NSDictionary).object(forKey: "data") as! NSDictionary).value(forKey: "passport_image") as! String)
                passportImgVW.sd_imageIndicator = SDWebImageActivityIndicator.gray
                passportImgVW.sd_setImage(with: URL(string: passImG), placeholderImage: UIImage(named: "passPort"))
                
                let identificationIMG = (((data as! NSDictionary).object(forKey: "data") as! NSDictionary).value(forKey: "identify_image") as! String)
                identificationImgVW.sd_imageIndicator = SDWebImageActivityIndicator.gray
                identificationImgVW.sd_setImage(with: URL(string: identificationIMG), placeholderImage: UIImage(named: "Identification"))
    
                DispatchQueue.main.async { MBProgressHUD.hide(for: (self.view)!, animated: true) }
            } else {
                //Alert here..
                DispatchQueue.main.async { MBProgressHUD.hide(for: (self.view)!, animated: true) }
                showAlertMessageokkk(alertTitle: "HEMPDAY !", alertMsg: "PLEASE TRY AGAIN LATER.")
                
            }
        }
    }
    
    func didFailedReceivedData(_ error: Error) {
        print(error.localizedDescription)
        DispatchQueue.main.async { MBProgressHUD.hide(for: (self.view)!, animated: true) }
        showAlertMessageokkk(alertTitle: "HEMPDAY !", alertMsg: "PLEASE TRY AGAIN LATER.")
    }
}
