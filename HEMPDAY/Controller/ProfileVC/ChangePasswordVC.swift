//
//  ChangePasswordVC.swift
//  HEMPDAY
//
//  Created by admin on 12/23/20.
//  Copyright © 2020 Chandradip. All rights reserved.
//

import UIKit
import ACFloatingTextfield_Swift
import MBProgressHUD

class ChangePasswordVC: UIViewController {
    
    @IBOutlet weak var oldPasswordTextfield : ACFloatingTextfield!
    @IBOutlet weak var newPasswordTextfield : ACFloatingTextfield!
    @IBOutlet weak var confirmPasswordTextfield : ACFloatingTextfield!
    
    var jsonFetch = jasonFetchClass()
    let aTextField = ACFloatingTextfield()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        jsonFetch.jsondata = self
        
    }
    override func viewWillAppear(_ animated: Bool) {
          self.navigationController?.isNavigationBarHidden = true
      }
             
      override func viewWillDisappear(_ animated: Bool) {
          self.navigationController?.isNavigationBarHidden = true
      }
      
      func setupUI() {
        
          aTextField.delegate = self
          oldPasswordTextfield.delegate = self
          newPasswordTextfield.delegate = self
          confirmPasswordTextfield.delegate = self
          
          oldPasswordTextfield.placeholder = "OLD PASSWORD"
          oldPasswordTextfield.placeHolderColor = UIColor(named: "Color4")!
          oldPasswordTextfield.selectedPlaceHolderColor = UIColor(named: "Color4")!
          newPasswordTextfield.placeholder = "NEW PASSWORD"
          newPasswordTextfield.placeHolderColor = UIColor(named: "Color4")!
          newPasswordTextfield.selectedPlaceHolderColor = UIColor(named: "Color4")!
          confirmPasswordTextfield.placeholder = "CONFIRM PASSWORD"
          confirmPasswordTextfield.placeHolderColor = UIColor(named: "Color4")!
          confirmPasswordTextfield.selectedPlaceHolderColor = UIColor(named: "Color4")!
         hideKeyboardWhenTappedAround()
         
      }
      
    func hideKeyboardWhenTappedAround() {
           let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ChangePasswordVC.dismissKeyboard))
           tap.cancelsTouchesInView = false
           view.addGestureRecognizer(tap)
       }
       
       @objc func dismissKeyboard() {
           view.endEditing(true)
       }

      @IBAction func changePasswordButtonAction( _ sender : UIButton){
         
        if (oldPasswordTextfield.text!.trimmingCharacters(in: .whitespaces).isEmpty){
                      shawErrorMSG(txtField : oldPasswordTextfield, error : "*CAN'T BE BLANK")
              }else if (newPasswordTextfield.text!.trimmingCharacters(in: .whitespaces).isEmpty){
                      shawErrorMSG(txtField : newPasswordTextfield, error : "*CAN'T BE BLANK")
             }else if newPasswordTextfield.text != confirmPasswordTextfield.text{
                 shawErrorMSG(txtField : confirmPasswordTextfield, error : "*PASSWORD NOT MATCH")
             }else{
                changepassword()
                }
            }
            
    func shawErrorMSG(txtField : ACFloatingTextfield, error : String) {
        txtField.errorTextColor =  UIColor(named: "Color4")!
        txtField.errorLineColor = UIColor.clear
        txtField.showErrorWithText(errorText: error)
        }
      
      @IBAction func backButtonAction( _ sender : UIButton){
          self.navigationController?.popViewController(animated: true)
      }
      
      func changepassword() {
          let param = [
              "authorised_key":"SGVtcERheTIwMjAj",
              "user_id":UserDefaults.standard.value(forKey: "UserId"),
              "password":newPasswordTextfield.text!
          ]
          print("param",param)
          MBProgressHUD.showAdded(to: (self.view)!, animated: true)
          jsonFetch.fetchData(param, methodtype: "post", url: baseUrl + "/change_password", jsonname: "change_password")
      }

}
extension  ChangePasswordVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == oldPasswordTextfield {
            newPasswordTextfield.becomeFirstResponder()
        }else if textField == newPasswordTextfield{
            confirmPasswordTextfield.becomeFirstResponder()
        } else {
            confirmPasswordTextfield.resignFirstResponder()
        }
        return true
    }
}

extension ChangePasswordVC : jsonDataDelegate {
    func didReceivedData(_ data: Any, jsonname: String) {
        print("Raw Data>>",data)
        print("Jsonname>>",jsonname)
        if data as? String ==  "NO INTERNET CONNECTION" {
            DispatchQueue.main.async { MBProgressHUD.hide(for: (self.view)!, animated: true) }
            showAlertMessageokkk(alertTitle: "NETWORK !", alertMsg: "CHECK YOUR INTERNET CONNECTION PLEASE")
        } else {
            print(data as! NSDictionary)
            if ((data as! NSDictionary).object(forKey: "status") as! String) == "Yes" {
                
                showAlertMessageokkk(alertTitle: "HEMPDAY !", alertMsg: "USER PASSWORD CHANGED SUCCESSFULLY.")
                newPasswordTextfield.text = ""
                oldPasswordTextfield.text = ""
                confirmPasswordTextfield.text = ""
                
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


