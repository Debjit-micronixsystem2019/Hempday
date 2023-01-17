//
//  ShawProductResultVC.swift
//  HEMPDAY
//
//  Created by admin on 12/28/20.
//  Copyright © 2020 Chandradip. All rights reserved.
//

import UIKit
import MBProgressHUD
import SDWebImage
import MapKit

class ShawProductResultVC: UIViewController {
    
    @IBOutlet weak var TableVW : UITableView!
    @IBOutlet weak var shawProductLBL : UILabel!

    var jsonFetch = jasonFetchClass()
    lazy var priceWiseListArray: [productData] = []
    var lowPrice = ""
    var highPrice = ""
    var destinationLocation = CLLocationCoordinate2D()

    override func viewDidLoad() {
        super.viewDidLoad()
      //  print("CurrentLocation",currentLocation.longitude)
        jsonFetch.jsondata = self
        TableVW.delegate = self
        TableVW.dataSource = self
        fetcchResultdata()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        }
           
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        }
    
    
    func fetcchResultdata() {
        let param = [
            
            "authorised_key":"SGVtcERheTIwMjAj",
            "answer_id": selectAnswer.selectAnswerOptionID,
            "question_id": selectAnswer.selectQuestionID,
            "user_id":UserDefaults.standard.value(forKey: "UserId"),
            "longitude": "\(currentLocation.longitude)",
            "latitude": "\(currentLocation.latitude)",
            "low_price":lowPrice,
            "high_price":highPrice
            ]
        print("param",param)
        MBProgressHUD.showAdded(to: (self.view)!, animated: true)
        jsonFetch.fetchData(param, methodtype: "post", url: baseUrl + "/result", jsonname: "result")
    }
    
    @IBAction func backtButtonAction( _ sender : UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func goHomeButtonAction( _ sender : UIButton){
        for controller in self.navigationController!.viewControllers as Array {
          if controller.isKind(of: HomeVC.self) {
            self.navigationController!.popToViewController(controller, animated: true)
            break
            }
        }
    }
}

extension ShawProductResultVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return priceWiseListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = TableVW.dequeueReusableCell(withIdentifier: "ShawProductell", for: indexPath) as! ShawProductell
        
        cell.productimgVW.sd_imageIndicator = SDWebImageActivityIndicator.gray
        cell.productimgVW.sd_setImage(with: URL(string: priceWiseListArray[indexPath.row].product_image), placeholderImage: UIImage(named: " "))
        
        cell.dispensaryNameLbl.text = priceWiseListArray[indexPath.row].dispensari_name
        cell.distanceLbl.text = priceWiseListArray[indexPath.row].distance
        cell.priceLbl.text = "$\(priceWiseListArray[indexPath.row].prise)"
        cell.urlButtan.setTitle(priceWiseListArray[indexPath.row].site_title, for: .normal)
        
        cell.urlButtan.addTarget(self, action: #selector(siteBtnActn), for: .touchUpInside)
        cell.urlButtan.tag = indexPath.row
        cell.pickUPBtn.addTarget(self, action: #selector(self.pressDirectionButton(_:)), for: .touchUpInside)
        cell.pickUPBtn.tag = indexPath.row
        cell.deliveryBtn.addTarget(self, action: #selector(self.pressDeliveryButton(_:)), for: .touchUpInside)
        cell.deliveryBtn.tag = indexPath.row

        return cell
    }

        
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)

    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
  
        return 220
    }
    
    @objc func pressDirectionButton(_ sender: UIButton){
        
        for (index,element) in priceWiseListArray.enumerated(){
            if index == sender.tag{
                destinationLocation.latitude = Double(element.latitude) ?? 0.0000000
                destinationLocation.longitude = Double(element.longitude) ?? 0.000000
                let source = MKMapItem(placemark: MKPlacemark(coordinate: currentLocation))
                source.name = "Your Current Location"
                let destination = MKMapItem(placemark: MKPlacemark(coordinate: destinationLocation))
                destination.name = element.dispensari_name
                MKMapItem.openMaps(with: [source, destination], launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
                
                break
            }
        }
        
        
       /* let vc = storyboard?.instantiateViewController(identifier: "PickUpMapVC") as! PickUpMapVC
        for (index,element) in priceWiseListArray.enumerated(){
            if index == sender.tag{
               vc.destinationLocation.latitude = Double(element.latitude) ?? 0.0000000
               vc.destinationLocation.longitude = Double(element.longitude) ?? 0.000000
                vc.destinationLocationTitle = element.dispensari_name
                vc.destinationLocationSubTitle = element.address
            }
        }
        self.navigationController?.pushViewController(vc, animated: true)*/
    }
    
    @objc func pressDeliveryButton(_ sender: UIButton){
        let vc = storyboard?.instantiateViewController(identifier: "HempDayVC") as! HempDayVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
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


extension ShawProductResultVC : jsonDataDelegate {
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
                    guard let product_name = eachdataitem["product_name"] as? String else {return}
                    guard let latitude = eachdataitem["latitude"] as? String else {return}
                    guard let longitude = eachdataitem["longitude"] as? String else {return}
                    
                    self.priceWiseListArray.append(productData(address: address, distance: distance, prise: prise, product_image: product_image, dispensari_name: dispensari_name, site_link: site_link, site_title: site_title, product_name: product_name, latitude: latitude, longitude: longitude))
                                                                                 
                          }
                          print("priceWiseListArray>>",priceWiseListArray)
                      }
                      TableVW.reloadData()
            shawProductLBL.text = (data as! NSDictionary).object(forKey: "product_name")  as? String
                
                UserDefaults.standard.setValue(false, forKey: "viewResult")
    
                DispatchQueue.main.async { MBProgressHUD.hide(for: (self.view)!, animated: true) }
            } else {
                DispatchQueue.main.async { MBProgressHUD.hide(for: (self.view)!, animated: true) }
                showAlertMessageokkk(alertTitle: "HEMPDAY !", alertMsg: "NO PRODUCT AVAILABLE.")
                
            }
        }
    }
    
    func didFailedReceivedData(_ error: Error) {
        print(error.localizedDescription)
        DispatchQueue.main.async { MBProgressHUD.hide(for: (self.view)!, animated: true) }
        showAlertMessageokkk(alertTitle: "HEMPDAY !", alertMsg: "PLEASE TRY AGAIN LATER.")
    }
}
