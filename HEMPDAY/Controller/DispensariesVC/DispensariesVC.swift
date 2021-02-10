//
//  DispensariesVC.swift
//  HEMPDAY
//
//  Created by admin on 12/23/20.
//  Copyright © 2020 Chandradip. All rights reserved.
//

import UIKit
import SDWebImage
import MBProgressHUD

class DispensariesVC: UIViewController {
    
    struct SwifeIdentification {
        var name : String
    }
    struct category {
        var name : String
    }
    
    @IBOutlet weak var TableVW : UITableView!
    @IBOutlet weak var searchBackgroundView : UIView!{
        didSet{
            searchBackgroundView.isHidden = true
        }
    }
    @IBOutlet weak var stackVW : UIStackView!{
        didSet{
            stackVW.isHidden = true
        }
    }
    @IBOutlet weak var searchBarView : UIView!
    @IBOutlet weak var searchtext : UITextField!
    @IBOutlet weak var strainImgVW : UIImageView!
    @IBOutlet weak var strainLbl : UILabel!
    @IBOutlet weak var lawsImgVW : UIImageView!
    @IBOutlet weak var lawsLbl : UILabel!
    @IBOutlet weak var connectImgVW : UIImageView!
    @IBOutlet weak var connectLbl : UILabel!
    @IBOutlet weak var reviewImgVW : UIImageView!
    @IBOutlet weak var reviewLbl : UILabel!
    
    var jsonFetch = jasonFetchClass()
    lazy var postListArray: [MainpostData] = []
    lazy var NonFilterArray: [MainpostData] = []
    var swifeArray = [Int:SwifeIdentification]()
    var categoryArray : [category] = []
    var searching : Bool = false
    var staticIndex  = 0

    override func viewDidLoad() {
        super.viewDidLoad()
            TableVW.delegate = self
            TableVW.dataSource = self
            jsonFetch.jsondata = self
            searchtext.delegate = self
            fetcchPostdata(catid : "1")
            swifeArray.updateValue(SwifeIdentification(name: "STRAINS"), forKey: 0)
            hideKeyboardWhenTappedAround()
            searchtext.addTarget(self, action: #selector(DispensariesMapVC.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
            swipeView()
            categoryDataAppend()
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
    
    func categoryDataAppend(){
        categoryArray.append(category(name: "STRAINS"))
        categoryArray.append(category(name: "LAWS"))
        categoryArray.append(category(name: "CONNECT"))
        categoryArray.append(category(name: "REVIEWS"))
    }
    
    func swipeView(){
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeLeft.direction = .left
        self.view!.addGestureRecognizer(swipeLeft)

        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeRight.direction = .right
        self.view!.addGestureRecognizer(swipeRight)
    }
    
        @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
            if gesture.direction == UISwipeGestureRecognizer.Direction.right {
                print("Swipe Right")
                
                
                for (index,element) in swifeArray.enumerated(){
                    if  element.key == staticIndex - 1{
                        print("ItemName",element.value.name)
                        if element.value.name == "STRAINS"{
                           print("STRAINS=>>>>>>>")
                            //Strain
                            fetcchPostdata(catid : "1")
                             break;
                        }else if element.value.name == "LAWS"{
                            print("LAWS=>>>>>>>")
                            //Laws
                            fetcchPostdata(catid : "2")
                             break;
                        }else if element.value.name == "CONNECT"{
                            print("CONNECT=>>>>>>>")
                            //Connect
                            fetcchPostdata(catid : "3")
                             break;
                        }else if element.value.name == "REVIEWS"{
                           print("REVIEWS=>>>>>>>")
                             break;
                        }
                    }
                }
                
                if staticIndex != 0{
                    staticIndex = staticIndex-1
                    swifeArray.removeValue(forKey: staticIndex)
                    
                    print(staticIndex,"staticIndex")
                    print(swifeArray,"swifeArray")
                }
                
            }
            else if gesture.direction == UISwipeGestureRecognizer.Direction.left {
                print("Swipe Left")
              
                for (index,element) in categoryArray.enumerated(){
                    if index == staticIndex{
                        swifeArray.updateValue(SwifeIdentification(name: element.name), forKey: staticIndex )
                        if staticIndex < categoryArray.count{
                        staticIndex = staticIndex+1
                        }
                        print(staticIndex,"staticIndex")
                        print(swifeArray,"swifeArray")
                        break;
                    }
                }
                
                for (index,element) in swifeArray.enumerated(){
                            if  element.key == staticIndex - 1{
                                print("ItemName",element.value.name)
                                if element.value.name == "STRAINS"{
                                    print("STRAINS=>>>>>>>")
                                    //Laws
                                    fetcchPostdata(catid : "2")
                                     break;
                                }else if element.value.name == "LAWS"{
                                   print("LAWS=>>>>>>>")
                                    //Connect
                                   fetcchPostdata(catid : "3")
                                     break;
                                }else if element.value.name == "CONNECT"{
                                    print("CONNECT=>>>>>>>")
                                    //Reviews
                                    fetcchPostdata(catid : "4")
                                     break;
                                }else if element.value.name == "REVIEWS"{
                                     print("REVIEWS=>>>>>>>")
                                     break;
                                }
                            }
                        }
                    }
                }
    
    func hideKeyboardWhenTappedAround() {
           let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DispensariesVC.dismissKeyboard))
           tap.cancelsTouchesInView = false
           view.addGestureRecognizer(tap)
       }
       
    @objc func dismissKeyboard() {
           view.endEditing(true)
       }
    func fetcchPostdata(catid : String) {
        let param = [
           "authorised_key":"SGVtcERheTIwMjAj",
           "cat_id":catid
            ]
        print("param",param)
        MBProgressHUD.showAdded(to: (self.view)!, animated: true)
        jsonFetch.fetchData(param, methodtype: "post", url: baseUrl + "/get_main_post", jsonname: "get_main_post")
    }
    
    @IBAction func starinButtonAction( _ sender : UIButton){
          fetcchPostdata(catid : "1")
      //    swifeArray.updateValue(SwifeIdentification(name: "STRAINS"), forKey: 0)
     //   print(swifeArray)
       }
    @IBAction func lawButtonAction( _ sender : UIButton){
             fetcchPostdata(catid : "2")
        //    swifeArray.updateValue(SwifeIdentification(name: "LAWS"), forKey: 1)
       // print(swifeArray)


          }
    @IBAction func connectButtonAction( _ sender : UIButton){
             fetcchPostdata(catid : "3")
       //      swifeArray.updateValue(SwifeIdentification(name: "CONNECT"), forKey: 2)
     //   swifeArray.removeValue(forKey: 2)
        print(swifeArray)

          }
    @IBAction func reviewsButtonAction( _ sender : UIButton){
             fetcchPostdata(catid : "4")
      //  swifeArray.updateValue(SwifeIdentification(name: "REVIEWS"), forKey: 3)
    //    print(swifeArray)

          }
    @IBAction func searchButtonAction( _ sender : UIButton){
            hideKeyboardWhenTappedAround()
        }
    }

extension DispensariesVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching{
          return  NonFilterArray.count
            
        }else{
        return postListArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TableVW.dequeueReusableCell(withIdentifier: "DispensariesCell", for: indexPath) as! DispensariesCell
        
            if searching{
                cell.title.text = NonFilterArray[indexPath.row].author_name
            }else{
                cell.title.text = postListArray[indexPath.row].author_name
        }
        return cell
    }
    
   func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        if searching{
            let vc = storyboard?.instantiateViewController(identifier: "DispensariesDetailsVC") as! DispensariesDetailsVC
            vc.mainPostTitle = NonFilterArray[indexPath.row].author_name
            vc.postID = NonFilterArray[indexPath.row].post_id
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            let vc = storyboard?.instantiateViewController(identifier: "DispensariesDetailsVC") as! DispensariesDetailsVC
            vc.mainPostTitle = postListArray[indexPath.row].author_name
            vc.postID = postListArray[indexPath.row].post_id
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var size = CGFloat()
        if view.frame.size.height > 812{
            size = 150.00
        }else{
            size = 130.00
        }
        return size
    }
}

extension DispensariesVC : UITextFieldDelegate{
    
    @objc func textFieldDidChange(textField : UITextField){
        if searchtext.text?.count == 0{
            searching = false
            TableVW.reloadData()
        }else{
        if postListArray.count != 0{
            NonFilterArray = postListArray.filter({$0.author_name.prefix(searchtext.text!.count) == searchtext.text!.uppercased()})
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

extension DispensariesVC : jsonDataDelegate {
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
                            guard let author_name = eachdataitem["author_name"] as? String else {return}
                            guard let post_id = eachdataitem["post_id"] as? String else {return}
                                self.postListArray.append(MainpostData(author_name: author_name, post_id: post_id))
                            }
                            print("postListArray>>",postListArray)
                        }
                
                            TableVW.reloadData()
                            TableVW.isHidden = false
                            searchBackgroundView.isHidden = false
                            stackVW.isHidden = false
                            DispatchQueue.main.async { MBProgressHUD.hide(for: (self.view)!, animated: true) }
            } else {
                //Alert here..
                if ((data as! NSDictionary).object(forKey: "status") as! String) == "No"{
                    postListArray.removeAll()
                    TableVW.reloadData()
                    DispatchQueue.main.async { MBProgressHUD.hide(for: (self.view)!, animated: true) }
                    showAlertMessageokkk(alertTitle: "HEMPDAY !", alertMsg: "POST DATA NOT AVAILABLE")
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
