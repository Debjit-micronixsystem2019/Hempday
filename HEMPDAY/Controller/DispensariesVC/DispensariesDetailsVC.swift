//
//  DispensariesDetailsVC.swift
//  HEMPDAY
//
//  Created by admin on 2/9/21.
//  Copyright © 2021 Chandradip. All rights reserved.
//

import UIKit
import SDWebImage
import MBProgressHUD

class DispensariesDetailsVC: UIViewController {
    
    var postID = String()
    var mainPostTitle = String()
    
    @IBOutlet weak var TableVW : UITableView!
    @IBOutlet weak var searchBackgroundView : UIView!{
        didSet{
            searchBackgroundView.isHidden = true
        }
    }
    @IBOutlet weak var searchBarView : UIView!
    @IBOutlet weak var searchtext : UITextField!
    
    @IBOutlet weak var postTitle : UILabel!{
        didSet{
            postTitle.isHidden = true
        }
    }
    @IBOutlet weak var postTitleBackImg : UIImageView!{
        didSet{
            postTitleBackImg.isHidden = true
        }
    }

    
    var jsonFetch = jasonFetchClass()
    lazy var postListArray: [postData] = []
    lazy var NonFilterArray: [postData] = []
    var searching : Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
            TableVW.delegate = self
            TableVW.dataSource = self
            jsonFetch.jsondata = self
            hideKeyboardWhenTappedAround()
            searchtext.addTarget(self, action: #selector(DispensariesMapVC.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        fetcchPostdata(postid : postID)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
                
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func backButtonAction( _ sender : UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func searchButtonAction( _ sender : UIButton){
              hideKeyboardWhenTappedAround()
          }

    func hideKeyboardWhenTappedAround() {
           let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DispensariesVC.dismissKeyboard))
           tap.cancelsTouchesInView = false
           view.addGestureRecognizer(tap)
       }
    @objc func dismissKeyboard() {
           view.endEditing(true)
       }
    
    func fetcchPostdata(postid : String) {
        let param = [
           "authorised_key":"SGVtcERheTIwMjAj",
           "post_id":postid
            ]
        print("param",param)
        MBProgressHUD.showAdded(to: (self.view)!, animated: true)
        jsonFetch.fetchData(param, methodtype: "post", url: baseUrl + "/get_post", jsonname: "get_post")
    }

}

extension DispensariesDetailsVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching{
          return  NonFilterArray.count
            
        }else{
        return postListArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TableVW.dequeueReusableCell(withIdentifier: "DispensariesDetailsell", for: indexPath) as! DispensariesDetailsell
        
            if searching{
                cell.author_name.text = NonFilterArray[indexPath.row].author_name
                cell.date.text = NonFilterArray[indexPath.row].date
                cell.title.text = NonFilterArray[indexPath.row].title
                cell.author_image.sd_imageIndicator = SDWebImageActivityIndicator.gray
                cell.author_image.sd_setImage(with: URL(string: NonFilterArray[indexPath.row].author_image), placeholderImage: UIImage(named: " "))
            
            }else{
                cell.author_name.text = postListArray[indexPath.row].author_name
                cell.date.text = postListArray[indexPath.row].date
                cell.title.text = postListArray[indexPath.row].title
                cell.author_image.sd_imageIndicator = SDWebImageActivityIndicator.gray
                cell.author_image.sd_setImage(with: URL(string: postListArray[indexPath.row].author_image), placeholderImage: UIImage(named: " "))
            
        }
        
        return cell
    }
    
   func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        if searching{
            let vc = storyboard?.instantiateViewController(identifier: "ReadMoreVC") as! ReadMoreVC
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            let vc = storyboard?.instantiateViewController(identifier: "ReadMoreVC") as! ReadMoreVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 115
    }
}

extension DispensariesDetailsVC : UITextFieldDelegate{
    
    @objc func textFieldDidChange(textField : UITextField){
        if searchtext.text?.count == 0{
            searching = false
            TableVW.reloadData()
        }else{
        if postListArray.count != 0{
            NonFilterArray = postListArray.filter({$0.title.prefix(searchtext.text!.count) == searchtext.text!.uppercased()})
            //print("NonFilterArray",NonFilterArray)
            searching = true
            TableVW.reloadData()
        }
    }
}
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
      //  print("textFieldBegin",textField.text)
        searching = false
        TableVW.reloadData()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchtext.resignFirstResponder()
        return true
    }
}

extension DispensariesDetailsVC : jsonDataDelegate {
    func didReceivedData(_ data: Any, jsonname: String) {
        print("Raw Data>>",data)
        print("Jsonname>>",jsonname)
        if data as? String ==  "NO INTERNET CONNECTION" {
            DispatchQueue.main.async { MBProgressHUD.hide(for: (self.view)!, animated: true) }
            showAlertMessageokkk(alertTitle: "NETWORK !", alertMsg: "CHECK YOUR INTERNET CONNECTION PLEASE")
        } else {
            print(data as! NSDictionary)
            if ((data as! NSDictionary).object(forKey: "status") as! String) == "Yes" {
                self.postListArray.removeAll()
                    if let userData = (data as AnyObject).object(forKey: "data") as? NSArray{
                                            //  print(userData)
                            for eachData in userData {
                            guard let eachdataitem = eachData as? [String : Any] else {return}
                            guard let author_image = eachdataitem["author_image"] as? String else {return}
                            guard let author_name = eachdataitem["author_name"] as? String else {return}
                            guard let date = eachdataitem["date"] as? String else {return}
                            guard let post_id = eachdataitem["post_id"] as? String else {return}
                            guard let title = eachdataitem["title"] as? String else {return}
                            guard let details = eachdataitem["details"] as? String else {return}
                                self.postListArray.append(postData(author_image: author_image, author_name: author_name, date: date, post_id: post_id, title: title, details: details))
                            }
                            print("postListArray>>",postListArray)
                        }
                
                            TableVW.reloadData()
                            TableVW.isHidden = false
                            postTitle.isHidden = false
                            postTitleBackImg.isHidden = false
                            postTitle.text = mainPostTitle
                            searchBackgroundView.isHidden = false
                            DispatchQueue.main.async { MBProgressHUD.hide(for: (self.view)!, animated: true) }
            } else {
                //Alert here..
                if ((data as! NSDictionary).object(forKey: "status") as! String) == "No"{
                    postListArray.removeAll()
                    TableVW.reloadData()
                    DispatchQueue.main.async { MBProgressHUD.hide(for: (self.view)!, animated: true) }
                    showAlertMessageokkk(alertTitle: "HEMPDAY !", alertMsg: "POST DATA NOT AVAILABLE.")
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
