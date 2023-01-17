//
//  MainpostData.swift
//  HEMPDAY
//
//  Created by admin on 2/9/21.
//  Copyright © 2021 Chandradip. All rights reserved.
//

import Foundation

struct MainPost : Decodable {
    var data : [Post]
    var message : String
    var status : String
}
struct Post : Decodable {
    var subCategory : [SubPost]
    var author_name : String
    var author_image : String
    var date : String
    var post_owner_name : String
}
struct SubPost : Decodable {
    var post_id : String
    var title : String
    var content : String
    var like : String
    var dislike : String
}
