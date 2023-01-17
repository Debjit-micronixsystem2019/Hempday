//
//  DispensariesMapVC.swift
//  HEMPDAY
//
//  Created by admin on 1/13/21.
//  Copyright © 2021 Chandradip. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import MBProgressHUD


class CustomPointAnnotation: MKPointAnnotation {
var pinCustomImageName:String!
}

struct searchigLasVegas {
    var name : String, lat : Double?, long : Double?
}


class DispensariesMapVC: UIViewController,CLLocationManagerDelegate,MKMapViewDelegate {
     var crossButton = "1"
    
    var jsonFetch = jasonFetchClass()
    lazy var DispensariecListArray: [Dispensariec] = []
    lazy var NonFilterArray: [searchigLasVegas] = []
    var lasveagsAreaArray: [searchigLasVegas] = []
    let locationManager = CLLocationManager()
    var pointAnnotation:CustomPointAnnotation!
    var pinAnnotationView:MKPinAnnotationView!
    var searching : Bool = false
    var currentLocation = CLLocationCoordinate2D()
    var destinationLocation = CLLocationCoordinate2D()
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var addressView: UIView!{
        didSet{
            addressView.layer.cornerRadius = 10
            addressView.isHidden = true
        }
    }
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var dispenseriesLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var SearchVw: UIView!{
        didSet{
            SearchVw.isHidden = true
        }
    }
    @IBOutlet weak var searchNotFound : UILabel!{
        didSet{
            searchNotFound.isHidden = true
        }
    }
    @IBOutlet weak var SearchBackGroundVw: UIView!{
        didSet{
            SearchBackGroundVw.layer.cornerRadius = 27
            SearchBackGroundVw.layer.borderWidth = 1.0
            SearchBackGroundVw.layer.borderColor = UIColor.lightGray.cgColor
            
        }
    }
    @IBOutlet weak var searchtext : UITextField!
     
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchtext.delegate = self
        jsonFetch.jsondata = self
        tableView.delegate = self
        tableView.dataSource = self
        self.locationManager.requestAlwaysAuthorization()
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }

        mapView.delegate = self
        mapView.mapType = .standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        mapView.showsUserLocation = true
      
 

        if let coor = mapView.userLocation.location?.coordinate{
            mapView.setCenter(coor, animated: true)
        
        }
        searchtext.addTarget(self, action: #selector(DispensariesMapVC.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
    //    createAnnotations(location: annotationLocation)
        hideKeyboardWhenTappedAround()
        fetcchaddressdata()
        searchingdataAppend()
        
        //mapView.userLocation.title = nil
    }
    
    func fetcchaddressdata() {
               let param = [
                   "authorised_key":"SGVtcERheTIwMjAj"
                 ]
               print("param",param)
               MBProgressHUD.showAdded(to: (self.view)!, animated: true)
               jsonFetch.fetchData(param, methodtype: "post", url: baseUrl + "/dispensari_list", jsonname: "dispensari_list")
           }
    
    
    func searchingdataAppend(){
        lasveagsAreaArray.append(searchigLasVegas(name: "BOULDER CITY", lat: 36.1249145635603, long: -115.0791369316731))
        lasveagsAreaArray.append(searchigLasVegas(name: "CALIENTE", lat: 0, long: 0))
        lasveagsAreaArray.append(searchigLasVegas(name: "CARLIN", lat: 0, long: 0))
        lasveagsAreaArray.append(searchigLasVegas(name: "CARSON CITY", lat: 0, long: 0))
        lasveagsAreaArray.append(searchigLasVegas(name: "ELKO", lat: 0, long: 0))
        lasveagsAreaArray.append(searchigLasVegas(name: "ELY", lat: 0, long: 0))
        lasveagsAreaArray.append(searchigLasVegas(name: "FALLON", lat: 0, long: 0))
        lasveagsAreaArray.append(searchigLasVegas(name: "FERNLEY", lat: 0, long: 0))
        lasveagsAreaArray.append(searchigLasVegas(name: "HENDERSON", lat: 36.07254161668779, long: -115.0809386028386))
        lasveagsAreaArray.append(searchigLasVegas(name: "LAS VEGAS", lat: 36.13040941988964, long: -115.1759872451648))
        lasveagsAreaArray.append(searchigLasVegas(name: "LOVELOCK", lat: 0, long: 0))
        lasveagsAreaArray.append(searchigLasVegas(name: "MESQUITE", lat: 0, long: 0))
        lasveagsAreaArray.append(searchigLasVegas(name: "NORTH LAS VEGAS", lat: 36.19878049576501, long: -115.1262216451627))
        lasveagsAreaArray.append(searchigLasVegas(name: "RENO", lat: 0, long: 0))
        lasveagsAreaArray.append(searchigLasVegas(name: "SPARKS", lat: 0, long: 0))
        lasveagsAreaArray.append(searchigLasVegas(name: "WELLS", lat: 0, long: 0))
        lasveagsAreaArray.append(searchigLasVegas(name: "WEST WENDOVER", lat: 0, long: 0))
        lasveagsAreaArray.append(searchigLasVegas(name: "WINNEMUCCA", lat: 0, long: 0))
        lasveagsAreaArray.append(searchigLasVegas(name: "YERINGTON", lat: 0, long: 0))
    }
    
   
    let annotationLocation = [
    ["title": "PLANET 13 LAS VEGAS", "latitude": 36.13040941988964, "longitude": -115.1759872451648],
    ["title": "ESSENCE CANNABIS DISPENSARY", "latitude": 36.07254161668779, "longitude": -115.080938602838],
    ["title": "SHANGO MARJIUANA DISPENSARY", "latitude": 36.1249145635603, "longitude": -115.0791369316731],
    ["title": "JARDIN PREMIUM CANNABIS DISPENSARY", "latitude": 36.13061932308669, "longitude": -115.1108732316728],
    ["title": "REEF DISPENSARIES", "latitude": 36.12829432796446, "longitude": -115.1769552740009],
    ["title": "GREEN CANNNABIS CO", "latitude": 36.12376096558653, "longitude": -115.2080607316731],
    ["title": "NULEAF", "latitude": 36.12272973745831, "longitude": -115.080815874001],
    ["title": "THE SANCUARY - NORTH LAS VEGAS", "latitude": 36.19878049576501, "longitude": -115.1262216451627],
    ["title": "THE DISPENSARY", "latitude": 36.03485169976975, "longitude": -115.0288944181838]
    ,["title": "PISOS", "latitude": 36.11381697376444, "longitude": -115.1366512181813]]
    
    override func viewWillAppear(_ animated: Bool) {
           self.navigationController?.isNavigationBarHidden = true
       }
              
       override func viewWillDisappear(_ animated: Bool) {
           self.navigationController?.isNavigationBarHidden = true
       }
    
    @IBAction func crossButtonAction( _ sender : UIButton){
            addressView.isHidden = true

          }
    @IBAction func searchCrossButtonAction( _ sender : UIButton){
        hideKeyboardWhenTappedAround()
        tableView.reloadData()
        searching = false
        searchtext.text = ""
        SearchVw.isHidden = true

    }
    @IBAction func goToDirectionButtonAction( _ sender : UIButton){
        
        let source = MKMapItem(placemark: MKPlacemark(coordinate: currentLocation))
        source.name = "Source"

        let destination = MKMapItem(placemark: MKPlacemark(coordinate: destinationLocation))
        destination.name = "Destination"

        MKMapItem.openMaps(with: [source, destination], launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
       
        addressView.isHidden = true
    }
    
    func createAnnotations(location: [[String : Any]]){

        let center = CLLocationCoordinate2D(latitude: 36.114647, longitude: -115.105987)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.3, longitudeDelta: 0.3))
        self.mapView.setRegion(region, animated: true)
        
        for location in location{
            let annotations = MKPointAnnotation()
            annotations.title = location["title"] as? String
            annotations.coordinate = CLLocationCoordinate2D(latitude: location["latitude"] as! CLLocationDegrees, longitude: location["longitude"] as! CLLocationDegrees)
            mapView.addAnnotation(annotations)
           
        }
       
    }
    
    @IBAction func backButtonAction( _ sender : UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    
    mapView.mapType = MKMapType.standard
        
      if let location = locations.last{
            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
                currentLocation = center
        print("currentLocation",currentLocation)
 //   let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.3, longitudeDelta: 0.3))
   //         self.mapView.setRegion(region, animated: true)
        

        }
}
    //USER LOCATION BLUE DOT HIDE
    func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
       if let userLocation = mapView.view(for: mapView.userLocation) {
            userLocation.isHidden = true
       }
    }

    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
      
        addressView.isHidden = false

        print(view.annotation?.title)
        dispenseriesLbl.text = view.annotation?.title ?? ""
        destinationLocation = view.annotation!.coordinate
        
        for (index,element) in DispensariecListArray.enumerated(){
            
            if element.dispensari_name == view.annotation?.title{
                addressLbl.text = element.address
            }
        }
    }
}

extension DispensariesMapVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching{
                 return  NonFilterArray.count
                   
               }else{
               return lasveagsAreaArray.count
               }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DispenriesSearchCell", for: indexPath) as! DispenriesSearchCell
         if searching{
            cell.addressLbl.text = NonFilterArray[indexPath.row].name
         }else{
            cell.addressLbl.text = lasveagsAreaArray[indexPath.row].name
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if searching{
            if NonFilterArray[indexPath.row].lat == 0{
                showAlertMessageokkk(alertTitle: "HEMPDAY !", alertMsg: "NO DISPENSARY AVAILABLE IN THIS AREA.")
            }else{
            let center = CLLocationCoordinate2D(latitude: NonFilterArray[indexPath.row].lat!, longitude: NonFilterArray[indexPath.row].long!)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
                  self.mapView.setRegion(region, animated: true)
            }
            
        }else{
            if lasveagsAreaArray[indexPath.row].lat == 0{
                 showAlertMessageokkk(alertTitle: "HEMPDAY !", alertMsg: "NO DISPENSARY AVAILABLE IN THIS AREA.")
             }else{
            let center = CLLocationCoordinate2D(latitude: lasveagsAreaArray[indexPath.row].lat!, longitude: lasveagsAreaArray[indexPath.row].long!)
                    let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
                  self.mapView.setRegion(region, animated: true)
            }
        }
            print(searching)
       SearchVw.isHidden = true
    }
}

extension DispensariesMapVC : UITextFieldDelegate{
    
    @objc func textFieldDidChange(textField : UITextField){
      //  print("searchtext",searchtext.text)
        if searchtext.text?.count == 0{
            searching = false
            tableView.reloadData()
            if lasveagsAreaArray.count != 0{
                searchNotFound.isHidden = true
            }
        
        }else{
        if lasveagsAreaArray.count != 0{
            NonFilterArray = lasveagsAreaArray.filter({$0.name.prefix(searchtext.text!.count) == searchtext.text!.uppercased()})

            print("NonFilterArray",NonFilterArray)
            searching = true
            tableView.reloadData()
        }
            if NonFilterArray.count == 0{
                searchNotFound.isHidden = false
            }else{
                 searchNotFound.isHidden = true
            }
    }
}
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
      //  print("textFieldBegin",textField.text)
        searching = false
        tableView.reloadData()
        SearchVw.isHidden = false
        searchNotFound.isHidden = true

    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
   
        searchtext.resignFirstResponder()

        return true
    }
    func hideKeyboardWhenTappedAround() {
           let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DispensariesMapVC.dismissKeyboard))
           tap.cancelsTouchesInView = false
           view.addGestureRecognizer(tap)
       }
       
    @objc func dismissKeyboard() {
           view.endEditing(true)
       }
}


extension DispensariesMapVC : jsonDataDelegate {
           func didReceivedData(_ data: Any, jsonname: String) {
               print("Raw Data>>",data)
               print("Jsonname>>",jsonname)
               if data as? String ==  "NO INTERNET CONNECTION" {
                   DispatchQueue.main.async { MBProgressHUD.hide(for: (self.view)!, animated: true) }
                   showAlertMessageokkk(alertTitle: "NETWORK !", alertMsg: "CHECK YOUR INTERNET CONNECTION PLEASE.")
               } else {
                   print(data as! NSDictionary)
                   if ((data as! NSDictionary).object(forKey: "status") as! String) == "Yes" {
                       
                       self.DispensariecListArray.removeAll()
                                                                                  
                       if let userData = (data as AnyObject).object(forKey: "data") as? NSArray{
                       //  print(userData)
                                
                           for eachData in userData {
                                                                                          
                               guard let eachdataitem = eachData as? [String : Any] else {return}
                                                    
                               guard let address = eachdataitem["address"] as? String else {return}
                               guard let dispensari_name = eachdataitem["dispensari_name"] as? String else {return}
                               guard let latitude = eachdataitem["latitude"] as? Double else {return}
                                guard let longitude = eachdataitem["longitude"] as? Double else {return}
                                   
                               self.DispensariecListArray.append(Dispensariec(address: address, dispensari_name: dispensari_name, latitude: latitude, longitude: longitude))
                                                                                          
                                   }
                                   print("DispensariecListArray>>",DispensariecListArray)
                               }
                               tableView.reloadData()
                    
                            createAnnotations(location: annotationLocation)
                    DispatchQueue.main.async { MBProgressHUD.hide(for: (self.view)!, animated: true) }
                   } else {
                       //Alert here..
                       if ((data as! NSDictionary).object(forKey: "status") as! String) == "No"{
                           DispatchQueue.main.async { MBProgressHUD.hide(for: (self.view)!, animated: true) }
                      //      previosLbl.isHidden = true
                           showAlertMessageokkk(alertTitle: "HEMPDAY !", alertMsg: "DISPENSARY IS NOT AVAILABLE.")
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


