//
//  AgeVerifyVC.swift
//  HEMPDAY
//
//  Created by admin on 12/18/20.
//  Copyright © 2020 Chandradip. All rights reserved.
//

import UIKit
import MBProgressHUD
import SDWebImage
import Alamofire

class AgeVerifyVC: UIViewController {
    
    var jsonfetch = jasonFetchClass()
    private lazy var imagePicker = ImagePicker()
    
    @IBOutlet weak var uploadpassportimg : UIButton!
    @IBOutlet weak var uploadidentificationimg : UIButton!

    var identificationImageUpoadSucessMsg : String = ""
    var passportImageUpoadSucessMsg : String = ""
    var imageUploadIdentifyButton = String()

    var imageUploadSucess : Bool = false
    
    @IBOutlet weak var idVerifyLbl : UILabel!
    @IBOutlet weak var contentLbl : UILabel!
    @IBOutlet weak var identificationLbl : UILabel!
    @IBOutlet weak var identificationBackImg : UIImageView!
    
    @IBOutlet weak var submitButton : UIButton!{
        didSet{
            submitButton.isHidden = true
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        jsonfetch.jsondata = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
               self.navigationController?.isNavigationBarHidden = true
           }
           
           override func viewWillDisappear(_ animated: Bool) {
               self.navigationController?.isNavigationBarHidden = true
           }
    
    func idVerified(){
        let parms = [
            "authorised_key":"SGVtcERheTIwMjAj",
            "user_id":UserDefaults.standard.value(forKey: "UserId"),
            "identify_image":identificationImageUpoadSucessMsg,
            "passport_image":passportImageUpoadSucessMsg
            ]
        print(parms)
        MBProgressHUD.showAdded(to: (self.view)!, animated: true)
        jsonfetch.fetchData(parms, methodtype: "post", url: baseUrl + "/verified_image_update", jsonname: "verifyImage")
        
    }
    
    @IBAction func SubmitBtnAction( _ sender : UIButton){
    idVerified()
    }
    
    
    @IBAction func UploadPassportImgBtnAction( _ sender : UIButton){
        imageUploadIdentifyButton = "passport"
       showCameraAlert()
        
        }
    @IBAction func UploadIdentificationImgBtnAction( _ sender : UIButton){
           imageUploadIdentifyButton = "Identification"
          showCameraAlert()
           
    }
    
        func showCameraAlert() {
            let alert = UIAlertController(title: "", message: "Choose your option", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: {(action: UIAlertAction) in
                        self.imagePicker.cameraAsscessRequest()
                    }))
                    alert.addAction(UIAlertAction(title: "Photo Album", style: .default, handler: {(action: UIAlertAction) in
                        self.imagePicker.photoGalleryAsscessRequest()
                    }))
                    alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
            }
                    func callsendImageAPI(image: UIImage, imageKey: String, URlName: String, completion: @escaping (Bool) -> Void){
                        MBProgressHUD.showAdded(to: (self.view)!, animated: true)
                        
                        let headers: HTTPHeaders
                        headers = ["Content-type": "multipart/form-data",
                                   "Content-Disposition" : "form-data"]
                        
                        AF.upload(multipartFormData: { (multipartFormData) in
                            guard let imgData = image.jpegData(compressionQuality: 0.1) else { return }
                            multipartFormData.append(imgData, withName: imageKey, fileName: "file", mimeType: "image/jpeg")
                        },to: URlName, usingThreshold: UInt64.init(),
                          method: .post,
                          headers: headers).response{ response in
                            
                            switch response.result {
                            case .success(_):
                                print(response,"upload")
                                do {
                                 
                                 let dictionary = try JSONSerialization.jsonObject(with: response.data!, options: .fragmentsAllowed) as! NSDictionary
                                   
                                     print("Success!")
                                     print(dictionary)
                                    
                                    let status = dictionary.value(forKey: "Status")as! String
                                    if status=="OK"
                                    {
                                        print("IMAGE UPLOAD SUCCESSFULLY")
                                        if self.imageUploadIdentifyButton == "passport"{
                                           self.passportImageUpoadSucessMsg = dictionary.value(forKey: "Message")as! String
                                        }else{
                                            self.identificationImageUpoadSucessMsg = dictionary.value(forKey: "Message")as! String
                                        }
                                 
                                      DispatchQueue.main.async {
                                               MBProgressHUD.hide(for: (self.view)!, animated: true)
                                             }
                                        
                               //         if self.passportImageUpoadSucessMsg != "" && self.identificationImageUpoadSucessMsg != ""{
                                            self.submitButton.isHidden = false
                                            self.idVerifyLbl.text = "ID VERIFIED"
                                            self.contentLbl.isHidden = true
                                           // self.identificationLbl.isHidden = true
                                            //self.identificationBackImg.isHidden = true
                                      //  }
                                        
                                      self.showAlertMessageokkk(alertTitle: "HEMPDAY!", alertMsg: "YOUR IMAGE UPLOADED SUCCESSFULLY.")
                                     self.imageUploadSucess = true
                                    }
                                }
                                catch {
                                   // catch error.
                                 print("catch error")
                                  DispatchQueue.main.async {
                                           MBProgressHUD.hide(for: (self.view)!, animated: true)
                                         }
                                    if self.imageUploadIdentifyButton == "passport"{
                                      self.uploadpassportimg.setBackgroundImage(UIImage(named: "passPort"), for: .normal)
                                    }else{
                                    self.uploadidentificationimg.setBackgroundImage(UIImage(named: "Identification"), for: .normal)
                                    }
                                  self.showAlertMessageokkk(alertTitle: "HEMPDAY !", alertMsg: "IMAGE UPLOAD FAILED! TRY AGAIN")

                                       }
                
                            case .failure(let error):
                                print(error)
                              DispatchQueue.main.async {
                                       MBProgressHUD.hide(for: (self.view)!, animated: true)
                                     }
                                 if self.imageUploadIdentifyButton == "passport"{
                                    self.uploadpassportimg.setBackgroundImage(UIImage(named: "passPort"), for: .normal)
                                }else{
                                self.uploadidentificationimg.setBackgroundImage(UIImage(named: "Identification"), for: .normal)
                                }
                                self.showAlertMessageokkk(alertTitle: "NETWORK !", alertMsg: "CHECK YOUR INTERNET CONNECTION PLEASE")
                            
                            }
                        }
                    }
            private func presentImagePicker(sourceType: UIImagePickerController.SourceType) {
                imagePicker.present(parent: self, sourceType: sourceType)
                }
            @objc func photoButtonTapped(_ sender: UIButton) {
                imagePicker.photoGalleryAsscessRequest()
                }
            @objc func cameraButtonTapped(_ sender: UIButton) {
                imagePicker.cameraAsscessRequest()
            }

}

extension AgeVerifyVC: ImagePickerDelegate {
    func imagePickerDelegate(didSelect image: UIImage, delegatedForm: ImagePicker) {
        
        if self.imageUploadIdentifyButton == "passport"{
            uploadpassportimg.setBackgroundImage(image, for: .normal)
        }else{
            uploadidentificationimg.setBackgroundImage(image, for: .normal)
            }
        callsendImageAPI(image: image, imageKey: "file", URlName: imageUploadPath, completion: { [weak self] (success) in
            if success {
                self?.imagePicker.dismiss()
            }
        })
       
        imagePicker.dismiss()
        
    }
    
    func imagePickerDelegate(didCancel delegatedForm: ImagePicker) { imagePicker.dismiss()
        
    }
    
    func imagePickerDelegate(canUseGallery accessIsAllowed: Bool, delegatedForm: ImagePicker) {
        if accessIsAllowed { presentImagePicker(sourceType: .photoLibrary) }
    }
    
    func imagePickerDelegate(canUseCamera accessIsAllowed: Bool, delegatedForm: ImagePicker) {
        // works only on real device (crash on simulator)
        if accessIsAllowed { presentImagePicker(sourceType: .camera) }
    }
    
}


extension AgeVerifyVC : jsonDataDelegate {
    func didReceivedData(_ data: Any, jsonname: String) {
        print("Raw Data>>",data)
        print("Jsonname>>",jsonname)
        if data as? String ==  "NO INTERNET CONNECTION" {
            DispatchQueue.main.async { MBProgressHUD.hide(for: (self.view)!, animated: true) }
            showAlertMessageokkk(alertTitle: "NETWORK !", alertMsg: "CHECK YOUR INTERNET CONNECTION PLEASE")
        } else {
            print(data as! NSDictionary)
            if ((data as! NSDictionary).object(forKey: "status") as! String) == "Yes" {
                
               let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
                   let VC = mainStoryBoard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
                   UIApplication.shared.windows.first?.rootViewController = UINavigationController(rootViewController: VC)
                   UIApplication.shared.windows.first?.makeKeyAndVisible()
                
                 UserDefaults.standard.setValue("Yes", forKey: "isLogin")

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

