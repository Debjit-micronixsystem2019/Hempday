//
//  LoginVC.swift
//  HEMPDAY
//
//  Created by admin on 12/11/20.
//  Copyright © 2020 Chandradip. All rights reserved.
//

import UIKit
import ACFloatingTextfield_Swift
import MBProgressHUD

class LoginVC: UIViewController {
    
    @IBOutlet weak var usernameTextfield : ACFloatingTextfield!
    @IBOutlet weak var passwordTextfield : ACFloatingTextfield!
    let aTextField = ACFloatingTextfield()
    
    var navigation = CustomNavigationVC()
    var jsonFetch = jasonFetchClass()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        jsonFetch.jsondata = self
     //   navigation = self.storyboard?.instantiateViewController(withIdentifier: "CustomNavigationVC") as! CustomNavigationVC
  //      navigation.view.frame = (CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 90))
   //     self.navigationController?.view.addSubview(navigation.view)
  //      navigation.menuButton.isHidden = true
        
        setupUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        if UserDefaults.standard.value(forKey: "ageAlert") as? String != "Yes" {
            ageAlertPopUp()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        
    }
    
    func setupUI() {
        TxtFiedDelegate()
        aTextField.delegate = self
        passwordTextfield.placeholder = "PASSWORD"
        passwordTextfield.placeHolderColor = UIColor(named: "Color4")!
        passwordTextfield.selectedPlaceHolderColor = UIColor(named: "Color4")!
        usernameTextfield.placeholder = "USERNAME"
        usernameTextfield.placeHolderColor = UIColor(named: "Color4")!
        usernameTextfield.selectedPlaceHolderColor = UIColor(named: "Color4")!
        hideKeyboardWhenTappedAround()
    }
    
    func ageAlertPopUp(){
        let vc = storyboard?.instantiateViewController(identifier: "AgeAlertViewController") as! AgeAlertViewController
         vc.modalPresentationStyle = .overFullScreen
         self.present(vc, animated: true, completion: nil)
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginVC.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func fetcchLogIndata() {
        let param = [
            "authorised_key":"SGVtcERheTIwMjAj",
            "user_name":usernameTextfield.text!,
            "password":passwordTextfield.text!
        ]
        print("param",param)
        MBProgressHUD.showAdded(to: (self.view)!, animated: true)
        jsonFetch.fetchData(param, methodtype: "post", url: baseUrl + "/login", jsonname: "login")
    }
    
    
    
    @IBAction func signupButtonAction( _ sender : UIButton){
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let VC = mainStoryBoard.instantiateViewController(withIdentifier: "RegistrationVC") as! RegistrationVC
        UIApplication.shared.windows.first?.rootViewController = UINavigationController(rootViewController: VC)
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
    @IBAction func loginButtonAction( _ sender : UIButton){
       
    if (usernameTextfield.text!.trimmingCharacters(in: .whitespaces).isEmpty){
              shawErrorMSG(txtField : usernameTextfield, error : "*CAN'T BE BLANK")
      }else if (passwordTextfield.text!.trimmingCharacters(in: .whitespaces).isEmpty){
          shawErrorMSG(txtField : passwordTextfield, error : "*CAN'T BE BLANK")
     }else{
        fetcchLogIndata()
        }
    }
    
    @IBAction func guestButtonAction( _ sender : UIButton){
            let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
            let VC = mainStoryBoard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
            UIApplication.shared.windows.first?.rootViewController = UINavigationController(rootViewController: VC)
            UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
    func shawErrorMSG(txtField : ACFloatingTextfield, error : String) {
        txtField.errorTextColor =  UIColor(named: "Color4")!
         txtField.errorLineColor = UIColor.clear
         txtField.showErrorWithText(errorText: error)
     }

    
}
extension  LoginVC: UITextFieldDelegate {
    func TxtFiedDelegate(){
        usernameTextfield.delegate = self
        passwordTextfield.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameTextfield {
            
            passwordTextfield.becomeFirstResponder()
        } else {
            passwordTextfield.resignFirstResponder()
        }
        return true
    }
}

extension LoginVC : jsonDataDelegate {
    func didReceivedData(_ data: Any, jsonname: String) {
        print("Raw Data>>",data)
        print("Jsonname>>",jsonname)
        if data as? String ==  "NO INTERNET CONNECTION" {
            DispatchQueue.main.async { MBProgressHUD.hide(for: (self.view)!, animated: true) }
            showAlertMessageokkk(alertTitle: "NETWORK !", alertMsg: "CHECK YOUR INTERNET CONNECTION PLEASE")
        } else {
            print(data as! NSDictionary)
            if ((data as! NSDictionary).object(forKey: "status") as! String) == "Yes" {
                
                UserDefaults.standard.set((((data as! NSDictionary).object(forKey: "data") as! NSDictionary).value(forKey: "user_id") as! String), forKey: "UserId")
                
                UserDefaults.standard.set((((data as! NSDictionary).object(forKey: "data") as! NSDictionary).value(forKey: "name") as! String), forKey: "UserName")
                
                 UserDefaults.standard.setValue("Yes", forKey: "isLogin")
                
               let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
                   let VC = mainStoryBoard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
                   UIApplication.shared.windows.first?.rootViewController = UINavigationController(rootViewController: VC)
                   UIApplication.shared.windows.first?.makeKeyAndVisible()
                

                DispatchQueue.main.async { MBProgressHUD.hide(for: (self.view)!, animated: true) }
            } else {
                if ((data as! NSDictionary).object(forKey: "status") as! String) == "No" {
                    DispatchQueue.main.async { MBProgressHUD.hide(for: (self.view)!, animated: true) }
                    showAlertMessageokkk(alertTitle: "HEMPDAY !", alertMsg: "PASSWORD OR USER NAME IS WRONG")
                }else{
                //Alert here..
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

