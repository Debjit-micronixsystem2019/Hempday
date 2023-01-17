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
    
    struct arryIndex {
        var item : Int
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
    
    lazy var NonFilterArray: [Post] = []
    var jsonFetch = jasonDataDecodeFetchClass()
    var postListArray : [Post]?
    
    
    var swifeArray = [Int:SwifeIdentification]()
    var categoryArray : [category] = []
    var searching : Bool = false
    var staticIndex  = 0
    var seleectloadArray  = [Int]()
    
    var desiginSetUp = "Strains"
    var subPostarray : [SubPost]?

    override func viewDidLoad() {
        super.viewDidLoad()
            TableVW.delegate = self
            TableVW.dataSource = self
            jsonFetch.jsondata = self
            searchtext.delegate = self
       //  desiginSetUp = "Connect"
            fetcchPostdata(catid : "1")
            swifeArray.updateValue(SwifeIdentification(name: "STRAINS"), forKey: 0)
            hideKeyboardWhenTappedAround()
            searchtext.addTarget(self, action: #selector(DispensariesMapVC.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
            swipeView()
            categoryDataAppend()
        TableVW.rowHeight = UITableView.automaticDimension
        
        TableVW.register(UINib(nibName: "ConnectCell", bundle: nil), forCellReuseIdentifier: "ConnectCell")

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
                            desiginSetUp = "Strains"
                             break;
                        }else if element.value.name == "LAWS"{
                            print("LAWS=>>>>>>>")
                            //Laws
                            fetcchPostdata(catid : "2")
                            desiginSetUp = "Law"
                             break;
                        }else if element.value.name == "CONNECT"{
                            print("CONNECT=>>>>>>>")
                            //Connect
                            fetcchPostdata(catid : "3")
                            desiginSetUp = "Connect"
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
                                    desiginSetUp = "Law"
                                     break;
                                }else if element.value.name == "LAWS"{
                                   print("LAWS=>>>>>>>")
                                    //Connect
                                   fetcchPostdata(catid : "3")
                                    desiginSetUp = "Connect"
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
        desiginSetUp = "Strains"
       }
    @IBAction func lawButtonAction( _ sender : UIButton){
             fetcchPostdata(catid : "2")
        //    swifeArray.updateValue(SwifeIdentification(name: "LAWS"), forKey: 1)
       // print(swifeArray)
        desiginSetUp = "Law"
         seleectloadArray.removeAll()

          }
    @IBAction func connectButtonAction( _ sender : UIButton){
             fetcchPostdata(catid : "3")
       //      swifeArray.updateValue(SwifeIdentification(name: "CONNECT"), forKey: 2)
     //   swifeArray.removeValue(forKey: 2)
        print(swifeArray)
        desiginSetUp = "Connect"

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
            return postListArray?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var loadCell = UITableViewCell()
        if desiginSetUp == "Connect"{
            let cell = TableVW.dequeueReusableCell(withIdentifier: "ConnectCell", for: indexPath) as! ConnectCell
            
            if searching{
                cell.authoreNameLbl.text = NonFilterArray[indexPath.row].author_name
                cell.postDateLbl.text = NonFilterArray[indexPath.row].date
                
               // cell.postIMG.sd_imageIndicator = SDWebImageActivityIndicator.gray
               // cell.postIMG.sd_setImage(with: URL(string: NonFilterArray[indexPath.row].author_image ?? ""), placeholderImage: UIImage(named: " "))
                cell.postOwnerNameLbl.text = NonFilterArray[indexPath.row].post_owner_name
            }else{
                cell.authoreNameLbl.text = postListArray?[indexPath.row].author_name
                cell.postDateLbl.text = postListArray?[indexPath.row].date
                
               // cell.postIMG.sd_imageIndicator = SDWebImageActivityIndicator.gray
               // cell.postIMG.sd_setImage(with: URL(string: postListArray?[indexPath.row].author_image ?? ""), placeholderImage: UIImage(named: " "))
                cell.postOwnerNameLbl.text = postListArray?[indexPath.row].post_owner_name
            }
            
            loadCell = cell
        }else{
            let cell = TableVW.dequeueReusableCell(withIdentifier: "DispensariesCell", for: indexPath) as! DispensariesCell
              let subPost = self.postListArray?[indexPath.row]
              cell.setUppost(choice: subPost?.subCategory ?? [])
              subPostarray =  subPost?.subCategory ?? []
              
                  if searching{
                      cell.title.text = NonFilterArray[indexPath.row].author_name
                  }else{
                      cell.title.text = postListArray?[indexPath.row].author_name
                  }
              
              if seleectloadArray.contains(indexPath.row){
                  cell.TableVW.isHidden = false
              }else{
                  cell.TableVW.isHidden = true
              }
              
              cell.didSelectTapAction = { (tapValue) in
                      //    print("Cell Index Tapped :" ,tapValue)
                  let vc = self.storyboard?.instantiateViewController(identifier: "ReadMoreVC") as! ReadMoreVC
                  vc.html = tapValue.content
            //      vc.like = tapValue.like
            //      vc.dislike = tapValue.dislike
                  vc.postID = tapValue.post_id
                  self.navigationController?.pushViewController(vc, animated: true)
              }
              
              if desiginSetUp == "Strains"{
                  cell.arrowIMG.isHidden = false
                  cell.readMoreLbl.isHidden = true
              }else if desiginSetUp == "Law"{
                  cell.arrowIMG.isHidden = true
                  cell.readMoreLbl.isHidden = true
              }
            loadCell = cell
        }
        return loadCell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
        {
      let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height:  tableView.bounds.size.height))
      headerView.backgroundColor = UIColor(named: "Color4")
    
            return headerView
        }
    
   func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
         if desiginSetUp == "Strains"{
            if seleectloadArray.contains(indexPath.row){
            seleectloadArray.remove(at: seleectloadArray.firstIndex(of: indexPath.row)!)
            }else{
            seleectloadArray.append(indexPath.row)
            }
            TableVW.reloadData()
        }else if desiginSetUp == "Law" || desiginSetUp == "Connect"{
           
            if searching{
                let vc = self.storyboard?.instantiateViewController(identifier: "ReadMoreVC") as! ReadMoreVC
                vc.html = NonFilterArray[indexPath.row].subCategory[indexPath.row].content
                vc.postID = NonFilterArray[indexPath.row].subCategory[indexPath.row].post_id
                self.navigationController?.pushViewController(vc, animated: true)
            }else{
                let vc = self.storyboard?.instantiateViewController(identifier: "ReadMoreVC") as! ReadMoreVC
                
                    let subPost = self.postListArray?[indexPath.row]
                    vc.html = subPost?.subCategory[0].content ?? ""
                    vc.postID = subPost?.subCategory[0].post_id ?? ""
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        /*var size = CGFloat()
        if view.frame.size.height > 812{
            size = 150.00
        }else{
            size = 130.00
        }*/
        return UITableView.automaticDimension
    }
   
}

extension DispensariesVC : UITextFieldDelegate{
    
    @objc func textFieldDidChange(textField : UITextField){
        if searchtext.text?.count == 0{
            searching = false
            TableVW.reloadData()
        }else{
            if postListArray?.count != 0{
                NonFilterArray = postListArray?.filter({$0.author_name.prefix(searchtext.text!.count) == searchtext.text!.uppercased()}) as! [Post]
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

extension DispensariesVC : jsonDecodeDataDelegate {
    func didRecivedDataFormat(_ data: Data, jsonname: String) {
        print(data)
        DispatchQueue.main.async { MBProgressHUD.hide(for: (self.view)!, animated: true) }
        do{
            let decoder = JSONDecoder()
            let jsonData = try decoder.decode(MainPost.self, from: data)
            print(jsonData.message)
            self.postListArray = jsonData.data
            if jsonData.data.count > 0{
                TableVW.reloadData()
                TableVW.isHidden = false
                searchBackgroundView.isHidden = false
                stackVW.isHidden = false
                
                print("postListArray",self.postListArray)
            }
                

        }catch{
            print(error.localizedDescription)
            postListArray?.removeAll()
            TableVW.reloadData()
            showAlertMessageokkk(alertTitle: "HEMPDAY !", alertMsg: "POST DATA IS NOT AVAILABLE.")
        }
    }
    
    func didReceivedData(_ data: Any, jsonname: String) {
     //   print("Raw Data>>",data)
    //    print("Jsonname>>",jsonname)
        DispatchQueue.main.async { MBProgressHUD.hide(for: (self.view)!, animated: true) }
        if data as? String ==  "NO INTERNET CONNECTION" {
            showAlertMessageokkk(alertTitle: "NETWORK !", alertMsg: "CHECK YOUR INTERNET CONNECTION PLEASE")
        } else {
            print(data as! NSDictionary)
            
            /* if ((data as! NSDictionary).object(forKey: "status") as! String) == "Yes" {
                
                QuestionData.Question.QuizQuestionArray.removeAll()
                if let userData = (data as AnyObject).object(forKey: "data") as? NSArray{
                       
                    for (Aindex,eachData) in userData.enumerated() {
                        guard let eachdataitem = eachData as? [String : Any] else {return}
                        
                        
                        guard let choice = eachdataitem["choice"] as? [choices] else {return}
                        guard let option_count = eachdataitem["option_count"] as? Int else {return}
                        guard let question = eachdataitem["question"] as? String else {return}
                        guard let question_id = eachdataitem["question_id"] as? String else {return}
                        
                        QuestionData.Question.QuizQuestionArray.append(Quizquestion(choice: choice, option_count: option_count, question: question, question_id: question_id))
                        
                    }
                    print("QuizQuestionArray>>", QuestionData.Question.QuizQuestionArray)
                    collectionVW.isHidden = false
                    cView.isHidden = false
                    totalQuestionlbl.text = String(QuestionData.Question.QuizQuestionArray.count)
                    collectionVW.reloadData()
                         }
                
                
            } else {
             if ((data as! NSDictionary).object(forKey: "status") as! String) == "No" {
             showAlertMessageokkk(alertTitle: "HEMPDAY !", alertMsg: "")
             }else{
                //Alert here..
                showAlertMessageokkk(alertTitle: "HEMPDAY !", alertMsg: "SOMETHING GOING WRONG,TRY LATTER")
                }
            }*/
        }
    }
    
    func didFailedReceivedData(_ error: Error) {
        print(error.localizedDescription)
        DispatchQueue.main.async { MBProgressHUD.hide(for: (self.view)!, animated: true) }
        showAlertMessageokkk(alertTitle: "HEMPDAY !", alertMsg: "PLEASE TRY AGAIN LATER.")
    }
}

