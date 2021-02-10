//
//  QuizQuestion.swift
//  HEMPDAY
//
//  Created by admin on 12/22/20.
//  Copyright © 2020 Chandradip. All rights reserved.
//

import Foundation
import UIKit

struct Quizquestion : Decodable {
    var data : [RealData]
    var message : String
    var status : String
}
struct RealData : Decodable {
    var choice : [choices]
    var option_count : Int
    var question : String
    var question_id : String
}
struct choices : Decodable {
    var choice_id : String
    var choice_option : String
}

class QuestionData {
    static let Question = QuestionData()
   var QuizQuestionArray: [Quizquestion] = []
}


class ChoiceData {
    static let QuestionChoice = ChoiceData()
   var QuizQuestionChoiceArray: [choices] = []
}

struct selectAnswer {
    static var selectQuestionID : [String] = []
    static var selectAnswerOptionID : [String] = []
}
