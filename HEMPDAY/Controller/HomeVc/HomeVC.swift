//
//  HomeVC.swift
//  HEMPDAY
//
//  Created by admin on 12/11/20.
//  Copyright © 2020 Chandradip. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

var currentLocation = CLLocationCoordinate2D()

class HomeVC: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var alertUnderStandView : UIView!
    @IBOutlet weak var alertLbl : UILabel!
    
    @IBOutlet weak var menuView : UIView!
    @IBOutlet weak var understandMsgBackView : UIView!
    @IBOutlet weak var TableVW : UITableView!
    
    @IBOutlet weak var headerConstant : NSLayoutConstraint!
    @IBOutlet weak var buttanConstant : NSLayoutConstraint!

    struct ProductData {
        var productimage : String?, dispensaryName : String?, productimageName : String?, productimagePrice : String?, quantity : String?, location : CLLocation?, MAPdispensariname : String?
    }

    var ProductArray : [ProductData] = []
    
    var locationManager = CLLocationManager()
   // var currentLocation = CLLocationCoordinate2D()
    var firstAlertMsg = "Hempday only features dispensaries with a license to sell cannabis in regions where cannabis is legal on federal or state levels."
    var secondAlertMsg = "Hempday helps users discover products compare prices and find store locations. Nothing is available for purchase on the Hempday the app."
    var alertMessageConstant = 0
    var destinationLocation = CLLocationCoordinate2D()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("showUnderstandAlert",UserDefaults.standard.value(forKey: "showUnderstandAlert"))
        print("ageAlert",UserDefaults.standard.value(forKey: "ageAlert"))
       // UserDefaults.standard.setValue("Yes", forKey: "showUnderstandAlert")

        
        if UserDefaults.standard.value(forKey: "showUnderstandAlert") as? String != "Yes" {
            self.understandMsgBackView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
            self.view.addSubview(self.understandMsgBackView)
            alertLbl.text = firstAlertMsg
            alertUnderStandView.layer.cornerRadius = 45
        }
        
        if view.frame.size.height > 812{
            headerConstant.constant = 60.0
            buttanConstant.constant = 170.0

        }else{
            headerConstant.constant = 45.0
            buttanConstant.constant = 160.0
        }
        
        //userNameLbl.text = "\(UserDefaults.standard.value(forKey: "UserName") as! String)!"
        TableVW.delegate = self
        TableVW.dataSource = self
        dataAppend()
        /*if UserDefaults.standard.value(forKey: "viewResult") as? Bool == true{
            let vc = storyboard?.instantiateViewController(identifier: "ShawProductResultVC") as! ShawProductResultVC
            self.navigationController?.pushViewController(vc, animated: true)
        }*/
        getCurrentLocation()
        if UserDefaults.standard.value(forKey: "ageAlert") as? String != "Yes" {
            ageAlertPopUp()
        }
    }
    
    func ageAlertPopUp(){
        let vc = storyboard?.instantiateViewController(identifier: "AgeAlertViewController") as! AgeAlertViewController
         vc.modalPresentationStyle = .overFullScreen
         self.present(vc, animated: true, completion: nil)
    }
    
    func getCurrentLocation(){
        self.locationManager.requestAlwaysAuthorization()
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
               self.navigationController?.isNavigationBarHidden = true
           }
           
    override func viewWillDisappear(_ animated: Bool) {
            self.navigationController?.isNavigationBarHidden = true
        }
    
    // MARK: - CoreLocation Delegate Methods
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
          if let location = locations.last{
                let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
                    currentLocation = center
            print("currentLocation",currentLocation)
            TableVW.reloadData()

        }
    }
    
    func dataAppend(){
      /*  ProductArray.append(ProductData(productimage: "product3", dispensaryName: "dispensary3", productimageName: "productName3", productimagePrice: "prices3", quantity: ""))*/
//PLANET 13 LAS VEGAS
        ProductArray.append(ProductData(productimage: "7", dispensaryName: "dispensary1", productimageName: "productName1", productimagePrice: "prices1", quantity: "quantity1", location: CLLocation(latitude: 36.13040941988964, longitude: -115.1759872451648), MAPdispensariname : "Planet 13 Las Vegas"))
        
//SHANGO
     /*   ProductArray.append(ProductData(productimage: "8-1", dispensaryName: "dispensary2", productimageName: "productName2", productimagePrice: "prices2", quantity: "", location: CLLocation(latitude: 36.1249145635603, longitude: -115.0791369316731), MAPdispensariname : "Shango"))*/
        
//JARDIN
     /*   ProductArray.append(ProductData(productimage: "product4", dispensaryName: "dispensary4", productimageName: "productName4", productimagePrice: "prices4", quantity: "quantity4", location: CLLocation(latitude: 36.13061932308669, longitude: -115.1108732316728), MAPdispensariname : "Jardin Las Vegas"))*/
    
//THE DISPENSARY
        ProductArray.append(ProductData(productimage: "product5", dispensaryName: "dispensary5", productimageName: "productName5", productimagePrice: "prices5", quantity: "quantity5", location: CLLocation(latitude: 36.03485169976975, longitude: -115.0288944181838), MAPdispensariname : "The Dispensary"))
        
//THE DISPENSARY
       /*                         ProductArray.append(ProductData(productimage: "product6", dispensaryName: "dispensary6", productimageName: "productName6", productimagePrice: "prices6", quantity: "quantity6", location: CLLocation(latitude: 36.03485169976975, longitude: -115.0288944181838), MAPdispensariname : "The Dispensary"))*/
        
//ESSENCE CANNABIS DISPENSARY
        ProductArray.append(ProductData(productimage: "product7", dispensaryName: "dispensary7", productimageName: "productName7", productimagePrice: "prices7", quantity: "quantity7", location: CLLocation(latitude: 36.07254161668779, longitude: -115.080938602838), MAPdispensariname : "Essence Cannabis Dispensary"))
        
//NULEAF
      /*  ProductArray.append(ProductData(productimage: "product8", dispensaryName: "dispensary8", productimageName: "productName8", productimagePrice: "prices8", quantity: "quantity8", location: CLLocation(latitude: 36.12272973745831, longitude: -115.080815874001), MAPdispensariname : "Nuleaf"))*/
    }
    
   /* @IBAction func showpProductListButtonAction( _ sender : UIButton){
        let vc = storyboard?.instantiateViewController(identifier: "DemoProductListVC") as! DemoProductListVC
        self.navigationController?.pushViewController(vc, animated: true)
    }*/
    
    @IBAction func iUnderstandButtonAction( _ sender : UIButton){
        if alertMessageConstant == 0{
            alertLbl.text = secondAlertMsg
            alertMessageConstant = 1
        }else{
            UserDefaults.standard.setValue("Yes", forKey: "showUnderstandAlert")
            self.understandMsgBackView.removeFromSuperview()
        }
    }

    @IBAction func menuButtonAction( _ sender : UIButton){
        
        self.menuView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        self.view.addSubview(self.menuView)
        
    }
    
    @IBAction func crossButtonAction( _ sender : UIButton){
        self.menuView.removeFromSuperview()
       }
    @IBAction func myProfileButtonAction( _ sender : UIButton){
        
        if UserDefaults.standard.value(forKey: "UserId") == nil{
            showAlertMessageokkk(alertTitle: "HEMPDAY !", alertMsg: "ONCE YOU ARE LOGGED IN, YOU CAN ACCESS THESE FEATURES.")
        }else{
            let vc = storyboard?.instantiateViewController(identifier: "ProfileVC") as! ProfileVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func hempMatchesButtonAction( _ sender : UIButton){
         let vc = storyboard?.instantiateViewController(identifier: "TakeQuizVC") as! TakeQuizVC
               self.navigationController?.pushViewController(vc, animated: true)
       }
    
    @IBAction func dispensariesButtonAction( _ sender : UIButton){
        
        let vc = storyboard?.instantiateViewController(identifier: "DispensariesMapVC") as! DispensariesMapVC
        self.navigationController?.pushViewController(vc, animated: true)
           
       }
    
    @IBAction func hempMatesButtonAction( _ sender : UIButton){
           let vc = storyboard?.instantiateViewController(identifier: "DispensariesVC") as! DispensariesVC
           self.navigationController?.pushViewController(vc, animated: true)
       }
    
    @IBAction func myHempdayButtonAction( _ sender : UIButton){
           let vc = storyboard?.instantiateViewController(identifier: "MyHempDayVC") as! MyHempDayVC
           self.navigationController?.pushViewController(vc, animated: true)
       }
    
    @IBAction func shareButtonAction( _ sender : UIButton){
        let vc = storyboard?.instantiateViewController(identifier: "ShareVC") as! ShareVC
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func logoutButtonAction( _ sender : UIButton){
        logoutAlert()
    }
    
    func logoutAlert() {
        let alertController = UIAlertController(title: "HEMPDAY", message: "ARE YOU SURE TO LOGOUT?", preferredStyle: .alert)
        // Create the actions
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
            UIAlertAction in
            //MARK:- User Default Set Value null....
            UserDefaults.standard.set(nil, forKey: "UserId")
            UserDefaults.standard.set("No", forKey: "isLogin")
            UserDefaults.standard.set("No", forKey: "ageAlert")
            UserDefaults.standard.set("Yes", forKey: "showUnderstandAlert")
            UserDefaults.standard.set(nil, forKey: "UserName")
            
          
            let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
            let VC = mainStoryBoard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
            UIApplication.shared.windows.first?.rootViewController = UINavigationController(rootViewController: VC)
            UIApplication.shared.windows.first?.makeKeyAndVisible()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
            UIAlertAction in
        }
        
        alertController.setBackgroundColor(color: UIColor(named: "Color4")!)
        alertController.setTitlet(font: UIFont(name: "Bristol", size: 25.00), color: UIColor(named: "Color1"))
        alertController.setMessage(font: UIFont(name: "Bristol", size: 16.00), color: UIColor(named: "Color1"))
        okAction.setValue(UIColor(named: "Color1"), forKey: "titleTextColor")
        cancelAction.setValue(UIColor(named: "Color1"), forKey: "titleTextColor")
        
        // Add the actions
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        // Present the controller
        self.present(alertController, animated: true, completion: nil)
    }
    
    func getDistance(location : CLLocation) -> String{
        let currentLOC = CLLocation(latitude: currentLocation.latitude, longitude: currentLocation.longitude)
        let dispensaryLocation = CLLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
   //    print("dispensaryLocation",dispensaryLocation)

        let distanceInMile = currentLOC.distance(from: dispensaryLocation) / 1609
    //    print("distanceInMeters",distanceInMile)
        let s =   String(format: "%.1f", distanceInMile)
     //   print("s",s)
        
        return s + " mile"
    }
}

extension HomeVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ProductArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = TableVW.dequeueReusableCell(withIdentifier: "HomeViewCell", for: indexPath) as! HomeViewCell
        
        if ProductArray[indexPath.row].dispensaryName == "dispensary3"{
            cell.nonTradingVW.isHidden = false
            cell.tradingVW.isHidden = true
            cell.productimgVW.image = UIImage(named: ProductArray[indexPath.row].productimage!)
            
        }else{
            cell.nonTradingVW.isHidden = true
            cell.tradingVW.isHidden = false
        cell.productimgVW.image = UIImage(named: ProductArray[indexPath.row].productimage!)
        cell.productNameimgVW.image = UIImage(named: ProductArray[indexPath.row].productimageName!)
        cell.productPriceimgVW.image = UIImage(named: ProductArray[indexPath.row].productimagePrice!)
        cell.dispensaryimgVW.image = UIImage(named: ProductArray[indexPath.row].dispensaryName!)
        cell.productQuantityimgVW.image = UIImage(named: ProductArray[indexPath.row].quantity!)
            cell.distancelbl.text = getDistance(location: ProductArray[indexPath.row].location!)

        }
        
        cell.t_DeliveryNowButton.addTarget(self, action: #selector(self.pressDeliveryButton(_:)), for: .touchUpInside)
        cell.t_PickUpButton.addTarget(self, action: #selector(self.pressDirectionButton(_:)), for: .touchUpInside)
        cell.t_PickUpButton.tag = indexPath.row
        cell.viewDetailsButton.addTarget(self, action: #selector(self.pressDeliveryButton(_:)), for: .touchUpInside)

        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height:  tableView.bounds.size.height))
        headerView.backgroundColor = UIColor(named: "Color1")
      
      return headerView
    }
        
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)

    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var size = CGFloat()
        // Big Screen
        if view.frame.size.height > 812{
            size = 210
        }else{
            size = 200
        }
        return size
    }
    
     func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        dataAppend()
        TableVW.reloadData()
    }
    
    
      @objc func pressDirectionButton(_ sender: UIButton){
          
          for (index,element) in ProductArray.enumerated(){
              if index == sender.tag{
                  destinationLocation.latitude = element.location?.coordinate.latitude ?? 0.0000000
                  destinationLocation.longitude = element.location?.coordinate.longitude ?? 0.000000
                  let source = MKMapItem(placemark: MKPlacemark(coordinate: currentLocation))
                  source.name = "Your Current Location"
                  let destination = MKMapItem(placemark: MKPlacemark(coordinate: destinationLocation))
                  destination.name = element.MAPdispensariname
                  MKMapItem.openMaps(with: [source, destination], launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
                  
                  break
              }
          }
        
       /* let vc = storyboard?.instantiateViewController(identifier: "PickUpMapVC") as! PickUpMapVC
        for (index,element) in ProductArray.enumerated(){
            if index == sender.tag{
                vc.destinationLocation.latitude = element.location?.coordinate.latitude ?? 0.0000000
                vc.destinationLocation.longitude = element.location?.coordinate.longitude ?? 0.000000
                print("element.dispensari_name",element.MAPdispensariname)
                vc.destinationLocationTitle = element.MAPdispensariname!
                vc.destinationLocationSubTitle = ""
            }
        }
        self.navigationController?.pushViewController(vc, animated: true)*/
    }
    
    @objc func pressDeliveryButton(_ sender: UIButton){
        let vc = storyboard?.instantiateViewController(identifier: "HempDayVC") as! HempDayVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
