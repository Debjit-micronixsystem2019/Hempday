//
//  PriceRangeVC.swift
//  HEMPDAY
//
//  Created by admin on 7/15/21.
//  Copyright © 2021 Chandradip. All rights reserved.
//

import UIKit
import RangeSeekSlider

class PriceRangeVC: UIViewController {
    
    @IBOutlet weak var increasePriceLabel : UILabel!
    @IBOutlet weak var decreasePriceLabel : UILabel!
    @IBOutlet fileprivate weak var rangeSlider : RangeSeekSlider!
    
    var maxvalues = Int()
    var minvalues = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUIslider()
    }
    
    override func viewWillAppear(_ animated: Bool) {
         self.navigationController?.isNavigationBarHidden = true
     }
            
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func setUIslider(){
        rangeSlider.delegate = self
          
          rangeSlider.minValue = 0.0
          rangeSlider.maxValue = 300.0
          rangeSlider.selectedMinValue = 0.0
        rangeSlider.selectedMaxValue = 300.0
          rangeSlider.minDistance = 10.0
          rangeSlider.maxDistance = 300.0
       //   rangeSlider.handleColor = .green
        //  rangeSlider.secondhandleColor = .black
        //  rangeSlider.ha
          rangeSlider.handleDiameter = 30.0
          rangeSlider.selectedHandleDiameterMultiplier = 1.3
          rangeSlider.numberFormatter.numberStyle = .currency
          rangeSlider.numberFormatter.locale = Locale(identifier: "en_US")
          rangeSlider.numberFormatter.maximumFractionDigits = 2
        //  rangeSlider.minLabelFont = UIFont(name: "ChalkboardSE-Regular", size: 15.0)!
         // rangeSlider.maxLabelFont = UIFont(name: "ChalkboardSE-Regular", size: 15.0)!
         // rangeSlider.colorBetweenHandles = .red
        rangeSlider.lineHeight = 5.0
    }
    
    @IBAction func backButtonAction( _ sender : UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func startHempdayButtonAction( _ sender : UIButton){
        let vc = storyboard?.instantiateViewController(identifier: "ShawProductResultVC") as! ShawProductResultVC
        vc.lowPrice = "\(minvalues)"
        vc.highPrice = "\(maxvalues)"
        self.navigationController?.pushViewController(vc, animated: true)
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

// MARK: - RangeSeekSliderDelegate

extension PriceRangeVC: RangeSeekSliderDelegate {

    func rangeSeekSlider(_ slider: RangeSeekSlider, didChange minValue: CGFloat, maxValue: CGFloat) {
        if slider === rangeSlider {
            print("Standard slider updated. Min Value: \(minValue) Max Value: \(maxValue)")
        }/* else if slider === rangeSliderCurrency {
            print("Currency slider updated. Min Value: \(minValue) Max Value: \(maxValue)")
        } else if slider === rangeSliderCustom {
            print("Custom slider updated. Min Value: \(minValue) Max Value: \(maxValue)")
        }*/
         maxvalues = Int(maxValue)
         minvalues = Int(minValue)
                
               increasePriceLabel.text = "$\(String(maxvalues))"
                decreasePriceLabel.text = "$\(String(minvalues))"
    }

    func didStartTouches(in slider: RangeSeekSlider) {
        print("did start touches")
    }

    func didEndTouches(in slider: RangeSeekSlider) {
        print("did end touches")
    }
}
