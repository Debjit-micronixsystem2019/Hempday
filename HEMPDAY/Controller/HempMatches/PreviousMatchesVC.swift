//
//  PreviousMatchesVC.swift
//  HEMPDAY
//
//  Created by admin on 1/6/21.
//  Copyright © 2021 Chandradip. All rights reserved.
//

import UIKit
import MBProgressHUD
import SDWebImage

class PreviousMatchesVC: UIViewController {
    
    @IBOutlet weak var takeQuizBackView : UIView!{
        didSet{
            takeQuizBackView.isHidden = true
        }
    }
    
    @IBOutlet weak var takeQuizBackSecondView : UIView!{
        didSet{
            takeQuizBackSecondView.isHidden = true
        }
    }
    @IBOutlet weak var TableVW : UITableView!
    @IBOutlet weak var previosLbl : UILabel!{
        didSet{
            previosLbl.isHidden = true
        }
    }
       @IBOutlet weak var tableviewheight : NSLayoutConstraint!
        var jsonFetch = jasonFetchClass()
        lazy var productListArray: [productListData] = []

        override func viewDidLoad() {
            super.viewDidLoad()
           // takeQuizBackView.layer.borderWidth = 2.0
         //   takeQuizBackView.layer.borderColor = UIColor.darkGray.cgColor
            TableVW.delegate = self
            TableVW.dataSource = self
            jsonFetch.jsondata = self
            fetcchproductlistdata()
            
        }
        
       override func viewWillAppear(_ animated: Bool) {
            self.navigationController?.isNavigationBarHidden = true
        }
               
        override func viewWillDisappear(_ animated: Bool) {
                self.navigationController?.isNavigationBarHidden = true
            }
        @IBAction func backtButtonAction( _ sender : UIButton){
               self.navigationController?.popViewController(animated: true)
           }
        
        
        func fetcchproductlistdata() {
               let param = [
                    "authorised_key":"SGVtcERheTIwMjAj",
                    "user_id":UserDefaults.standard.value(forKey: "UserId")
                 ]
               print("param",param)
               MBProgressHUD.showAdded(to: (self.view)!, animated: true)
               jsonFetch.fetchData(param, methodtype: "post", url: baseUrl + "/product_list", jsonname: "product_list")
           }
    
    @IBAction func takeTheQuizButtonAction( _ sender : UIButton){
           let vc = storyboard?.instantiateViewController(identifier: "TakeQuizVC") as! TakeQuizVC
           self.navigationController?.pushViewController(vc, animated: true)
         }
    
    }

extension PreviousMatchesVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = TableVW.dequeueReusableCell(withIdentifier: "PreviousMatchesCell", for: indexPath) as! PreviousMatchesCell
        cell.productnameLbl.text = productListArray[indexPath.row].product_name
        cell.dateLbl.text = productListArray[indexPath.row].date
        cell.productImg.sd_imageIndicator = SDWebImageActivityIndicator.gray
      //  cell.productImg.sd_setImage(with: URL(string: "http://developer.marketingplatform.ca/hempday/public/product/cheeba_chews_indica.png"), placeholderImage: UIImage(named: ""))
      //  http://developer.marketingplatform.ca/hempday/public/product/cheeba_chews_indica.png
        cell.productImg.sd_setImage(with: URL(string: productListArray[indexPath.row].product_image), placeholderImage: UIImage(named: ""))
        
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
      {
          let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height:  tableView.bounds.size.height))
          headerView.backgroundColor = UIColor(named: "Color4")
        
        return headerView
      }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

    extension PreviousMatchesVC : jsonDataDelegate {
        func didReceivedData(_ data: Any, jsonname: String) {
            print("Raw Data>>",data)
            print("Jsonname>>",jsonname)
            if data as? String ==  "NO INTERNET CONNECTION" {
                DispatchQueue.main.async { MBProgressHUD.hide(for: (self.view)!, animated: true) }
                showAlertMessageokkk(alertTitle: "NETWORK !", alertMsg: "CHECK YOUR INTERNET CONNECTION PLEASE")
            } else {
                print(data as! NSDictionary)
                if ((data as! NSDictionary).object(forKey: "status") as! String) == "Yes" {
                    
                    self.productListArray.removeAll()
                                                                               
                    if let userData = (data as AnyObject).object(forKey: "data") as? NSArray{
                    //  print(userData)
                             
                        for eachData in userData {
                                                                                       
                            guard let eachdataitem = eachData as? [String : Any] else {return}
                                                 
                            guard let date = eachdataitem["date"] as? String else {return}
                            guard let product_image = eachdataitem["product_image"] as? String else {return}
                            guard let product_name = eachdataitem["product_name"] as? String else {return}
                                
                            self.productListArray.append(productListData(date: date, product_image: product_image, product_name: product_name))
                                                                                       
                                }
                                print("productListArray>>",productListArray)
                            }
                    TableVW.reloadData()
                    previosLbl.isHidden = false
                    TableVW.isHidden = false
                    takeQuizBackSecondView.isHidden = true
                    takeQuizBackView.isHidden = false
                    
                    if view.frame.size.height > 812{
                        if productListArray.count == 1{
                            tableviewheight.constant = 140
                        }else if productListArray.count == 2{
                            tableviewheight.constant = 240
                        }else if productListArray.count == 3{
                            tableviewheight.constant = 360
                        }else if productListArray.count == 4{
                            tableviewheight.constant = 480
                        }else {
                            tableviewheight.constant = 577
                        }
                    }else{
                        if productListArray.count == 1{
                            tableviewheight.constant = 140
                        }else if productListArray.count == 2{
                            tableviewheight.constant = 240
                        }else if productListArray.count == 3{
                             tableviewheight.constant = 360
                        }else {
                            tableviewheight.constant = 480
                            }
                    }/*else if productListArray.count == 5{
                        tableviewheight.constant = 600
                    }else if productListArray.count == 6{
                        tableviewheight.constant = 720
                    }else if productListArray.count == 7{
                        tableviewheight.constant = 840
                    }else if productListArray.count == 8{
                        tableviewheight.constant = 960
                    }else if productListArray.count == 9{
                        
                    }else if productListArray.count == 10{
                        
                    }*/
                    
                    DispatchQueue.main.async { MBProgressHUD.hide(for: (self.view)!, animated: true) }
                } else {
                    //Alert here..
                    if ((data as! NSDictionary).object(forKey: "status") as! String) == "No"{
                        DispatchQueue.main.async { MBProgressHUD.hide(for: (self.view)!, animated: true) }
                         previosLbl.isHidden = true
                        showAlertMessageokkk(alertTitle: "HEMPDAY !", alertMsg: "PREVIOUS MATCHES NOT FOUND.")
                        takeQuizBackSecondView.isHidden = false
                        takeQuizBackView.isHidden = true
                        TableVW.isHidden = true
                    }else{
                        DispatchQueue.main.async { MBProgressHUD.hide(for: (self.view)!, animated: true) }
                        showAlertMessageokkk(alertTitle: "HEMPDAY !", alertMsg: "PLEASE TRY AGAIN LATER.")
                         previosLbl.isHidden = true
                        takeQuizBackSecondView.isHidden = false
                        takeQuizBackView.isHidden = true
                        TableVW.isHidden = true

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

