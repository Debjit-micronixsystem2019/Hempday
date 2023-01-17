//
//  SelectLocationVC.swift
//  HEMPDAY
//
//  Created by admin on 11/3/21.
//  Copyright © 2021 Chandradip. All rights reserved.
//

import UIKit
import MBProgressHUD

class SelectLocationVC: UIViewController {

    var jsonFetch = jasonDataDecodeFetchClass()
    var locationListArray : [SelectLocationData]?
    
    var selectLocationID : ((Int)->())!
    
    @IBOutlet weak var tableVW : UITableView!
    @IBOutlet weak var backView : UIView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableVW.isHidden = true
        backView.layer.cornerRadius = 15
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
    
    func fetcchproductlistdata() {
        let param = ["":""]
        let url = "https://developer.marketingplatform.ca/hempday-link/Backend/clientLocations.php"
        MBProgressHUD.showAdded(to: (self.view)!, animated: true)
        jsonFetch.fetchData(param, methodtype: "post", url: url, jsonname: "")
    }
    
}

extension SelectLocationVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  locationListArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectLocationTableViewCell", for: indexPath) as! SelectLocationTableViewCell
        
        cell.locationname.text = "\(locationListArray?[indexPath.row].address?.streetAddress1 ?? "") \(locationListArray?[indexPath.row].address?.city ?? ""), \(locationListArray?[indexPath.row].address?.state ?? "") \(locationListArray?[indexPath.row].address?.zip ?? ""), \(locationListArray?[indexPath.row].address?.country ?? "")"

        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        selectLocationID?(locationListArray?[indexPath.row].locationID ?? 0)
        self.dismiss(animated: true, completion: nil)
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
    
}

extension SelectLocationVC : jsonDecodeDataDelegate {
    func didRecivedDataFormat(_ data: Data, jsonname: String) {
        DispatchQueue.main.async { MBProgressHUD.hide(for: (self.view)!, animated: true) }
        do{
            let decoder = JSONDecoder()
            let jsonData = try decoder.decode(LocationResponse.self, from: data)
              print("jsonData",jsonData)
            if jsonData.data?.count ?? 0 > 0{
                self.locationListArray = jsonData.data
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
