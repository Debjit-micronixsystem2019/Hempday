//
//  DemoProductListVC.swift
//  HEMPDAY
//
//  Created by admin on 11/3/21.
//  Copyright © 2021 Chandradip. All rights reserved.
//

import UIKit
import MBProgressHUD
import SDWebImage

class DemoProductListVC: UIViewController {
    
    var jsonFetch = jasonDataDecodeFetchClass()
    var productListArray : [DemoProductListData]?
    
    @IBOutlet weak var tableVW : UITableView!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableVW.isHidden = true

        jsonFetch.jsondata = self
        tableVW.delegate = self
        tableVW.dataSource = self
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
    
    @IBAction func selectLocationButtonAction( _ sender : UIButton){
        let vc = storyboard?.instantiateViewController(identifier: "SelectLocationVC") as! SelectLocationVC
        vc.modalPresentationStyle = .overFullScreen
        vc.selectLocationID = { (id) in
            print("id: ",id)
            self.fetcchproductlistdataLocationWise(locationid : id)
        }

        self.present(vc, animated: true, completion: nil)
    }
    
    //4980 County Hwy 73, Evergreen, CO 80439, United States
    
    func fetcchproductlistdata() {
        let param = ["":""]
        let url = "https://developer.marketingplatform.ca/hempday-link/Backend/inventoryByAllLocations.php"
           MBProgressHUD.showAdded(to: (self.view)!, animated: true)
           jsonFetch.fetchData(param, methodtype: "post", url: url, jsonname: "")
       }
    
    func fetcchproductlistdataLocationWise(locationid : Int) {
        let param = ["location_id":locationid]
        let url = "https://developer.marketingplatform.ca/hempday-link/Backend/inventoryByLocationId.php"
           MBProgressHUD.showAdded(to: (self.view)!, animated: true)
           jsonFetch.fetchData(param, methodtype: "post", url: url, jsonname: "")
       }

}

extension DemoProductListVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productListArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DemoProductTableViewCell", for: indexPath) as! DemoProductTableViewCell
        
        cell.productName.text = "Product name: \(productListArray?[indexPath.row].productName ?? "")"
        cell.productBrandName.text = productListArray?[indexPath.row].brand ?? ""
        cell.productCategory.text = productListArray?[indexPath.row].category ?? ""
        cell.currencyCodeName.text = "\(productListArray?[indexPath.row].quantity ?? 0)"
        cell.locationName.text = productListArray?[indexPath.row].locationName ?? ""
        cell.productDescription.text = productListArray?[indexPath.row].productDescription ?? ""
    //    cell.productUpdateAT.text = productListArray?[indexPath.row].productUpdatedAt ?? ""
        cell.productMinorUnits.text = "\(productListArray?[indexPath.row].priceInMinorUnits ?? 0) USD"
        cell.productWeight.text = "\(productListArray?[indexPath.row].productWeight ?? 0.0)"
        cell.productType.text = productListArray?[indexPath.row].type ?? ""
      //  cell.productExperiationDate.text = productListArray?[indexPath.row].expirationDate ?? ""
        
        cell.productImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
        cell.productImage.sd_setImage(with: URL(string: productListArray?[indexPath.row].productPictureURL ?? ""), placeholderImage: UIImage(named: "noImage"))
        
        return cell
    }

        
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)

    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
  
        return UITableView.automaticDimension
    }
    
}

extension DemoProductListVC : jsonDecodeDataDelegate {
       func didRecivedDataFormat(_ data: Data, jsonname: String) {
           DispatchQueue.main.async { MBProgressHUD.hide(for: (self.view)!, animated: true) }
           do{
               let decoder = JSONDecoder()
               let jsonData = try decoder.decode(DemoDataResponseModel.self, from: data)
             //  print("jsonData",jsonData)
            if jsonData.data?.count ?? 0 > 0{
                self.productListArray = jsonData.data
                   tableVW.reloadData()
                tableVW.isHidden = false
               }

           }catch{
               print(error.localizedDescription)
           }
       }
       
       func didReceivedData(_ data: Any, jsonname: String) {
           print("Raw Data>>",data)
        //   print("Jsonname>>",jsonname)
           DispatchQueue.main.async { MBProgressHUD.hide(for: (self.view)!, animated: true) }
           if data as? String ==  "NO INTERNET CONNECTION" {
               showAlertMessageokkk(alertTitle: "NETWORK !", alertMsg: "CHECK YOUR INTERNET CONNECTION PLEASE")
           } else {
            
           }
       }
       
       func didFailedReceivedData(_ error: Error) {
           print(error.localizedDescription)
           DispatchQueue.main.async { MBProgressHUD.hide(for: (self.view)!, animated: true) }
           showAlertMessageokkk(alertTitle: "HEMPDAY !", alertMsg: "PLEASE TRY AGAIN LATER.")
       }
   }
