//
//  PickUpMapVC.swift
//  HEMPDAY
//
//  Created by admin on 7/27/21.
//  Copyright © 2021 Chandradip. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import AVFoundation

class PickUpMapVC: UIViewController{
    
    @IBOutlet weak var confirmBackVW: UIView!{
        didSet{
            confirmBackVW.layer.cornerRadius = 50
        }
    }
    
    @IBOutlet weak var directionBackVW: UIView!{
        didSet{
            directionBackVW.layer.cornerRadius = 20
            directionBackVW.isHidden = true
        }
    }
    @IBOutlet weak var confirmVWTimeLbl: UILabel!

    @IBOutlet weak var directionDistanceLbl: UILabel!
    @IBOutlet weak var directionTimeLbl: UILabel!
    @IBOutlet weak var directionLbl: UILabel!
    @IBOutlet weak var navigationButton: UIButton!{
        didSet{
            navigationButton.setTitle("Start Navigation", for: .normal)
        }
    }
    @IBOutlet weak var mapView: MKMapView!
    
    @IBAction func confirmBtnAction(_ sender : UIButton){
        let destinationCoordinate = CLLocationCoordinate2D(latitude: destinationLocation.latitude, longitude: destinationLocation.longitude)

            let annotation = MKPointAnnotation()
            annotation.coordinate = destinationCoordinate
            annotation.title = destinationLocationTitle
            annotation.subtitle = destinationLocationSubTitle
            self.mapView.addAnnotation(annotation)
        self.mapRoute(destinationCoordinate: destinationCoordinate)
        confirmBackVW.isHidden = true
        directionBackVW.isHidden = false
    }
    @IBAction func navigationBtnAction(_ sender : UIButton){
        if !navigationStarted{
            showMapRoute = true
            if let location = locationManager.location {
                let center = location.coordinate
                centerViewToUserLocation(center: center)
            }
        }else{
           if let route = route {
            self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, edgePadding: UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16), animated: true)
            self.steps.removeAll()
            self.stepCounter = 0
            }
        }
        navigationStarted.toggle()
        
        navigationButton.setTitle(navigationStarted ? "Stop Navigation" : "Start Navigation", for: .normal)
    }
    
    @IBAction func backtButtonAction( _ sender : UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
        var steps: [MKRoute.Step] = []
        var stepCounter = 0
        var route: MKRoute?
        var showMapRoute = false
        var navigationStarted = false
        let locationDistance: Double = 500
        var currentLocation = CLLocationCoordinate2D()
    
        var destinationLocation = CLLocationCoordinate2D()
        var destinationLocationTitle = String()
        var destinationLocationSubTitle = String()

    var getconfirmLBLTime  = false
        
        var speechsynthsizer = AVSpeechSynthesizer()
        
        lazy var locationManager: CLLocationManager = {
            let locationManager = CLLocationManager()
            
            if CLLocationManager.locationServicesEnabled(){
                locationManager.delegate = self
                locationManager.desiredAccuracy = kCLLocationAccuracyBest
                handleAuthorizationStatus(locationManager: locationManager, status: CLLocationManager.authorizationStatus())
            }else{
                print("Location are not enable")
                showAlertMessageokkk(alertTitle: "To continue, Please turn on your location service.", alertMsg: "Location!!")
            }
            
        return locationManager
        }()
        
     

        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view.
            locationManager.startUpdatingLocation()
            
            mapView.delegate = self
            mapView.showsUserLocation = true
           // confirmBackVW.isHidden = true
        }
        
        fileprivate func centerViewToUserLocation(center: CLLocationCoordinate2D) {
            let region = MKCoordinateRegion(center: center, latitudinalMeters: locationDistance, longitudinalMeters: locationDistance)
            mapView.setRegion(region, animated: true)
        }
        
        fileprivate func handleAuthorizationStatus(locationManager: CLLocationManager, status: CLAuthorizationStatus) {
            switch status {
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
                break
            case .restricted:
                break
            case .denied:
                break
            case .authorizedAlways:
                break
            case .authorizedWhenInUse:
                if let center = locationManager.location?.coordinate {
                    centerViewToUserLocation(center: center)
                }
                break
            @unknown default:
                break
            }
        }
        
        fileprivate func mapRoute(destinationCoordinate: CLLocationCoordinate2D) {
            guard let sourceCoordinate = locationManager.location?.coordinate else { return }
            
            let sourcePlaceMark = MKPlacemark(coordinate: sourceCoordinate)
            let destinationPlaceMark = MKPlacemark(coordinate: destinationCoordinate)
            
            let sourceItem = MKMapItem(placemark: sourcePlaceMark)
            let destinationItem = MKMapItem(placemark: destinationPlaceMark)
            
            let routeRequest = MKDirections.Request()
            routeRequest.source = sourceItem
            routeRequest.destination = destinationItem
            routeRequest.transportType = .automobile
            
            let direction = MKDirections(request: routeRequest)
            direction.calculate { (response, err) in
                if let err = err {
                    print(err.localizedDescription)
                    return
                }
                guard let response = response, let route = response.routes.first else {return}
                
                self.route = route
                self.mapView.addOverlay(route.polyline)
                self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, edgePadding: UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16), animated: true)
                
                self.getRouteSteps(route: route)
            }
        }
        
        fileprivate func getRouteSteps(route: MKRoute) {
            for monitoredRegion in locationManager.monitoredRegions {
                locationManager.stopMonitoring(for: monitoredRegion)
            }
            
            let steps = route.steps
            self.steps = steps
            
            for i in 0..<steps.count {
                let step = steps[i]
                print(step.instructions)
                print(step.distance)
                
                let region = CLCircularRegion(center: step.polyline.coordinate, radius: 20, identifier: "\(i)")
                locationManager.startMonitoring(for: region)
            }
            stepCounter += 1
            let initialMessage = "In \(meterTOmileConvert(value : steps[stepCounter].distance)) \(steps[stepCounter].instructions)"
            
       //     , then in \(steps[stepCounter + 1].distance) meters, \(steps[stepCounter + 1].instructions)
            
            directionLbl.text = initialMessage
            let speechUtterance = AVSpeechUtterance(string: initialMessage)
            speechsynthsizer.speak(speechUtterance)
         //   print("timeee:====>",route.expectedTravelTime)
            print("timeeess:====>",secondsToHoursMinutesSeconds(seconds: Int(route.expectedTravelTime)))
            directionTimeLbl.text = secondsToHoursMinutesSeconds(seconds: Int(route.expectedTravelTime))
            directionDistanceLbl.text = getDistance(location: currentLocation)
        }
        
        func secondsToHoursMinutesSeconds (seconds : Int) -> String {
          return "\(seconds / 3600)h \((seconds % 3600) / 60)m \((seconds % 3600) % 60)s"
        }
    
     func getDistance(location : CLLocationCoordinate2D) -> String{
        let currentLOC = CLLocation(latitude: location.latitude, longitude: location.longitude)
         let dispensaryLocation = CLLocation(latitude: 18.5204, longitude: 73.8567)

         let distanceInMile = currentLOC.distance(from: dispensaryLocation) / 1609
         let s =   String(format: "%.1f", distanceInMile)
      //   print("s",s)
         return s + " mile"
     }
    
    func meterTOmileConvert(value : Double) -> String{
        print ("valesss",value)
        var result = String()
        if value >= 165{
            let distanceInMile = value / 1609
            result =   String(format: "%.1f", distanceInMile) + " miles"

        }else{
            result =   String(format: "%.1f", value) + " meters"
        }
     //   print("s",s)
        return result
    }
    
    func showTomeInConfirmVW(pickupCoordinate: CLLocationCoordinate2D, destinationCoordinate: CLLocationCoordinate2D) {

           let request = MKDirections.Request()
           request.source = MKMapItem(placemark: MKPlacemark(coordinate: pickupCoordinate, addressDictionary: nil))
           request.destination = MKMapItem(placemark: MKPlacemark(coordinate: destinationCoordinate, addressDictionary: nil))
           request.requestsAlternateRoutes = true
           request.transportType = .automobile
           
           let directions = MKDirections(request: request)
           
           directions.calculate { [unowned self] response, error in
               guard let unwrappedResponse = response else { return }
            
               if (unwrappedResponse.routes.count > 0) {
             //   print("Time Taken : ",self.secondsToHoursMinutesSeconds(seconds: Int(unwrappedResponse.routes[0].expectedTravelTime)))
                self.confirmVWTimeLbl.text = "Your order will be ready for pick up in \(self.secondsToHoursMinutesSeconds(seconds: Int(unwrappedResponse.routes[0].expectedTravelTime)))."

                }
           }
        
       }
}

    extension PickUpMapVC: CLLocationManagerDelegate {
        
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            if !showMapRoute {
                if let location = locations.last{
                    let center = location.coordinate
                    centerViewToUserLocation(center: center)
                    currentLocation = center
                    
                    if getconfirmLBLTime == false{
                    showTomeInConfirmVW(pickupCoordinate: center, destinationCoordinate: destinationLocation)
                        getconfirmLBLTime = true
                    }

                }
            }
        }
        
        func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            handleAuthorizationStatus(locationManager: locationManager, status: status)
        }
        
        func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
            stepCounter += 1
            if stepCounter < steps.count {
                let message = "In \(meterTOmileConvert(value : steps[stepCounter].distance)) \(steps[stepCounter].instructions)"
                directionLbl.text = message
                let speechUtterance = AVSpeechUtterance(string: message)
                speechsynthsizer.speak(speechUtterance)
                directionTimeLbl.text = secondsToHoursMinutesSeconds(seconds: Int(route?.expectedTravelTime ?? 0.00))
                directionDistanceLbl.text = getDistance(location: currentLocation)
            }else{
                let message = "You have arrived at your destination"
                directionLbl.text = message
                stepCounter = 0
                navigationStarted = false
                for monitoredRegion in locationManager.monitoredRegions {
                    locationManager.stopMonitoring(for: monitoredRegion)
                }
            }
        }
    }

    extension PickUpMapVC: MKMapViewDelegate{
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            let renderer = MKPolylineRenderer(overlay: overlay)
            renderer.strokeColor = .systemBlue
            return renderer
        }
    }
