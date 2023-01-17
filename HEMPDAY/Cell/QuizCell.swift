//
//  QuizCell.swift
//  HEMPDAY
//
//  Created by admin on 12/18/20.
//  Copyright © 2020 Chandradip. All rights reserved.
//

import UIKit
import MBProgressHUD
import RangeSeekSlider



class QuizCell: UICollectionViewCell,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var quesLbl : UILabel!
    @IBOutlet weak var quizOptionTableVW : UITableView!
    
    @IBOutlet weak var slideView : UIView!{
        didSet{
            slideView.isHidden = true
        }
    }
    @IBOutlet fileprivate weak var rangeSlider : RangeSeekSlider!
    @IBOutlet weak var increasePriceLabel : UILabel!
    @IBOutlet weak var decreasePriceLabel : UILabel!

    
    @IBOutlet weak var textView : UIView!{
        didSet{
            textView.isHidden = true
        }
    }

     @IBOutlet weak var textShawButton : UIButton!
    
        var countdata = Int()
        var choiceAnswer : [choices]?
        static let cellData = QuizCell()
        var questionId : String?
        var multiSelectOption : Bool = false
    
        var HeaderHeight = CGFloat()
        var ViewHeight = CGFloat()
    
        override func awakeFromNib() {
             super.awakeFromNib()
            quizOptionTableVW.delegate = self
            quizOptionTableVW.dataSource = self
           setUIslider()
         }

         override func layoutSubviews() {
             super.layoutSubviews()
            textView.layer.cornerRadius = 8
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
    
    @IBAction func textShawButtonAction( _ sender : UIButton){
      textView.isHidden = false
    }
    
    @IBAction func textHideButtonAction( _ sender : UIButton){
        textView.isHidden = true
    }
    
    @IBAction func sliderPriceRange(sender: UISlider) {
        let currentValue = Int(sender.value)
        print("Slider changing to \(currentValue) ?")
        increasePriceLabel.text = "$\(currentValue)"
       
    }
        
        func setUpAnswer(choice : [choices]){
            choiceAnswer = choice
            quizOptionTableVW.reloadData()
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return choiceAnswer?.count ?? 0
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = quizOptionTableVW.dequeueReusableCell(withIdentifier: "QuizOptionCell", for: indexPath) as! QuizOptionCell
            let choiceOption = choiceAnswer?[indexPath.row]
            cell.configCellUI(choice : choiceOption)
            if selectAnswer.selectAnswerOptionID.contains(choiceAnswer?[indexPath.row].choice_id ?? ""){
                cell.backgroundimageView.tintColor = UIColor(named: "Color2")
            }else{
                cell.backgroundimageView.tintColor = UIColor(named: "Color1")
            }
            
            if ViewHeight > 812{
                cell.topConstantInCell.constant = 27
                cell.bottomConstantInCell.constant = 27
            }else{
                cell.topConstantInCell.constant = 18
                cell.bottomConstantInCell.constant = 18
            }
            
            return cell
        }
        func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
            {
          let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height:  tableView.bounds.size.height))
          headerView.backgroundColor = UIColor(named: "Color4")
        
                return headerView
            }
        func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            
            if ViewHeight > 812{
                return 33
            }else{
                return 22
            }
        }
       /* func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return UITableView
        }*/
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
            var arrayAppend : Bool = false
            //MARK:- For Health Concerns Question Choose Multiple Option || WHAT ARE YOUR TASTE BUDS FEELING
             if multiSelectOption{
                for (index,id) in selectAnswer.selectAnswerOptionID.enumerated(){
                    if choiceAnswer?[indexPath.row].choice_id == id{
                        print("ID>>>",id,"  index>>",index)
                        selectAnswer.selectAnswerOptionID.remove(at: index)
                        selectAnswer.selectQuestionID.remove(at: index)
                        arrayAppend = false
                        break;
                    }else{
                       arrayAppend = true
                    }
                }
                if arrayAppend{
                    selectAnswer.selectQuestionID.append(questionId ?? "")
                    selectAnswer.selectAnswerOptionID.append(choiceAnswer?[indexPath.row].choice_id ?? "")
                }
             }else{
                //MARK:- For Other Question Choose Single Option
                if selectAnswer.selectQuestionID.contains(questionId ?? ""){
                  if let index = selectAnswer.selectQuestionID.firstIndex(of: questionId ?? ""){
                    selectAnswer.selectAnswerOptionID[index] = choiceAnswer?[indexPath.row].choice_id ?? ""
                        }
                      }else{
                        selectAnswer.selectQuestionID.append(questionId ?? "")
                        selectAnswer.selectAnswerOptionID.append(choiceAnswer?[indexPath.row].choice_id ?? "")
                    }
                }
            //MARK:- For  Health Concerns Question Skip
            if questionId == "3"{
            if choiceAnswer?[indexPath.row].choice_id == "11"{
                HealthConcernsSkip = true
                print("HealthConcernsSkip",HealthConcernsSkip)
            }else{
               HealthConcernsSkip = false
                print("HealthConcernsSkip",HealthConcernsSkip)
                print("questionId",questionId)
                }
            }
            print("selectQuestionID",selectAnswer.selectQuestionID)
            print("selectAnswerOptionID",selectAnswer.selectAnswerOptionID)
            quizOptionTableVW.reloadData()
        }
    }

// MARK: - RangeSeekSliderDelegate

extension QuizCell: RangeSeekSliderDelegate {

    func rangeSeekSlider(_ slider: RangeSeekSlider, didChange minValue: CGFloat, maxValue: CGFloat) {
        if slider === rangeSlider {
            print("Standard slider updated. Min Value: \(minValue) Max Value: \(maxValue)")
        }/* else if slider === rangeSliderCurrency {
            print("Currency slider updated. Min Value: \(minValue) Max Value: \(maxValue)")
        } else if slider === rangeSliderCustom {
            print("Custom slider updated. Min Value: \(minValue) Max Value: \(maxValue)")
        }*/
        var maxvalues = Int(maxValue)
        var minvalues = Int(minValue)
        
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
