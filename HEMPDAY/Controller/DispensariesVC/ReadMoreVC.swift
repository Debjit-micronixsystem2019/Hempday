//
//  ReadMoreVC.swift
//  HEMPDAY
//
//  Created by admin on 1/19/21.
//  Copyright © 2021 Chandradip. All rights reserved.
//

import UIKit
import MBProgressHUD
import Toast_Swift


class ReadMoreVC: UIViewController {
    
    @IBOutlet weak var txtView : UITextView!
    @IBOutlet weak var likeBtn : UIButton!
    @IBOutlet weak var dislikeBtn : UIButton!
    
    @IBOutlet weak var likeDislikeView : UIView!{
        didSet{
            likeDislikeView.isHidden = true
        }
    }


    var html = String()
    var like = String()
    var dislike = String()
    var postID = String()
    var jsonFetch = jasonFetchClass()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtView.attributedText = html.htmlToAttributedString
        jsonFetch.jsondata = self
        fetchLikeDislikeData()
    }
    
    @IBAction func backButtonAction( _ sender : UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func likeButtonAction( _ sender : UIButton){
        fetchData(type : "like")
    }
    
    @IBAction func dislikeButtonAction( _ sender : UIButton){
        fetchData(type : "dislike")
    }
    
    func fetchData(type : String){
        let param = [
           "post_id": postID,
           "user_id":UserDefaults.standard.value(forKey: "UserId"),
           "type":type,
           "authorised_key": "SGVtcERheTIwMjAj"
            ]
        print("param",param)
        MBProgressHUD.showAdded(to: (self.view)!, animated: true)
        jsonFetch.fetchData(param, methodtype: "post", url: baseUrl + "/add_review", jsonname: "add_review")
    }
    
    func fetchLikeDislikeData(){
        let param = [
            "post_id": postID,
            "authorised_key": "SGVtcERheTIwMjAj"
            ]
        print("param",param)
        MBProgressHUD.showAdded(to: (self.view)!, animated: true)
        jsonFetch.fetchData(param, methodtype: "post", url: baseUrl + "/get_like_dislike_count", jsonname: "get_like_dislike_count")
    }
}
extension ReadMoreVC : jsonDataDelegate {
    func didReceivedData(_ data: Any, jsonname: String) {
        print("Raw Data>>",data)
        print("Jsonname>>",jsonname)
        if data as? String ==  "NO INTERNET CONNECTION" {
            DispatchQueue.main.async { MBProgressHUD.hide(for: (self.view)!, animated: true) }
            showAlertMessageokkk(alertTitle: "NETWORK !", alertMsg: "CHECK YOUR INTERNET CONNECTION PLEASE")
        } else {
            print(data as! NSDictionary)
            if ((data as! NSDictionary).object(forKey: "status") as! String) == "Yes" {
                
                if jsonname == "get_like_dislike_count"{
                    guard let like  = ((data as! NSDictionary).object(forKey: "like") as? String) else { return }
                    guard let dislike  = ((data as! NSDictionary).object(forKey: "dislike") as? String) else { return }
                    
                    likeBtn.setTitle(like, for: .normal)
                    dislikeBtn.setTitle(dislike, for: .normal)
                    likeDislikeView.isHidden = false
                    
                }else if jsonname == "add_review"{
                    fetchLikeDislikeData()
                }
       
    
                DispatchQueue.main.async { MBProgressHUD.hide(for: (self.view)!, animated: true) }
            } else {
                DispatchQueue.main.async { MBProgressHUD.hide(for: (self.view)!, animated: true) }

                if jsonname == "get_like_dislike_count"{
                    
                }else if jsonname == "add_review"{
                    guard let message  = ((data as! NSDictionary).object(forKey: "message") as? String) else { return }
                    self.view.makeToast(message, duration: 3.0, position: .bottom)

                }else{
                    showAlertMessageokkk(alertTitle: "HEMPDAY !", alertMsg: "TRY LATER.")
                }
                //you already liked this post
            }
        }
    }
    
    func didFailedReceivedData(_ error: Error) {
        print(error.localizedDescription)
        DispatchQueue.main.async { MBProgressHUD.hide(for: (self.view)!, animated: true) }
        showAlertMessageokkk(alertTitle: "HEMPDAY !", alertMsg: "PLEASE TRY AGAIN LATER.")
    }
}


extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}

