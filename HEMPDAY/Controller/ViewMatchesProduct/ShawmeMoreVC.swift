//
//  ShawmeMoreVC.swift
//  HEMPDAY
//
//  Created by admin on 1/13/21.
//  Copyright © 2021 Chandradip. All rights reserved.
//

import UIKit
import MBProgressHUD
import SDWebImage

class ShawmeMoreVC: UIViewController {

    @IBOutlet weak var TableVW : UITableView!

            
    var jsonFetch = jasonFetchClass()
    lazy var viewListArray: [viewMatchesData] = []
    var exam_id = String()

    override func viewDidLoad() {
        super.viewDidLoad()
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
                        "exam_id":exam_id
                     ]
                   print("param",param)
                   MBProgressHUD.showAdded(to: (self.view)!, animated: true)
                   jsonFetch.fetchData(param, methodtype: "post", url: baseUrl + "/view_all_matches", jsonname: "view_all_matches")
               }
        
        @IBAction func takeTheQuizButtonAction( _ sender : UIButton){
               let vc = storyboard?.instantiateViewController(identifier: "TakeQuizVC") as! TakeQuizVC
               self.navigationController?.pushViewController(vc, animated: true)
             }
        
        }

    extension ShawmeMoreVC : UITableViewDelegate,UITableViewDataSource{
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return viewListArray.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = TableVW.dequeueReusableCell(withIdentifier: "shawmeMoreCell", for: indexPath) as! shawmeMoreCell
            cell.productnameLbl.text = viewListArray[indexPath.row].product_name
            cell.productImg.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.productImg.sd_setImage(with: URL(string: viewListArray[indexPath.row].product_image), placeholderImage: UIImage(named: " "))
            
            if  viewListArray[indexPath.row].main_product == "main"{
                cell.productImgHeight.constant = 100
                cell.productImgWidth.constant = 100
                cell.productnameLbl.font = UIFont(name: cell.productnameLbl.font.fontName, size: 28)
            }else{
            cell.productImgHeight.constant = 80
            cell.productImgWidth.constant = 80
            cell.productnameLbl.font = UIFont(name: cell.productnameLbl.font.fontName, size: 24)
            }
            
            return cell
        }
        
        func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 0
        }
       /* func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 120
        }*/
    }

        extension ShawmeMoreVC : jsonDataDelegate {
            func didReceivedData(_ data: Any, jsonname: String) {
                print("Raw Data>>",data)
                print("Jsonname>>",jsonname)
                if data as? String ==  "NO INTERNET CONNECTION" {
                    DispatchQueue.main.async { MBProgressHUD.hide(for: (self.view)!, animated: true) }
                    showAlertMessageokkk(alertTitle: "NETWORK !", alertMsg: "CHECK YOUR INTERNET CONNECTION PLEASE")
                } else {
                    print(data as! NSDictionary)
                    if ((data as! NSDictionary).object(forKey: "status") as! String) == "Yes" {
                        
                        self.viewListArray.removeAll()
                                                                                   
                        if let userData = (data as AnyObject).object(forKey: "data") as? NSArray{
                        //  print(userData)
                                 
                            for eachData in userData {
                                                                                           
                                guard let eachdataitem = eachData as? [String : Any] else {return}
                                                     
                                guard let product_prise = eachdataitem["product_prise"] as? String else {return}
                                guard let product_image = eachdataitem["product_image"] as? String else {return}
                                guard let product_name = eachdataitem["product_name"] as? String else {return}
                                 guard let main_product = eachdataitem["main_product"] as? String else {return}
                                    
                                self.viewListArray.append(viewMatchesData(product_image: product_image, product_name: product_name, product_prise: product_prise, main_product: main_product))
                                                                                           
                                    }
                                    print("viewListArray>>",viewListArray)
                                }
                                TableVW.reloadData()
                     //    previosLbl.isHidden = false
                        DispatchQueue.main.async { MBProgressHUD.hide(for: (self.view)!, animated: true) }
                    } else {
                        //Alert here..
                        if ((data as! NSDictionary).object(forKey: "status") as! String) == "No"{
                            DispatchQueue.main.async { MBProgressHUD.hide(for: (self.view)!, animated: true) }
                       //      previosLbl.isHidden = true
                            showAlertMessageokkk(alertTitle: "HEMPDAY !", alertMsg: "VIEW MATCHES NOT FOUND.")
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


