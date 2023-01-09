//
//  TakeQuizVC.swift
//  HEMPDAY
//
//  Created by admin on 12/18/20.
//  Copyright © 2020 Chandradip. All rights reserved.
//

import UIKit
import MBProgressHUD

var HealthConcernsSkip : Bool = false

class TakeQuizVC: UIViewController {
    
    @IBOutlet weak var collectionVW : UICollectionView!{
        didSet{
            collectionVW.isHidden = true
        }
    }
    
    @IBOutlet weak var quizView : UIView!
    @IBOutlet weak var questionCounttlbl : UILabel!
    @IBOutlet weak var totalQuestionlbl : UILabel!
    @IBOutlet weak var cView : UIView!{
        didSet{
            cView.isHidden = true
        }
    }
    @IBOutlet weak var nextBtn : UIButton!{
        didSet{
            nextBtn.isHidden = true
        }
    }
    @IBOutlet weak var previousBtn : UIButton!{
        didSet{
            previousBtn.isHidden = true
        }
    }
    
    @IBOutlet weak var topConstant : NSLayoutConstraint!
    @IBOutlet weak var bottomConstant : NSLayoutConstraint!
    

    var jsonFetch = jasonDataDecodeFetchClass()
        var QuizArray : [RealData]?
        var Previouspaging : Bool = false
        var showIndex = 0
    var oneTimeIdAppendHealthConcerns : Bool = false
    
    var choiceAnswer : [choices]?

        override func viewDidLoad() {
            super.viewDidLoad()
            jsonFetch.jsondata = self
            fetcchQuestiondata()
            collectionVW.delegate = self
            collectionVW.dataSource = self
            HealthConcernsSkip = false
        }
    
    override func viewWillAppear(_ animated: Bool) {
        selectAnswer.selectQuestionID.removeAll()
        selectAnswer.selectAnswerOptionID.removeAll()
    }
    
          @IBAction func backButtonAction( _ sender : UIButton){
              self.navigationController?.popViewController(animated: true)
          }
        
        @IBAction func nextButtonAction( _ sender : UIButton){
        
            if selectAnswer.selectAnswerOptionID.count == showIndex && showIndex < QuizArray!.count-1{
                showAlertMessageokkk(alertTitle: "HEMPDAY !", alertMsg: "PLEASE SELECT AN OPTION.")
            }else{
            if showIndex < QuizArray!.count-1 {
                let indexpath = IndexPath(item: sender.tag + showIndex, section: 0)
              //  self.collectionVW.scrollToItem(at: indexpath, at: .left, animated: true)
                showIndex += 1
                questionCounttlbl.text = String(showIndex + 1)
                previousBtn.isHidden = false
                if showIndex == (QuizArray?.count ?? 7)-1{
                    nextBtn.setTitle("SUBMIT", for: .normal)
                }
                collectionVW.reloadData()
            }else{
             
                let vc = storyboard?.instantiateViewController(identifier: "PriceRangeVC") as! PriceRangeVC
                self.navigationController?.pushViewController(vc, animated: true)
                               }
            }
        }
    
    @IBAction func previousButtonAction( _ sender : UIButton){
         
        if showIndex >= 1{
           let indexpath = IndexPath(item: sender.tag - 1, section: 0)
         ///  self.collectionVW.scrollToItem(at: indexpath, at: .right, animated: true)
              
            questionCounttlbl.text = String(showIndex)
            print("previous",showIndex)
            
            if showIndex < QuizArray!.count-1 {
                nextBtn.setTitle("NEXT", for: .normal)
            }
            if showIndex == 1{
                previousBtn.isHidden = true
            }
            showIndex -= 1
            collectionVW.reloadData()
       
        }
       }
    
        @IBAction func leftPagingButtonAction( _ sender : UIButton){
          
            if selectAnswer.selectAnswerOptionID.count == showIndex && showIndex < QuizArray!.count-1{
                showAlertMessageokkk(alertTitle: "HEMPDAY !", alertMsg: "PLEASE SELECT AN OPTION.")
            }else{
            if showIndex < QuizArray!.count-1 {
                if HealthConcernsSkip == true && showIndex == 2{
                    let indexpath = IndexPath(item: sender.tag + showIndex + 1, section: 0)
                    print("indexpath",indexpath)
                //    self.collectionVW.scrollToItem(at: indexpath, at: .left, animated: true)
                    showIndex += 2
                    questionCounttlbl.text = String(showIndex + 1)
                    if oneTimeIdAppendHealthConcerns == false{
                    selectAnswer.selectQuestionID.append("4")
                    selectAnswer.selectAnswerOptionID.append("0")
                        oneTimeIdAppendHealthConcerns = true
                    }
                    HealthConcernsSkip = false
                    Previouspaging = true
                    print("showIndex",showIndex)
                }else{
                    let indexpath = IndexPath(item: sender.tag + showIndex, section: 0)
                    print("indexpath",indexpath)
                //    self.collectionVW.scrollToItem(at: indexpath, at: .left, animated: true)
                    
                    showIndex += 1
                    print("showIndex",showIndex)
                    questionCounttlbl.text = String(showIndex + 1)
                }
              /*  previousBtn.isHidden = false
                if showIndex == (QuizArray?.count ?? 7)-1{
                    nextBtn.setTitle("SUBMIT", for: .normal)
                }*/
                collectionVW.reloadData()
            }else{
             
                let vc = storyboard?.instantiateViewController(identifier: "PriceRangeVC") as! PriceRangeVC
                self.navigationController?.pushViewController(vc, animated: true)
                               }
            }
        }
        
        @IBAction func rightPagingButtonAction( _ sender : UIButton){
             if showIndex >= 1{
               if Previouspaging == true && showIndex == 4{
                    let indexpath = IndexPath(item: sender.tag - 1, section: 0)
                   // self.collectionVW.scrollToItem(at: indexpath, at: .right, animated: true)
                    showIndex -= 2
                    questionCounttlbl.text = String(showIndex + 1)
                    
                Previouspaging = false
                HealthConcernsSkip = true
                }else{
                    let indexpath = IndexPath(item: sender.tag - 1, section: 0)
                  //  self.collectionVW.scrollToItem(at: indexpath, at: .right, animated: true)
                    questionCounttlbl.text = String(showIndex)
                    showIndex -= 1
                }
                
                   print("showIndex",showIndex)
             //    questionCounttlbl.text = String(showIndex)
             //    print("previous",showIndex)
                 
              /*   if showIndex < QuizArray!.count-1 {
                     nextBtn.setTitle("NEXT", for: .normal)
                 }
                 if showIndex == 1{
                     previousBtn.isHidden = true
                 }*/
              //   showIndex -= 1
                 collectionVW.reloadData()
            
             }
           }
        
        func fetcchQuestiondata() {
               let param = [
                   "authorised_key":"SGVtcERheTIwMjAj",
                    "user_id":"1"
                    ]
               print("param",param)
               MBProgressHUD.showAdded(to: (self.view)!, animated: true)
               jsonFetch.fetchData(param, methodtype: "post", url: baseUrl + "/get_question", jsonname: "get_question")
           }

    }
    extension TakeQuizVC : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
        func numberOfSections(in collectionView: UICollectionView) -> Int {
            return 1
        }
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 1
           }
           
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionVW.dequeueReusableCell(withReuseIdentifier: "QuizCell", for: indexPath) as! QuizCell
            let quiezes = self.QuizArray?[showIndex]
            cell.quesLbl.text = quiezes?.question
            cell.setUpAnswer(choice: quiezes?.choice ?? [])
            cell.questionId = quiezes?.question_id
            
            if quiezes?.question == "HEALTH CONCERNS (SELECT ALL APPLY)" || quiezes?.question == "WHAT ARE YOUR TASTE BUDS FEELING (SELECT ALL THAT APPLY)"{
                cell.textShawButton.isHidden = true
                cell.multiSelectOption = true
            }else{
                cell.textShawButton.isHidden = true
                cell.textView.isHidden = true
                cell.multiSelectOption = false
            }
            if quiezes?.question == "PRICE RANGE"{
                cell.quizOptionTableVW.isHidden = true
                cell.slideView.isHidden = false
            }else{
                cell.quizOptionTableVW.isHidden = false
                cell.slideView.isHidden = true
            }
                
                cell.ViewHeight = view.frame.size.height
      
            return cell
        }
        
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print("height",view.frame.size.height)
        var collectionViewHeightDynamically = CGFloat()
         let quiezes = self.QuizArray?[showIndex]
        // Big Screen
        if view.frame.size.height > 812{
            if quiezes?.option_count == 3{
//                topConstant.constant = 140.0
//                bottomConstant.constant = 70.0
//                collectionViewHeightDynamically = 300.0
                
                topConstant.constant = 120.0
                bottomConstant.constant = 10.0
                collectionViewHeightDynamically = 180.0
            }else{
                topConstant.constant = 55.0
                 bottomConstant.constant = 10.0
                 collectionViewHeightDynamically = 180.0
                }
            }else{
                if quiezes?.option_count == 3{
//                    topConstant.constant = 140.0
//                    bottomConstant.constant = 50.0
//                    collectionViewHeightDynamically = 280
                    
//                    topConstant.constant = 80.0
//                    bottomConstant.constant = 60.0
//                    collectionViewHeightDynamically = 230.0
                    
                    topConstant.constant = 90.0
                    bottomConstant.constant = 30.0
                    collectionViewHeightDynamically = 180.0
                }else{
                    topConstant.constant = 50.0
                    bottomConstant.constant = 10.0
                    collectionViewHeightDynamically = 180.0
                    }
            }
        
        return CGSize(width: view.frame.size.width, height: quizView.frame.size.height - collectionViewHeightDynamically)
        }
    }

    extension TakeQuizVC : jsonDecodeDataDelegate {
        func didRecivedDataFormat(_ data: Data, jsonname: String) {
            DispatchQueue.main.async { MBProgressHUD.hide(for: (self.view)!, animated: true) }
            do{
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(Quizquestion.self, from: data)
                print(jsonData.message)
                self.QuizArray = jsonData.data
                if jsonData.data.count > 0{
                    collectionVW.isHidden = false
                    cView.isHidden = false
                     nextBtn.isHidden = false
                    
                    totalQuestionlbl.text = String(jsonData.data.count)
                    collectionVW.reloadData()
                }

            }catch{
                print(error.localizedDescription)
            }
        }
        
        func didReceivedData(_ data: Any, jsonname: String) {
            print("Raw Data>>",data)
            print("Jsonname>>",jsonname)
            DispatchQueue.main.async { MBProgressHUD.hide(for: (self.view)!, animated: true) }
            if data as? String ==  "NO INTERNET CONNECTION" {
                showAlertMessageokkk(alertTitle: "NETWORK !", alertMsg: "CHECK YOUR INTERNET CONNECTION PLEASE")
            } else {
                print(data as! NSDictionary)
                
                /* if ((data as! NSDictionary).object(forKey: "status") as! String) == "Yes" {
                    
                    QuestionData.Question.QuizQuestionArray.removeAll()
                    if let userData = (data as AnyObject).object(forKey: "data") as? NSArray{
                           
                        for (Aindex,eachData) in userData.enumerated() {
                            guard let eachdataitem = eachData as? [String : Any] else {return}
                            
                            
                            guard let choice = eachdataitem["choice"] as? [choices] else {return}
                            guard let option_count = eachdataitem["option_count"] as? Int else {return}
                            guard let question = eachdataitem["question"] as? String else {return}
                            guard let question_id = eachdataitem["question_id"] as? String else {return}
                            
                            QuestionData.Question.QuizQuestionArray.append(Quizquestion(choice: choice, option_count: option_count, question: question, question_id: question_id))
                            
                        }
                        print("QuizQuestionArray>>", QuestionData.Question.QuizQuestionArray)
                        collectionVW.isHidden = false
                        cView.isHidden = false
                        totalQuestionlbl.text = String(QuestionData.Question.QuizQuestionArray.count)
                        collectionVW.reloadData()
                             }
                    
                    
                } else {
                    if ((data as! NSDictionary).object(forKey: "status") as! String) == "No" {
                        showAlertMessageokkk(alertTitle: "HEMPDAY !", alertMsg: "")
                    }else{
                    //Alert here..
                    showAlertMessageokkk(alertTitle: "HEMPDAY !", alertMsg: "SOMETHING GOING WRONG,TRY LATTER")
                    }
                }*/
            }
        }
        
        func didFailedReceivedData(_ error: Error) {
            print(error.localizedDescription)
            DispatchQueue.main.async { MBProgressHUD.hide(for: (self.view)!, animated: true) }
            showAlertMessageokkk(alertTitle: "HEMPDAY !", alertMsg: "PLEASE TRY AGAIN LATER.")
        }
    }
