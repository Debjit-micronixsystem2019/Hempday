//
//  Utility.swift
//  HEMPDAY
//
//  Created by admin on 12/18/20.
//  Copyright © 2020 Chandradip. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController{
    
    //MARK: for Email validation
    func isValidEmail(emailStr:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: emailStr)
        
    }
    
    func buttonRound(name : UIButton, radiousCorner : Float)  {
        name.layer.cornerRadius = CGFloat(radiousCorner)
    }
    
    func shadowForViewBorder(view: UIView,shadowRadius: Float,shadowOpacity: Float,viewcorner: Float) {
        view.layer.cornerRadius = CGFloat(viewcorner)
           view.layer.shadowOpacity = shadowOpacity
           view.layer.shadowColor = UIColor.black.cgColor
           view.layer.shadowOffset = CGSize(width: -1, height: 1)
           view.layer.masksToBounds = false
           view.layer.shadowRadius = CGFloat(shadowRadius)
           view.layer.shouldRasterize = true
        view.layer.borderWidth = 0.6
        view.layer.borderColor = UIColor.black.cgColor
       
    }
    
    func showAlertMessageokkk(alertTitle: String, alertMsg : String)
       {
           let alertController = UIAlertController(title: alertTitle, message: alertMsg, preferredStyle: .alert)
        
           let OKAction = UIAlertAction(title: "OK", style: .default) {
               (action: UIAlertAction) in
           //    self.navigationController?.popViewController(animated: true)
            
              self.dismiss(animated: true, completion: nil)
           }
        
        alertController.setBackgroundColor(color: UIColor(named: "Color4")!)
        alertController.setTitlet(font: UIFont(name: "Bristol", size: 25.00), color: UIColor(named: "Color1"))
        alertController.setMessage(font: UIFont(name: "Bristol", size: 16.00), color: UIColor(named: "Color1"))
        OKAction.setValue(UIColor(named: "Color1"), forKey: "titleTextColor")
        
        alertController.addAction(OKAction)
         
           
           self.present(alertController, animated: true, completion: nil)
        
        
       }
    
    func showAlert(title: String, message: String, noOfButton: NSNumber, selectorMethod: ()) -> Void {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        
        if noOfButton == 2 {
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { action in
                print("OK")
                selectorMethod
                
            }))
            
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: { action in
                print("CANCEL")
            }))
        }
        else{
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { action in
                print("OK")
                selectorMethod
            }))
        }
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension Date {

    static func getCurrentDate(dateformat : String) -> String {

        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = dateformat

       // dateFormatter.dateFormat = "d MMM yyyy"

        return dateFormatter.string(from: Date())

    }
}
extension UIImage {
    
    class func imageWithColor(color: UIColor, size: CGSize) -> UIImage {
        let rect: CGRect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
    
    func imageWithColor(color1: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        color1.setFill()
        
        let context = UIGraphicsGetCurrentContext()
        context?.translateBy(x: 0, y: self.size.height)
        context?.scaleBy(x: 1.0, y: -1.0)
        context?.setBlendMode(CGBlendMode.normal)
        
        let rect = CGRect(origin: .zero, size: CGSize(width: self.size.width, height: self.size.height))
        context?.clip(to: rect, mask: self.cgImage!)
        context?.fill(rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
}
