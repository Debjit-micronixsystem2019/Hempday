//
//  PostData.swift
//  HEMPDAY
//
//  Created by admin on 12/31/20.
//  Copyright © 2020 Chandradip. All rights reserved.
//

import Foundation
import UIKit

struct postData {
     var author_image : String
     var author_name : String
     var date : String
     var post_id : String
     var title : String
    var details : String
    init( author_image : String, author_name : String, date : String, post_id : String, title : String, details : String) {
        self.author_image = author_image
        self.author_name = author_name
        self.date = date
        self.post_id = post_id
        self.title = title
        self.details = details
    }
}
