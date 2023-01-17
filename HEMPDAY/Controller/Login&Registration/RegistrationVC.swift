//
//  RegistrationVC.swift
//  HEMPDAY
//
//  Created by admin on 12/11/20.
//  Copyright © 2020 Chandradip. All rights reserved.
//

import UIKit
import ACFloatingTextfield_Swift
import MBProgressHUD


class RegistrationVC: UIViewController {

        @IBOutlet weak var nameTextfield : ACFloatingTextfield!
        @IBOutlet weak var usernameTextfield : ACFloatingTextfield!
        @IBOutlet weak var emailnameTextfield : ACFloatingTextfield!
        @IBOutlet weak var dateofbithTextfield : ACFloatingTextfield!
        @IBOutlet weak var passwordTextfield : ACFloatingTextfield!
        @IBOutlet weak var confirmPasswordTextfield : ACFloatingTextfield!
        let aTextField = ACFloatingTextfield()
        var jsonFetch = jasonFetchClass()
        var datePicker = UIDatePicker()

        override func viewDidLoad() {
            super.viewDidLoad()
            jsonFetch.jsondata = self
            setupUI()
           // dateofbirth()
            showDatePicker()
        }
        override func viewWillAppear(_ animated: Bool) {
            self.navigationController?.isNavigationBarHidden = true
          //  ageAlertPopUp()
        }
        
        override func viewWillDisappear(_ animated: Bool) {
            self.navigationController?.isNavigationBarHidden = true
        }
        
        func setupUI() {
            TxtFiedDelegate()
            aTextField.delegate = self
            
            nameTextfield.placeholder = "NAME"
            nameTextfield.placeHolderColor = UIColor(named: "Color4")!
            nameTextfield.selectedPlaceHolderColor = UIColor(named: "Color4")!
            emailnameTextfield.placeholder = "EMAIL"
            emailnameTextfield.placeHolderColor = UIColor(named: "Color4")!
            emailnameTextfield.selectedPlaceHolderColor = UIColor(named: "Color4")!
            confirmPasswordTextfield.placeholder = "CONFIRM PASSWORD"
            confirmPasswordTextfield.placeHolderColor = UIColor(named: "Color4")!
            confirmPasswordTextfield.selectedPlaceHolderColor = UIColor(named: "Color4")!
            
            passwordTextfield.placeholder = "PASSWORD"
            passwordTextfield.placeHolderColor = UIColor(named: "Color4")!
            passwordTextfield.selectedPlaceHolderColor = UIColor(named: "Color4")!
            usernameTextfield.placeholder = "USERNAME"
            usernameTextfield.placeHolderColor = UIColor(named: "Color4")!
            usernameTextfield.selectedPlaceHolderColor = UIColor(named: "Color4")!
            dateofbithTextfield.placeholder = "DATE OF BIRTH"
            dateofbithTextfield.placeHolderColor = UIColor(named: "Color4")!
            dateofbithTextfield.selectedPlaceHolderColor = UIColor(named: "Color4")!
            hideKeyboardWhenTappedAround()
        }
        
        func hideKeyboardWhenTappedAround() {
            let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(RegistrationVC.dismissKeyboard))
            tap.cancelsTouchesInView = false
            view.addGestureRecognizer(tap)
        }
        
        @objc func dismissKeyboard() {
            view.endEditing(true)
        }
    
    func ageAlertPopUp(){
        let vc = storyboard?.instantiateViewController(identifier: "AgeAlertViewController") as! AgeAlertViewController
         vc.modalPresentationStyle = .overFullScreen
         self.present(vc, animated: true, completion: nil)
    }
    
    func showDatePicker() {
        //Formate Date

        datePicker.datePickerMode = .date
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));

        toolbar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        
        dateofbithTextfield.inputAccessoryView = toolbar
        dateofbithTextfield.inputView = datePicker
        
    }
    
    @objc func donedatePicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        dateofbithTextfield.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    
  /*  func dateofbirth(){
        datepicker = UIDatePicker()
        datepicker?.datePickerMode = .date
        datepicker?.addTarget(self, action: #selector(RegistrationVC.datechanged(datepicker:)), for: .valueChanged)

        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(RegistrationVC.viewtapped(gestureRecognizer:)))
        
        doneButtonInDatePickerView()
               
        view.addGestureRecognizer(tapgesture)
        dateofbithTextfield.inputView = datepicker
    }
    
    @objc func viewtapped(gestureRecognizer: UITapGestureRecognizer){
           view.endEditing(true)
       }
       @objc func datechanged(datepicker: UIDatePicker){
           let dateformatter = DateFormatter()
           dateformatter.dateFormat = "dd/MM/yyyy"
           dateofbithTextfield.text = dateformatter.string(from: datepicker.date)
        print(dateformatter.string(from: datepicker.date))
       //    view.endEditing(true)
       }
    
    func doneButtonInDatePickerView(){
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(onClickDoneButton))
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(onClickCancelButton))
        toolBar.setItems([cancelButton, space, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        toolBar.sizeToFit()
        dateofbithTextfield.inputAccessoryView = toolBar
    }
    
    
    @objc func onClickDoneButton() {
        self.view.endEditing(true)
    }
    
    @objc func onClickCancelButton() {
        self.view.endEditing(true)
    }*/
    
    
    
        
    func fetcchRegdata() {
        let param = [
            "authorised_key":"SGVtcERheTIwMjAj",
            "name":nameTextfield.text!,
            "user_name":usernameTextfield.text!,
            "email":emailnameTextfield.text!,
            "password":passwordTextfield.text!,
            "confirm_password":confirmPasswordTextfield.text!,
            "birthday":dateofbithTextfield.text!
        ]
        print("param",param)
        MBProgressHUD.showAdded(to: (self.view)!, animated: true)
        jsonFetch.fetchData(param, methodtype: "post", url: baseUrl + "/register", jsonname: "register")
    }
    
        @IBAction func signupButtonAction( _ sender : UIButton){
          //  let vc = storyboard?.instantiateViewController(identifier: "AgeVerifyVC") as! AgeVerifyVC
         //   self.navigationController?.pushViewController(vc, animated: true)
            
            if (nameTextfield.text!.trimmingCharacters(in: .whitespaces).isEmpty){
                shawErrorMSG(txtField : nameTextfield, error : "*CAN'T BE BLANK")
            }else if (usernameTextfield.text!.trimmingCharacters(in: .whitespaces).isEmpty){
                shawErrorMSG(txtField : usernameTextfield, error : "*CAN'T BE BLANK")
                
            }else if (emailnameTextfield.text!.trimmingCharacters(in: .whitespaces).isEmpty){
                shawErrorMSG(txtField : emailnameTextfield, error : "*CAN'T BE BLANK")
                
            }else if (dateofbithTextfield.text!.trimmingCharacters(in: .whitespaces).isEmpty){
                shawErrorMSG(txtField : dateofbithTextfield, error : "*CAN'T BE BLANK")
                
            }
            else if (passwordTextfield.text!.trimmingCharacters(in: .whitespaces).isEmpty){
                shawErrorMSG(txtField : passwordTextfield, error : "*CAN'T BE BLANK")
                
            }else if passwordTextfield.text != confirmPasswordTextfield.text{
                shawErrorMSG(txtField : confirmPasswordTextfield, error : "*PASSWORD NOT MATCH")
            } else {
                if isValidEmail(emailStr: emailnameTextfield.text!) != true{
                    shawErrorMSG(txtField : emailnameTextfield, error : "*PLEASE FILL WITH RIGHT THE EMAIL ID.")
                    }else{
                     fetcchRegdata()
                }
            }
        }
    
    func shawErrorMSG(txtField : ACFloatingTextfield, error : String) {
        txtField.errorTextColor =  UIColor(named: "Color4")!
        txtField.errorLineColor = UIColor.clear
        txtField.showErrorWithText(errorText: error)
    }
    
        @IBAction func loginButtonAction( _ sender : UIButton){
            let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
            let VC = mainStoryBoard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
            UIApplication.shared.windows.first?.rootViewController = UINavigationController(rootViewController: VC)
            UIApplication.shared.windows.first?.makeKeyAndVisible()
        }
        
    }
    extension  RegistrationVC: UITextFieldDelegate {
        func TxtFiedDelegate(){
            usernameTextfield.delegate = self
            passwordTextfield.delegate = self
            nameTextfield.delegate = self
            emailnameTextfield.delegate = self
            confirmPasswordTextfield.delegate = self
            dateofbithTextfield.delegate = self
            
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            if textField == nameTextfield {
                usernameTextfield.becomeFirstResponder()
            }else if textField == usernameTextfield {
                emailnameTextfield.becomeFirstResponder()
            } else if textField == emailnameTextfield {
                dateofbithTextfield.becomeFirstResponder()
                
            } else if textField == dateofbithTextfield {
                passwordTextfield.becomeFirstResponder()
            }
            else if textField == passwordTextfield {
                confirmPasswordTextfield.becomeFirstResponder()
            }else {
                confirmPasswordTextfield.resignFirstResponder()
            }
            return true
        }
    }
extension RegistrationVC : jsonDataDelegate {
    func didReceivedData(_ data: Any, jsonname: String) {
        print("Raw Data>>",data)
        print("Jsonname>>",jsonname)
        if data as? String ==  "NO INTERNET CONNECTION" {
            DispatchQueue.main.async { MBProgressHUD.hide(for: (self.view)!, animated: true) }
            showAlertMessageokkk(alertTitle: "NETWORK !", alertMsg: "CHECK YOUR INTERNET CONNECTION PLEASE.")
        } else {
            print(data as! NSDictionary)
            if ((data as! NSDictionary).object(forKey: "status") as! String) == "Yes" {
                
                 UserDefaults.standard.set((((data as! NSDictionary).object(forKey: "data") as! NSDictionary).value(forKey: "user_id") as! String), forKey: "UserId")
                
                UserDefaults.standard.set((((data as! NSDictionary).object(forKey: "data") as! NSDictionary).value(forKey: "name") as! String), forKey: "UserName")
                
                
                let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
                   let VC = mainStoryBoard.instantiateViewController(withIdentifier: "AgeVerifyVC") as! AgeVerifyVC
                   UIApplication.shared.windows.first?.rootViewController = UINavigationController(rootViewController: VC)
                   UIApplication.shared.windows.first?.makeKeyAndVisible()
    
                DispatchQueue.main.async { MBProgressHUD.hide(for: (self.view)!, animated: true) }
            } else {
                //Alert here..
                if ((data as! NSDictionary).object(forKey: "status") as! String) == "No" {
                    DispatchQueue.main.async { MBProgressHUD.hide(for: (self.view)!, animated: true) }
                    showAlertMessageokkk(alertTitle: "HEMPDAY !", alertMsg: ((data as! NSDictionary).object(forKey: "message") as! String))
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
