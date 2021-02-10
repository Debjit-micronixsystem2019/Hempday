//
//  ViewPriceVC.swift
//  HEMPDAY
//
//  Created by admin on 1/14/21.
//  Copyright © 2021 Chandradip. All rights reserved.
//

import UIKit
import MBProgressHUD
import SDWebImage
import CoreLocation

class ViewPriceVC: UIViewController,CLLocationManagerDelegate {

        @IBOutlet weak var TableVW : UITableView!
                
                var jsonFetch = jasonFetchClass()
                lazy var priceWiseListArray: [priceMatchesData] = []
                var exam_id = String()
                var locationManager: CLLocationManager!
                var currentLocation = CLLocationCoordinate2D()
                var deafaultlocation = CLLocationCoordinate2D (latitude: 35.114648, longitude: -115.172813)

                override func viewDidLoad() {
                    super.viewDidLoad()
                    
                    if (CLLocationManager.locationServicesEnabled())
                    {
                        locationManager = CLLocationManager()
                        locationManager.delegate = self
                        locationManager.desiredAccuracy = kCLLocationAccuracyBest
                        locationManager.requestAlwaysAuthorization()
                        locationManager.startUpdatingLocation()
                        currentLocation = locationManager.location?.coordinate ?? deafaultlocation
                    }
                    
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
    
                func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
                    let location = locations.last! as CLLocation
                     currentLocation = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
                        print("CurrentLocation",currentLocation)
                    }
    
                @IBAction func backtButtonAction( _ sender : UIButton){
                       self.navigationController?.popViewController(animated: true)
                   }
                
                
                func fetcchproductlistdata() {
                       let param = [
                        "authorised_key":"SGVtcERheTIwMjAj",
                        "exam_id":exam_id,
                        "latitude":String(currentLocation.latitude),
                        "longitude":String(currentLocation.longitude)
                         ]
                       print("param",param)
                       MBProgressHUD.showAdded(to: (self.view)!, animated: true)
                       jsonFetch.fetchData(param, methodtype: "post", url: baseUrl + "/compare_prices", jsonname: "compare_prices")
                   }
            
               @IBAction func takeTheQuizButtonAction( _ sender : UIButton){
                   let vc = storyboard?.instantiateViewController(identifier: "TakeQuizVC") as! TakeQuizVC
                   self.navigationController?.pushViewController(vc, animated: true)
                 }
            }

        extension ViewPriceVC : UITableViewDelegate,UITableViewDataSource{
            func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                return priceWiseListArray.count
            }
            
            func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
                let cell = TableVW.dequeueReusableCell(withIdentifier: "ComparePriceCell", for: indexPath) as! ComparePriceCell
                cell.productnameLbl.text = priceWiseListArray[indexPath.row].dispensari_name
                cell.addressLbl.text = priceWiseListArray[indexPath.row].address
                cell.priceLbl.text = "$ \(priceWiseListArray[indexPath.row].prise)"
                cell.siteBtn.setTitle(priceWiseListArray[indexPath.row].site_title, for: .normal)
                cell.distanceLbl.text = "\(priceWiseListArray[indexPath.row].distance)"

                cell.productImg.sd_imageIndicator = SDWebImageActivityIndicator.gray
                cell.productImg.sd_setImage(with: URL(string: priceWiseListArray[indexPath.row].product_image), placeholderImage: UIImage(named: " "))
                
                cell.siteBtn.addTarget(self, action: #selector(siteBtnActn), for: .touchUpInside)
                cell.siteBtn.tag = indexPath.row
                
                return cell
            }
            
            func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
                return 0
            }
        /*    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
                return 220
                
            }*/
    //        guard let url = URL(string: "https://stackoverflow.com") else { return }
     //       UIApplication.shared.open(url)
            
             @objc func siteBtnActn(sender: UIButton){
                for (index,element) in priceWiseListArray.enumerated(){
                    if index == sender.tag{
                        guard let url = URL(string: element.site_link) else { return }
                        UIApplication.shared.open(url)
                        
                        print("button position",index,sender.tag)
                    }
                }
            }
        }

        extension ViewPriceVC : jsonDataDelegate {
                func didReceivedData(_ data: Any, jsonname: String) {
                    print("Raw Data>>",data)
                    print("Jsonname>>",jsonname)
                    if data as? String ==  "NO INTERNET CONNECTION" {
                        DispatchQueue.main.async { MBProgressHUD.hide(for: (self.view)!, animated: true) }
                        showAlertMessageokkk(alertTitle: "NETWORK !", alertMsg: "CHECK YOUR INTERNET CONNECTION PLEASE")
                    } else {
                        print(data as! NSDictionary)
                        if ((data as! NSDictionary).object(forKey: "status") as! String) == "Yes" {
                            
                            self.priceWiseListArray.removeAll()
                                                                                       
                            if let userData = (data as AnyObject).object(forKey: "data") as? NSArray{
                            //  print(userData)
                                     
                                for eachData in userData {
                                                                                               
                                    guard let eachdataitem = eachData as? [String : Any] else {return}
                                                         
                                    guard let address = eachdataitem["address"] as? String else {return}
                                    guard let distance = eachdataitem["distance"] as? String else {return}
                                    guard let prise = eachdataitem["prise"] as? String else {return}
                                    guard let product_image = eachdataitem["product_image"] as? String else {return}
                                    guard let dispensari_name = eachdataitem["dispensari_name"] as? String else {return}
                                    guard let site_link = eachdataitem["site_link"] as? String else {return}
                                    guard let site_title = eachdataitem["site_title"] as? String else {return}

                                        
                                    self.priceWiseListArray.append(priceMatchesData(address: address, distance: distance, prise: prise, product_image: product_image, dispensari_name: dispensari_name, site_link: site_link, site_title: site_title))
                                                                                               
                                        }
                                        print("priceWiseListArray>>",priceWiseListArray)
                                    }
                                    TableVW.reloadData()
                         //    previosLbl.isHidden = false*/
                            DispatchQueue.main.async { MBProgressHUD.hide(for: (self.view)!, animated: true) }
                        } else {
                            //Alert here..
                            if ((data as! NSDictionary).object(forKey: "status") as! String) == "No"{
                                DispatchQueue.main.async { MBProgressHUD.hide(for: (self.view)!, animated: true) }
                        //         previosLbl.isHidden = true
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


